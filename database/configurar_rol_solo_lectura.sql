-- Laboratorio #3: rol PostgreSQL de solo lectura para el agente n8n
-- Gestor: PostgreSQL / Supabase
-- IMPORTANTE: ejecutar manualmente como administrador después de revisar el nombre del rol.
-- Este archivo no crea ni almacena contraseñas.

BEGIN;

DO $crear_rol$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'n8n_aduana_lectura') THEN
        CREATE ROLE n8n_aduana_lectura
            LOGIN
            NOINHERIT
            NOSUPERUSER
            NOCREATEDB
            NOCREATEROLE
            NOREPLICATION
            NOBYPASSRLS;
    ELSE
        ALTER ROLE n8n_aduana_lectura
            LOGIN
            NOINHERIT
            NOSUPERUSER
            NOCREATEDB
            NOCREATEROLE
            NOREPLICATION
            NOBYPASSRLS;
    END IF;
END
$crear_rol$;

-- Elimina membresías que podrían permitir SET ROLE hacia un rol más privilegiado.
DO $quitar_membresias$
DECLARE
    membresia RECORD;
BEGIN
    FOR membresia IN
        SELECT rol_padre.rolname AS nombre_rol
        FROM pg_auth_members AS m
        JOIN pg_roles AS rol_padre ON rol_padre.oid = m.roleid
        JOIN pg_roles AS miembro ON miembro.oid = m.member
        WHERE miembro.rolname = 'n8n_aduana_lectura'
    LOOP
        EXECUTE format(
            'REVOKE %I FROM n8n_aduana_lectura',
            membresia.nombre_rol
        );
    END LOOP;
END
$quitar_membresias$;

-- Parte de una lista explícita de privilegios. Los REVOKE no modifican otros roles.
REVOKE ALL PRIVILEGES ON SCHEMA public FROM n8n_aduana_lectura;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM n8n_aduana_lectura;
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public FROM n8n_aduana_lectura;

GRANT CONNECT ON DATABASE postgres TO n8n_aduana_lectura;
GRANT USAGE ON SCHEMA public TO n8n_aduana_lectura;

GRANT SELECT ON TABLE
    public.importador,
    public.agente_aduanal,
    public.pais,
    public.partida_arancelaria,
    public.producto,
    public.funcionario,
    public.bodega,
    public.declaracion,
    public.detalle_declaracion,
    public.contenedor,
    public.inventario_bodega,
    public.inspeccion,
    public.movimiento_inventario
TO n8n_aduana_lectura;

-- No se otorgan privilegios predeterminados sobre tablas futuras.
ALTER ROLE n8n_aduana_lectura SET search_path = public, pg_catalog;
ALTER ROLE n8n_aduana_lectura SET statement_timeout = '15s';
ALTER ROLE n8n_aduana_lectura SET idle_in_transaction_session_timeout = '15s';
ALTER ROLE n8n_aduana_lectura SET default_transaction_read_only = on;

-- Cancela toda la configuración si privilegios heredados de PUBLIC u otra
-- fuente permiten escribir en las tablas o crear objetos en el esquema.
DO $comprobar_aislamiento$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM pg_tables AS t
        WHERE t.schemaname = 'public'
          AND t.tablename IN (
              'importador', 'agente_aduanal', 'pais', 'partida_arancelaria',
              'producto', 'funcionario', 'bodega', 'declaracion',
              'detalle_declaracion', 'contenedor', 'inventario_bodega',
              'inspeccion', 'movimiento_inventario'
          )
          AND has_table_privilege(
              'n8n_aduana_lectura',
              format('public.%I', t.tablename),
              'INSERT,UPDATE,DELETE,TRUNCATE,REFERENCES,TRIGGER'
          )
    ) THEN
        RAISE EXCEPTION
            'El rol conserva privilegios de escritura heredados. Revise los GRANT a PUBLIC antes de continuar.';
    END IF;

    IF has_schema_privilege('n8n_aduana_lectura', 'public', 'CREATE') THEN
        RAISE EXCEPTION
            'El rol conserva CREATE sobre public. Revise los privilegios heredados antes de continuar.';
    END IF;
END
$comprobar_aislamiento$;

COMMIT;

-- ============================================================
-- VERIFICACIÓN: ejecutar después del bloque anterior.
-- ============================================================

-- 1. Debe mostrar atributos administrativos en false y NOINHERIT.
SELECT
    rolname,
    rolcanlogin,
    rolsuper,
    rolinherit,
    rolcreatedb,
    rolcreaterole,
    rolreplication,
    rolbypassrls
FROM pg_roles
WHERE rolname = 'n8n_aduana_lectura';

-- 2. Debe devolver cero filas: el rol no debe pertenecer a otros roles.
SELECT rol_padre.rolname AS membresia_inesperada
FROM pg_auth_members AS m
JOIN pg_roles AS rol_padre ON rol_padre.oid = m.roleid
JOIN pg_roles AS miembro ON miembro.oid = m.member
WHERE miembro.rolname = 'n8n_aduana_lectura';

-- 3. Cada tabla debe mostrar SELECT=true y los demás privilegios=false.
SELECT
    t.tablename,
    has_table_privilege('n8n_aduana_lectura', format('public.%I', t.tablename), 'SELECT') AS puede_select,
    has_table_privilege('n8n_aduana_lectura', format('public.%I', t.tablename), 'INSERT') AS puede_insert,
    has_table_privilege('n8n_aduana_lectura', format('public.%I', t.tablename), 'UPDATE') AS puede_update,
    has_table_privilege('n8n_aduana_lectura', format('public.%I', t.tablename), 'DELETE') AS puede_delete,
    has_table_privilege('n8n_aduana_lectura', format('public.%I', t.tablename), 'TRUNCATE') AS puede_truncate,
    has_table_privilege('n8n_aduana_lectura', format('public.%I', t.tablename), 'REFERENCES') AS puede_references,
    has_table_privilege('n8n_aduana_lectura', format('public.%I', t.tablename), 'TRIGGER') AS puede_trigger
FROM pg_tables AS t
WHERE t.schemaname = 'public'
  AND t.tablename IN (
      'importador', 'agente_aduanal', 'pais', 'partida_arancelaria',
      'producto', 'funcionario', 'bodega', 'declaracion',
      'detalle_declaracion', 'contenedor', 'inventario_bodega',
      'inspeccion', 'movimiento_inventario'
  )
ORDER BY t.tablename;

-- 4. Debe mostrar USAGE=true y CREATE=false para el esquema public.
SELECT
    has_schema_privilege('n8n_aduana_lectura', 'public', 'USAGE') AS puede_usar_esquema,
    has_schema_privilege('n8n_aduana_lectura', 'public', 'CREATE') AS puede_crear_en_esquema;

-- 5. Debe devolver cero filas. Si devuelve algo, revisar esa función antes de usar el rol.
SELECT
    n.nspname AS esquema,
    p.proname AS funcion_security_definer
FROM pg_proc AS p
JOIN pg_namespace AS n ON n.oid = p.pronamespace
WHERE n.nspname = 'public'
  AND p.prosecdef
  AND has_function_privilege(
      'n8n_aduana_lectura',
      p.oid,
      'EXECUTE'
  );

-- 6. Prueba manual segura con la credencial nueva:
--    SELECT current_user, current_setting('default_transaction_read_only');
-- Debe devolver n8n_aduana_lectura y "on".
-- Luego intentar, dentro de una transacción que se revierte:
--    BEGIN;
--    INSERT INTO public.pais (nombre, codigo_iso) VALUES ('PRUEBA', 'ZZ');
--    ROLLBACK;
-- El INSERT debe fallar por transacción de solo lectura o falta de privilegios.

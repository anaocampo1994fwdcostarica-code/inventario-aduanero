# Guía de configuración y pruebas

Esta guía separa las tareas locales ya preparadas de las acciones que requieren acceso a Supabase y n8n. No contiene credenciales reales.

## 1. Configurar el rol de solo lectura en Supabase

1. Haga una copia de seguridad o confirme que dispone de un punto de restauración del proyecto.
2. Entre al panel de Supabase y abra el proyecto `inventario-aduanero`.
3. Abra **SQL Editor** y cree una consulta nueva.
4. Copie el contenido de `../database/configurar_rol_solo_lectura.sql`.
5. Revise que el nombre `n8n_aduana_lectura` no coincida con un rol usado por otra aplicación.
6. Ejecute el bloque completo. Este crea o endurece el rol, elimina membresías heredadas, revoca privilegios directos y concede `SELECT` únicamente sobre las 13 tablas del laboratorio.
7. Revise los resultados de verificación incluidos al final del script:
   - atributos administrativos en `false`;
   - `rolinherit` en `false`;
   - cero membresías;
   - `SELECT=true` y escritura, truncado y trigger en `false` para las 13 tablas;
   - `USAGE=true` y `CREATE=false` en el esquema `public`;
   - cero funciones `SECURITY DEFINER` accesibles en `public`.
8. En una consulta separada que no se guardará en el repositorio, asigne una contraseña fuerte y exclusiva:

   ```sql
   ALTER ROLE n8n_aduana_lectura
   PASSWORD 'REEMPLACE_ESTO_POR_UNA_CLAVE_NUEVA_Y_UNICA';
   ```

9. No use la contraseña del usuario administrador `postgres` en n8n.
10. Obtenga host, puerto y base desde **Connect** en Supabase. Use conexión directa para un n8n persistente o **Session pooler** si su red no admite IPv6. Active SSL; como mínimo `require`, o `verify-full` si n8n permite cargar el certificado de Supabase.

### Comprobación segura de permisos

Conéctese usando el rol nuevo y ejecute:

```sql
SELECT current_user, current_setting('default_transaction_read_only');
SELECT COUNT(*) FROM public.declaracion;
```

Debe aparecer `n8n_aduana_lectura`, modo `on` y la consulta debe devolver 15 declaraciones.

Después pruebe una escritura dentro de una transacción destinada a revertirse:

```sql
BEGIN;
INSERT INTO public.pais (nombre, codigo_iso) VALUES ('PRUEBA', 'ZZ');
ROLLBACK;
```

El `INSERT` debe fallar. Compruebe además que no existe el país `PRUEBA`. Si el `INSERT` funciona, no conecte el agente: revise privilegios otorgados a `PUBLIC`, membresías del rol y el resultado de las consultas de verificación.

## 2. Importar y configurar n8n

1. En n8n, abra **Overview** y seleccione **Import from File**.
2. Importe `n8n/Ocampo_Ana_Agente_Lab3.json`.
3. Confirme que aparecen cinco nodos: Chat Trigger, AI Agent, DeepSeek Chat Model, Simple Memory y Consultar Supabase (PostgreSQL).
4. Abra **Credentials** y cree una credencial PostgreSQL nueva.
5. Use exclusivamente el usuario `n8n_aduana_lectura`, su contraseña nueva, el host y puerto de Supabase, base `postgres` y SSL activado.
6. Abra el nodo **Consultar Supabase (PostgreSQL)** y sustituya la referencia importada por la credencial nueva de solo lectura. No modifique la credencial antigua.
7. Abra el nodo **DeepSeek Chat Model** y seleccione su credencial existente de DeepSeek.
8. Guarde el workflow, pero no lo publique todavía.
9. Ejecute primero la comprobación de lectura y denegación de escritura del apartado anterior.
10. Ejecute las ocho preguntas del apartado siguiente. Publique el workflow solo si todas coinciden con los resultados esperados.
11. Cuando termine, use el menú del workflow para descargar/exportar la versión configurada y guárdela como `Ocampo_Ana_Agente_Lab3.json`. Antes de reemplazar el entregable, abra el JSON como texto y confirme que solo contiene referencias de credenciales, nunca contraseñas ni claves API.

La consulta dinámica del nodo Postgres es considerada riesgosa por la auditoría de seguridad de n8n. El control decisivo es el rol PostgreSQL de solo lectura, junto con `default_transaction_read_only=on`; el prompt es una defensa adicional, no el límite de seguridad principal.

## 3. Ocho pruebas obligatorias del agente

Las consultas de referencia completas están en `../database/pruebas_agente_lab3.sql`.

1. Pregunte: **¿Cuántas declaraciones de importación se registraron en octubre de 2026?**
   - Esperado: 8 declaraciones.
2. Pregunte: **¿Qué mercancías siguen retenidas y en qué bodega están?**
   - Esperado: 7 registros retenidos. Debe indicar producto, cantidad, unidad y bodega.
3. Pregunte: **¿Cuál es el país de origen con más contenedores recibidos?**
   - Esperado: empate de los 15 países, con 1 contenedor cada uno. No debe inventar un ganador único.
4. Pregunte: **¿Qué importador ha declarado el mayor valor total?**
   - Esperado: Importadora Central S.A., 93500.00.
5. Pregunte: **¿Qué inspecciones tuvieron resultado "Con observaciones" y quién las realizó?**
   - Esperado: 4 inspecciones, correspondientes a DUA-2026-0001, 0006, 0009 y 0013.
6. Pregunte: **¿Cuánto stock queda de Computadora portátil en todas las bodegas?**
   - Esperado: 205 unidades en Bodega Aduanera 15, cero en las demás, total 205 unidades.
7. Pregunte: **¿Qué mercancías están almacenadas en Bodega Aduanera 10?**
   - Esperado: Aceite de soja en bruto, 170 litros, estado Retenido.
8. Pregunte: **¿Cuántos registros de inventario están liberados y cuántos retenidos?**
   - Esperado: 5 registros liberados y 7 retenidos. Debe hablar de registros de inventario, no de declaraciones ni sumar unidades incompatibles.

## 4. Capturas que deben generarse manualmente

Guarde las nuevas capturas en `Ocampo_Ana_Evidencia_Lab3/agente/`:

1. `agente-01-importaciones-octubre.png`
2. `agente-02-mercancias-retenidas-bodega.png`
3. `agente-03-pais-mas-contenedores.png`
4. `agente-04-importador-mayor-valor.png`
5. `agente-05-inspecciones-con-observaciones.png`
6. `agente-06-stock-computadora-todas-bodegas.png`
7. `agente-07-mercancias-bodega-10.png`
8. `agente-08-inventario-liberado-retenido.png`
9. `seguridad-01-permisos-rol.png`: resultado de la verificación de privilegios.
10. `seguridad-02-escritura-denegada.png`: error de escritura con el rol de n8n, sin mostrar la contraseña.
11. `workflow-n8n-final.png`: vista completa del workflow con los cinco nodos conectados.

Cada captura del agente debe mostrar la pregunta, la respuesta completa y la ejecución exitosa. Oculte host, usuario, contraseñas, tokens, cadenas de conexión y claves API.

## 5. Recomendación sobre los datos

Los datos actuales cumplen el mínimo académico, pero cada país tiene exactamente un contenedor. Esto produce un empate legítimo en la prueba 3. Si el docente espera un ganador único, agregue datos adicionales solamente después de consultar si se permite superar los 15 registros; cualquier cambio debe mantenerse sincronizado en `datos_prueba.sql`, el script combinado y las respuestas esperadas.

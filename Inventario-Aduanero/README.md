# Laboratorio 3: Sistema de Inventario Aduanero

Proyecto académico de Bases de Datos para registrar información aduanera y consultarla mediante un agente de IA en n8n.

## Entregables

- `investigacion/Ocampo_Ana_Investigacion_Lab3.pdf`: investigación de 5 páginas y apartado de uso de IA.
- `diagrama/Ocampo_Ana_DER_Lab3.png`: diagrama Entidad-Relación entregable.
- `sql/Ocampo_Ana_Aduana_Lab3.sql`: script combinado con 13 tablas, 15 registros por tabla y 8 consultas.
- `n8n/Ocampo_Ana_Agente_Lab3.json`: workflow exportado de n8n.
- `Ocampo_Ana_Evidencia_Lab3/`: capturas del proyecto; las ocho evidencias principales, dos continuaciones, dos comprobaciones de seguridad y el workflow final están organizados en `agente/`.

## Archivos técnicos de apoyo

En `../database/` se conservan los componentes separados y los scripts de seguridad y prueba:

- `crear_tablas.sql`: estructura PostgreSQL.
- `datos_prueba.sql`: datos de prueba.
- `consultas.sql`: ocho consultas de negocio.
- `configurar_rol_solo_lectura.sql`: rol de mínimo privilegio para n8n; no se ejecuta automáticamente.
- `pruebas_agente_lab3.sql`: consultas y resultados esperados de las ocho preguntas obligatorias.

## Puesta en marcha

1. Ejecutar `sql/Ocampo_Ana_Aduana_Lab3.sql` en una base PostgreSQL vacía.
2. Revisar y ejecutar manualmente `../database/configurar_rol_solo_lectura.sql` con una cuenta administradora.
3. Asignar una contraseña nueva al rol `n8n_aduana_lectura` sin guardarla en el repositorio.
4. Importar `n8n/Ocampo_Ana_Agente_Lab3.json` en n8n.
5. Crear una credencial PostgreSQL para ese rol de solo lectura y seleccionarla en el nodo de consulta.
6. Ejecutar las ocho pruebas descritas en `GUIA_CONFIGURACION_Y_PRUEBAS.md`.

## Estado verificado del agente

El workflow entregable fue probado en n8n con Supabase PostgreSQL, SSL y DeepSeek. El nodo PostgreSQL referencia la credencial `Postgres account 2`, configurada con el usuario de solo lectura `n8n_aduana_lectura`.

Las pruebas confirmaron 8 importaciones en octubre de 2026, 7 registros retenidos, empate entre 15 contenedores con un registro de mercancía cada uno, Importadora Central S.A. con US$93 500 declarados, 4 inspecciones con resultado `Con observaciones`, 205 computadoras portátiles retenidas en Bodega Aduanera 15, 170 litros de aceite de soja en Bodega Aduanera 10, y 5 registros de inventario liberados frente a 7 retenidos.

El workflow conserva reglas explícitas para interpretar inspecciones por `resultado = 'Con observaciones'` y para reportar empates al contar registros de mercancías por contenedor.

No se incluyen contraseñas, tokens ni claves API en los entregables.

## Auditoría final de evidencias

Las ocho evidencias principales del agente, las dos capturas de continuación, las dos comprobaciones de seguridad y la vista final del workflow se validaron como imágenes PNG legibles y están disponibles con los nombres exigidos en `Ocampo_Ana_Evidencia_Lab3/agente/`. Las continuaciones completan las evidencias 03 y 06. Las capturas originales de seguridad son válidas para el laboratorio: la guía no exige ocultar el host de Supabase y no contienen contraseñas ni claves API. Consulte `Ocampo_Ana_Evidencia_Lab3/LEEME_EVIDENCIAS.md` para el detalle.

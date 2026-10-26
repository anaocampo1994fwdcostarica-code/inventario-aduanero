# Evidencias del Laboratorio 3

Las ocho evidencias principales del agente, sus dos capturas de continuación, las dos comprobaciones de seguridad y la vista final del workflow están organizadas en `agente/`, conforme a `../GUIA_CONFIGURACION_Y_PRUEBAS.md`. Las capturas históricas se conservan sin edición.

| Archivo | Estado de auditoría |
| --- | --- |
| `agente-01-importaciones-octubre.png` | Conforme: 8 importaciones en octubre de 2026. |
| `agente-02-mercancias-retenidas-bodega.png` | Conforme: 7 mercancías retenidas, con producto, cantidad, unidad y bodega. |
| `agente-03-pais-mas-contenedores.png` | Conforme junto con su continuación: empate de 15 países, con un contenedor cada uno. |
| `agente-03-pais-mas-contenedores-continuacion.png` | Conforme: muestra la pregunta y la ejecución exitosa de la evidencia 03. |
| `agente-04-importador-mayor-valor.png` | Conforme: Importadora Central S.A., US$93 500.00. |
| `agente-05-inspecciones-con-observaciones.png` | Conforme: 4 inspecciones con resultado `Con observaciones`. |
| `agente-06-stock-computadora-todas-bodegas.png` | Conforme junto con su continuación: 205 unidades en Bodega Aduanera 15 y cero en las demás. |
| `agente-06-stock-computadora-todas-bodegas-continuacion.png` | Conforme: muestra la pregunta y la ejecución exitosa de la evidencia 06. |
| `agente-07-mercancias-bodega-10.png` | Conforme: aceite de soja en bruto, 170 litros, estado Retenido. |
| `agente-08-inventario-liberado-retenido.png` | Conforme: 5 registros liberados y 7 retenidos. |
| `seguridad-01-permisos-rol.png` | Conforme: lectura permitida y escritura denegada para el rol de solo lectura. |
| `seguridad-02-escritura-denegada.png` | Conforme: intento de `INSERT` denegado en transacción de solo lectura. |
| `workflow-n8n-final.png` | Conforme: se ven los cinco nodos requeridos conectados. |

La captura original con el nombre `agente-02-mercancias-retenidas-bodega.png..png` se conserva. La copia con el nombre canónico requerido contiene el mismo contenido.

Las capturas originales de seguridad son válidas para el laboratorio. La guía no exige ocultar el host de Supabase; sí se verificó que no exponen contraseñas, tokens ni claves API. Las ocho evidencias principales y las dos continuaciones están completas.

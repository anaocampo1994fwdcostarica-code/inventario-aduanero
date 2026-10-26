-- Laboratorio #3: consultas de referencia para las ocho pruebas del agente
-- Estas consultas son de solo lectura y corresponden a datos_prueba.sql.

-- 1. ¿Cuántas declaraciones de importación se registraron en octubre de 2026?
-- Resultado esperado: 8 declaraciones.
SELECT COUNT(*) AS declaraciones_importacion_octubre_2026
FROM declaracion
WHERE regimen = 'Importacion'
  AND fecha >= DATE '2026-10-01'
  AND fecha < DATE '2026-11-01';

-- 2. ¿Qué mercancías siguen retenidas y en qué bodega están?
-- Resultado esperado: 7 registros de inventario retenidos.
SELECT
    pr.descripcion AS mercancia,
    pr.unidad_medida,
    ib.cantidad,
    b.nombre AS bodega,
    b.ubicacion
FROM inventario_bodega AS ib
JOIN producto AS pr ON pr.id_producto = ib.id_producto
JOIN bodega AS b ON b.id_bodega = ib.id_bodega
WHERE ib.estado = 'Retenido'
ORDER BY b.id_bodega, pr.descripcion;

-- 3. ¿Cuál es el país de origen con más contenedores recibidos?
-- Resultado esperado: empate entre los 15 países, con 1 contenedor cada uno.
WITH contenedores_por_pais AS (
    SELECT
        p.id_pais,
        p.nombre AS pais_origen,
        COUNT(c.id_contenedor) AS contenedores
    FROM pais AS p
    JOIN declaracion AS d ON d.id_pais_origen = p.id_pais
    JOIN contenedor AS c ON c.id_declaracion = d.id_declaracion
    GROUP BY p.id_pais, p.nombre
), maximo AS (
    SELECT MAX(contenedores) AS cantidad_maxima
    FROM contenedores_por_pais
)
SELECT cpp.pais_origen, cpp.contenedores
FROM contenedores_por_pais AS cpp
CROSS JOIN maximo AS m
WHERE cpp.contenedores = m.cantidad_maxima
ORDER BY cpp.pais_origen;

-- 4. ¿Qué importador ha declarado el mayor valor total?
-- Resultado esperado: Importadora Central S.A., 93500.00.
SELECT
    i.razon_social AS importador,
    SUM(dd.valor_declarado) AS valor_total_declarado
FROM importador AS i
JOIN declaracion AS d ON d.id_importador = i.id_importador
JOIN detalle_declaracion AS dd ON dd.id_declaracion = d.id_declaracion
GROUP BY i.id_importador, i.razon_social
ORDER BY valor_total_declarado DESC
LIMIT 1;

-- 5. ¿Qué inspecciones tuvieron resultado "Con observaciones" y quién las realizó?
-- Resultado esperado: 4 inspecciones (DUA 0001, 0006, 0009 y 0013).
SELECT
    ins.id_inspeccion,
    ins.fecha,
    d.numero AS declaracion,
    ins.observaciones,
    f.nombre AS funcionario,
    f.cargo
FROM inspeccion AS ins
JOIN declaracion AS d ON d.id_declaracion = ins.id_declaracion
JOIN funcionario AS f ON f.id_funcionario = ins.id_funcionario
WHERE ins.resultado = 'Con observaciones'
ORDER BY ins.fecha, ins.id_inspeccion;

-- 6. Ejemplo: stock de "Computadora portátil" en todas las bodegas.
-- Resultado esperado: 205 unidades en Bodega Aduanera 15 y 0 en las otras;
-- la columna stock_total muestra 205 en todas las filas.
SELECT
    pr.descripcion AS producto,
    pr.unidad_medida,
    b.nombre AS bodega,
    COALESCE(ib.cantidad, 0) AS stock_en_bodega,
    SUM(COALESCE(ib.cantidad, 0)) OVER (
        PARTITION BY pr.id_producto
    ) AS stock_total
FROM producto AS pr
CROSS JOIN bodega AS b
LEFT JOIN inventario_bodega AS ib
    ON ib.id_producto = pr.id_producto
   AND ib.id_bodega = b.id_bodega
WHERE pr.descripcion = 'Computadora portátil'
ORDER BY b.id_bodega;

-- 7. Ejemplo: mercancías almacenadas en "Bodega Aduanera 10".
-- Resultado esperado: Aceite de soja en bruto, 170 litros, estado Retenido.
SELECT
    b.nombre AS bodega,
    pr.descripcion AS mercancia,
    ib.cantidad,
    pr.unidad_medida,
    ib.estado,
    ib.fecha_ingreso
FROM inventario_bodega AS ib
JOIN bodega AS b ON b.id_bodega = ib.id_bodega
JOIN producto AS pr ON pr.id_producto = ib.id_producto
WHERE b.nombre = 'Bodega Aduanera 10'
ORDER BY pr.descripcion;

-- 8. ¿Cuántos registros están liberados y cuántos retenidos?
-- Resultado esperado: Liberado=5 y Retenido=7.
-- Se cuentan registros y productos distintos; no se suman cantidades físicas
-- porque existen unidades de medida incompatibles.
SELECT
    ib.estado,
    COUNT(*) AS registros_inventario,
    COUNT(DISTINCT ib.id_producto) AS productos_distintos
FROM inventario_bodega AS ib
WHERE ib.estado IN ('Liberado', 'Retenido')
GROUP BY ib.estado
ORDER BY ib.estado;

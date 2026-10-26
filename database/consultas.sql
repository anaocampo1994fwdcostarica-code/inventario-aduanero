-- 1. Declaraciones con importador, agente aduanal y país de origen
SELECT
    d.numero AS declaracion,
    d.fecha,
    d.regimen,
    d.estado,
    i.razon_social AS importador,
    a.nombre AS agente_aduanal,
    p.nombre AS pais_origen
FROM declaracion AS d
JOIN importador AS i ON d.id_importador = i.id_importador
JOIN agente_aduanal AS a ON d.id_agente = a.id_agente
JOIN pais AS p ON d.id_pais_origen = p.id_pais
ORDER BY d.fecha DESC;


-- 2. Declaraciones que requieren atención
SELECT numero, fecha, regimen, estado
FROM declaracion
WHERE estado IN ('Retenida', 'En revision', 'Rechazada')
ORDER BY fecha;


-- 3. Cantidad de declaraciones agrupadas por estado
SELECT estado, COUNT(*) AS cantidad
FROM declaracion
GROUP BY estado
ORDER BY cantidad DESC;


-- 4. Productos con su partida arancelaria y porcentaje de arancel
SELECT
    pr.descripcion AS producto,
    pr.unidad_medida,
    pr.valor_unitario,
    pa.codigo AS codigo_partida,
    pa.descripcion AS descripcion_partida,
    pa.porcentaje_arancel
FROM producto AS pr
JOIN partida_arancelaria AS pa ON pr.id_partida = pa.id_partida
ORDER BY pa.codigo;


-- 5. Mercancías declaradas con un valor superior a 100
SELECT
    d.numero AS declaracion,
    pr.descripcion AS producto,
    dd.cantidad,
    dd.valor_declarado
FROM detalle_declaracion AS dd
JOIN declaracion AS d ON dd.id_declaracion = d.id_declaracion
JOIN producto AS pr ON dd.id_producto = pr.id_producto
WHERE dd.valor_declarado > 100
ORDER BY dd.valor_declarado DESC;


-- 6. Existencias por bodega y unidad de medida
-- No mezcla en una misma suma kilogramos, cajas, botellas u otras unidades.
SELECT
    b.nombre AS bodega,
    b.ubicacion,
    pr.unidad_medida,
    SUM(ib.cantidad) AS cantidad_almacenada
FROM inventario_bodega AS ib
JOIN bodega AS b ON ib.id_bodega = b.id_bodega
JOIN producto AS pr ON ib.id_producto = pr.id_producto
GROUP BY b.id_bodega, b.nombre, b.ubicacion, pr.unidad_medida
ORDER BY cantidad_almacenada DESC;


-- 7. Inspecciones con su declaración y funcionario responsable
SELECT
    d.numero AS declaracion,
    ins.fecha,
    ins.resultado,
    ins.observaciones,
    f.nombre AS funcionario
FROM inspeccion AS ins
JOIN declaracion AS d ON ins.id_declaracion = d.id_declaracion
JOIN funcionario AS f ON ins.id_funcionario = f.id_funcionario
WHERE ins.resultado IN ('Con observaciones', 'Pendiente', 'Rechazada')
ORDER BY ins.fecha DESC;


-- 8. Movimientos de inventario agrupados por tipo
SELECT
    mi.tipo,
    COUNT(*) AS cantidad_movimientos,
    SUM(mi.cantidad) AS unidades_movidas
FROM movimiento_inventario AS mi
JOIN producto AS pr ON mi.id_producto = pr.id_producto
JOIN bodega AS b ON mi.id_bodega = b.id_bodega
GROUP BY mi.tipo
ORDER BY unidades_movidas DESC;

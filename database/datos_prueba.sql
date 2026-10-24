 -- Laboratorio #3: Datos de prueba para el sistema de inventario aduanero
-- Gestor: PostgreSQL en Supabase
-- Ejecuta este bloque una sola vez, después de crear las 13 tablas.
-- Contiene 15 registros por cada tabla.

BEGIN;

INSERT INTO importador (razon_social, identificacion, direccion, telefono, correo) VALUES
    ('Importadora Central S.A.', 'CR-310100001', 'San José, Costa Rica', '2222-1001', 'contacto@central.cr'),
    ('Alimentos del Valle S.R.L.', 'CR-310100002', 'Heredia, Costa Rica', '2222-1002', 'compras@valle.cr'),
    ('Tecnología Global S.A.', 'CR-310100003', 'San José, Costa Rica', '2222-1003', 'info@tecnologiaglobal.cr'),
    ('Comercial del Pacífico S.A.', 'CR-310100004', 'Puntarenas, Costa Rica', '2222-1004', 'ventas@pacifico.cr'),
    ('Distribuidora La Sabana S.A.', 'CR-310100005', 'San José, Costa Rica', '2222-1005', 'contacto@sabana.cr'),
    ('Agroindustrias del Norte S.R.L.', 'CR-310100006', 'Alajuela, Costa Rica', '2222-1006', 'info@agronorte.cr'),
    ('Electrodomésticos Ticos S.A.', 'CR-310100007', 'Cartago, Costa Rica', '2222-1007', 'pedidos@electroticos.cr'),
    ('Mundo Médico S.A.', 'CR-310100008', 'Heredia, Costa Rica', '2222-1008', 'compras@mundomedico.cr'),
    ('Llantas y Repuestos CR S.A.', 'CR-310100009', 'San José, Costa Rica', '2222-1009', 'ventas@llantascr.cr'),
    ('Bebidas Selectas S.R.L.', 'CR-310100010', 'Liberia, Costa Rica', '2222-1010', 'info@bebidasselectas.cr'),
    ('Exportadora del Caribe S.A.', 'CR-310100011', 'Limón, Costa Rica', '2222-1011', 'contacto@caribe.cr'),
    ('Comercializadora Horizonte S.A.', 'CR-310100012', 'Alajuela, Costa Rica', '2222-1012', 'ventas@horizonte.cr'),
    ('Importaciones del Este S.R.L.', 'CR-310100013', 'Cartago, Costa Rica', '2222-1013', 'info@importacioneseste.cr'),
    ('Suministros Industriales CR S.A.', 'CR-310100014', 'San José, Costa Rica', '2222-1014', 'pedidos@suministroscr.cr'),
    ('Mercancías del Mundo S.A.', 'CR-310100015', 'Heredia, Costa Rica', '2222-1015', 'contacto@mercanciasmundo.cr');

INSERT INTO agente_aduanal (nombre, numero_licencia, telefono) VALUES
    ('Agente Aduanal 01', 'LIC-CR-2021-001', '2250-3001'),
    ('Agente Aduanal 02', 'LIC-CR-2022-002', '2250-3002'),
    ('Agente Aduanal 03', 'LIC-CR-2023-003', '2250-3003'),
    ('Agente Aduanal 04', 'LIC-CR-2024-004', '2250-3004'),
    ('Agente Aduanal 05', 'LIC-CR-2025-005', '2250-3005'),
    ('Agente Aduanal 06', 'LIC-CR-2026-006', '2250-3006'),
    ('Agente Aduanal 07', 'LIC-CR-2027-007', '2250-3007'),
    ('Agente Aduanal 08', 'LIC-CR-2028-008', '2250-3008'),
    ('Agente Aduanal 09', 'LIC-CR-2029-009', '2250-3009'),
    ('Agente Aduanal 10', 'LIC-CR-2030-010', '2250-3010'),
    ('Agente Aduanal 11', 'LIC-CR-2031-011', '2250-3011'),
    ('Agente Aduanal 12', 'LIC-CR-2032-012', '2250-3012'),
    ('Agente Aduanal 13', 'LIC-CR-2033-013', '2250-3013'),
    ('Agente Aduanal 14', 'LIC-CR-2034-014', '2250-3014'),
    ('Agente Aduanal 15', 'LIC-CR-2035-015', '2250-3015');

INSERT INTO pais (nombre, codigo_iso) VALUES
    ('China', 'CN'),
    ('Estados Unidos', 'US'),
    ('México', 'MX'),
    ('Costa Rica', 'CR'),
    ('Panamá', 'PA'),
    ('Colombia', 'CO'),
    ('Brasil', 'BR'),
    ('Japón', 'JP'),
    ('Alemania', 'DE'),
    ('Corea del Sur', 'KR'),
    ('España', 'ES'),
    ('Chile', 'CL'),
    ('Perú', 'PE'),
    ('Italia', 'IT'),
    ('Canadá', 'CA');

INSERT INTO partida_arancelaria (codigo, descripcion, porcentaje_arancel) VALUES
    ('010121', 'Caballos reproductores de raza pura', 5.0),
    ('020130', 'Carne bovina deshuesada, fresca o refrigerada', 15.0),
    ('030617', 'Camarones y langostinos congelados', 10.0),
    ('040221', 'Leche y nata en polvo', 8.0),
    ('070200', 'Tomates frescos o refrigerados', 5.0),
    ('080510', 'Naranjas frescas o secas', 5.0),
    ('090111', 'Café sin tostar y sin descafeinar', 1.0),
    ('100630', 'Arroz semiblanqueado o blanqueado', 10.0),
    ('120190', 'Habas de soja, incluso quebrantadas', 2.0),
    ('150710', 'Aceite de soja en bruto', 8.0),
    ('220421', 'Vino en recipientes de hasta dos litros', 15.0),
    ('270900', 'Aceites crudos de petróleo', 0.0),
    ('300490', 'Medicamentos dosificados para venta al por menor', 0.0),
    ('401110', 'Neumáticos nuevos para automóviles', 12.0),
    ('847130', 'Computadoras portátiles', 5.0);

INSERT INTO funcionario (nombre, cargo, id_supervisor) VALUES
    ('Laura Méndez', 'Jefa de Aduana', NULL),
    ('Carlos Rojas', 'Supervisor de Inspección', 1),
    ('María Solano', 'Inspectora', 2),
    ('Jorge Vargas', 'Inspector', 2),
    ('Ana Castillo', 'Inspectora', 2),
    ('Diego Ramírez', 'Inspector', 2),
    ('Sofía Herrera', 'Inspectora', 2),
    ('Luis Jiménez', 'Analista Aduanero', 1),
    ('Elena Mora', 'Analista Aduanera', 1),
    ('Pablo Castro', 'Técnico de Inventario', 1),
    ('Daniela Ruiz', 'Técnica de Inventario', 1),
    ('Andrés León', 'Funcionario de Bodega', 1),
    ('Valeria Núñez', 'Funcionaria de Bodega', 1),
    ('Ricardo Soto', 'Coordinador de Turno', 1),
    ('Gabriela Vega', 'Inspectora', 2);

INSERT INTO bodega (nombre, ubicacion, capacidad_kg) VALUES
    ('Bodega Aduanera 01', 'San José, Costa Rica', 18000),
    ('Bodega Aduanera 02', 'Alajuela, Costa Rica', 22000),
    ('Bodega Aduanera 03', 'Limón, Costa Rica', 30000),
    ('Bodega Aduanera 04', 'Heredia, Costa Rica', 16000),
    ('Bodega Aduanera 05', 'Puntarenas, Costa Rica', 25000),
    ('Bodega Aduanera 06', 'Cartago, Costa Rica', 14000),
    ('Bodega Aduanera 07', 'Guanacaste, Costa Rica', 20000),
    ('Bodega Aduanera 08', 'Liberia, Costa Rica', 18000),
    ('Bodega Aduanera 09', 'Caldera, Costa Rica', 28000),
    ('Bodega Aduanera 10', 'Moín, Costa Rica', 32000),
    ('Bodega Aduanera 11', 'La Uruca, Costa Rica', 12000),
    ('Bodega Aduanera 12', 'Coyol, Costa Rica', 24000),
    ('Bodega Aduanera 13', 'Barrio Cuba, Costa Rica', 11000),
    ('Bodega Aduanera 14', 'Paso Canoas, Costa Rica', 21000),
    ('Bodega Aduanera 15', 'Peñas Blancas, Costa Rica', 17000);

INSERT INTO producto (descripcion, unidad_medida, valor_unitario, id_partida) VALUES
    ('Caballo reproductor de raza pura', 'unidad', 8500.0, 1),
    ('Carne bovina deshuesada refrigerada', 'kilogramo', 9.5, 2),
    ('Camarón congelado', 'kilogramo', 12.75, 3),
    ('Leche en polvo', 'kilogramo', 4.2, 4),
    ('Tomate fresco', 'kilogramo', 1.8, 5),
    ('Naranja fresca', 'kilogramo', 1.25, 6),
    ('Café verde sin tostar', 'kilogramo', 5.1, 7),
    ('Arroz blanco', 'kilogramo', 1.4, 8),
    ('Haba de soja', 'kilogramo', 0.85, 9),
    ('Aceite de soja en bruto', 'litro', 2.1, 10),
    ('Vino tinto embotellado', 'botella', 8.75, 11),
    ('Petróleo crudo', 'barril', 72.0, 12),
    ('Medicamento analgésico', 'caja', 6.3, 13),
    ('Neumático para automóvil', 'unidad', 48.0, 14),
    ('Computadora portátil', 'unidad', 690.0, 15);

INSERT INTO declaracion (numero, fecha, regimen, estado, id_importador, id_agente, id_pais_origen) VALUES
    ('DUA-2026-0001', '2026-10-01', 'Importacion', 'Retenida', 1, 1, 1),
    ('DUA-2026-0002', '2026-10-02', 'Importacion', 'En revision', 2, 2, 2),
    ('DUA-2026-0003', '2026-10-03', 'Transito', 'Liberada', 3, 3, 3),
    ('DUA-2026-0004', '2026-10-04', 'Importacion', 'Registrada', 4, 4, 4),
    ('DUA-2026-0005', '2026-10-05', 'Deposito', 'Retenida', 5, 5, 5),
    ('DUA-2026-0006', '2026-10-06', 'Exportacion', 'Liberada', 6, 6, 6),
    ('DUA-2026-0007', '2026-10-07', 'Importacion', 'En revision', 7, 7, 7),
    ('DUA-2026-0008', '2026-10-08', 'Transito', 'Retenida', 8, 8, 8),
    ('DUA-2026-0009', '2026-10-09', 'Importacion', 'Registrada', 9, 9, 9),
    ('DUA-2026-0010', '2026-10-10', 'Deposito', 'Liberada', 10, 10, 10),
    ('DUA-2026-0011', '2026-10-11', 'Importacion', 'Retenida', 11, 11, 11),
    ('DUA-2026-0012', '2026-10-12', 'Exportacion', 'Rechazada', 12, 12, 12),
    ('DUA-2026-0013', '2026-10-13', 'Importacion', 'En revision', 13, 13, 13),
    ('DUA-2026-0014', '2026-10-14', 'Transito', 'Liberada', 14, 14, 14),
    ('DUA-2026-0015', '2026-10-15', 'Importacion', 'Retenida', 15, 15, 15);

INSERT INTO detalle_declaracion (id_declaracion, id_producto, cantidad, valor_declarado) VALUES
    (1, 1, 11, 93500.00),
    (2, 2, 12, 114.00),
    (3, 3, 13, 165.75),
    (4, 4, 14, 58.80),
    (5, 5, 15, 27.00),
    (6, 6, 16, 20.00),
    (7, 7, 17, 86.70),
    (8, 8, 18, 25.20),
    (9, 9, 19, 16.15),
    (10, 10, 20, 42.00),
    (11, 11, 21, 183.75),
    (12, 12, 22, 1584.00),
    (13, 13, 23, 144.90),
    (14, 14, 24, 1152.00),
    (15, 15, 25, 17250.00);

INSERT INTO contenedor (numero, tipo, peso_kg, id_declaracion) VALUES
    ('CONT-2026-0001', '20 pies', 5350, 1),
    ('CONT-2026-0002', '40 pies', 5700, 2),
    ('CONT-2026-0003', 'Refrigerado', 6050, 3),
    ('CONT-2026-0004', 'Open top', 6400, 4),
    ('CONT-2026-0005', '20 pies', 6750, 5),
    ('CONT-2026-0006', '40 pies', 7100, 6),
    ('CONT-2026-0007', 'Refrigerado', 7450, 7),
    ('CONT-2026-0008', 'Open top', 7800, 8),
    ('CONT-2026-0009', '20 pies', 8150, 9),
    ('CONT-2026-0010', '40 pies', 8500, 10),
    ('CONT-2026-0011', 'Refrigerado', 8850, 11),
    ('CONT-2026-0012', 'Open top', 9200, 12),
    ('CONT-2026-0013', '20 pies', 9550, 13),
    ('CONT-2026-0014', '40 pies', 9900, 14),
    ('CONT-2026-0015', 'Refrigerado', 10250, 15);

INSERT INTO inventario_bodega (id_bodega, id_producto, cantidad, fecha_ingreso, estado) VALUES
    (1, 1, 107, '2026-10-01', 'Retenido'),
    (2, 2, 114, '2026-10-02', 'Retenido'),
    (3, 3, 121, '2026-10-03', 'Liberado'),
    (4, 4, 128, '2026-10-04', 'En inspeccion'),
    (5, 5, 135, '2026-10-05', 'Retenido'),
    (6, 6, 142, '2026-10-06', 'Liberado'),
    (7, 7, 149, '2026-10-07', 'Retenido'),
    (8, 8, 156, '2026-10-08', 'Liberado'),
    (9, 9, 163, '2026-10-09', 'En inspeccion'),
    (10, 10, 170, '2026-10-10', 'Retenido'),
    (11, 11, 177, '2026-10-11', 'Liberado'),
    (12, 12, 184, '2026-10-12', 'Retenido'),
    (13, 13, 191, '2026-10-13', 'Liberado'),
    (14, 14, 198, '2026-10-14', 'En inspeccion'),
    (15, 15, 205, '2026-10-15', 'Retenido');

INSERT INTO inspeccion (fecha, resultado, observaciones, id_declaracion, id_funcionario) VALUES
    ('2026-10-02', 'Con observaciones', 'Documentación incompleta', 1, 1),
    ('2026-10-03', 'Aprobada', 'Revisión de rutina', 2, 2),
    ('2026-10-04', 'Pendiente', 'Revisión de rutina', 3, 3),
    ('2026-10-05', 'Rechazada', 'Mercancía no conforme', 4, 4),
    ('2026-10-06', 'Aprobada', 'Revisión de rutina', 5, 5),
    ('2026-10-07', 'Con observaciones', 'Documentación incompleta', 6, 6),
    ('2026-10-08', 'Aprobada', 'Revisión de rutina', 7, 7),
    ('2026-10-09', 'Pendiente', 'Revisión de rutina', 8, 8),
    ('2026-10-10', 'Con observaciones', 'Documentación incompleta', 9, 9),
    ('2026-10-11', 'Aprobada', 'Revisión de rutina', 10, 10),
    ('2026-10-12', 'Rechazada', 'Mercancía no conforme', 11, 11),
    ('2026-10-13', 'Aprobada', 'Revisión de rutina', 12, 12),
    ('2026-10-14', 'Con observaciones', 'Documentación incompleta', 13, 13),
    ('2026-10-15', 'Pendiente', 'Revisión de rutina', 14, 14),
    ('2026-10-16', 'Aprobada', 'Revisión de rutina', 15, 15);

INSERT INTO movimiento_inventario (tipo, fecha, cantidad, id_producto, id_bodega) VALUES
    ('Entrada', '2026-10-01', 7, 1, 1),
    ('Salida', '2026-10-02', 9, 2, 2),
    ('Traslado', '2026-10-03', 11, 3, 3),
    ('Entrada', '2026-10-04', 13, 4, 4),
    ('Salida', '2026-10-05', 15, 5, 5),
    ('Traslado', '2026-10-06', 17, 6, 6),
    ('Entrada', '2026-10-07', 19, 7, 7),
    ('Salida', '2026-10-08', 21, 8, 8),
    ('Traslado', '2026-10-09', 23, 9, 9),
    ('Entrada', '2026-10-10', 25, 10, 10),
    ('Salida', '2026-10-11', 27, 11, 11),
    ('Traslado', '2026-10-12', 29, 12, 12),
    ('Entrada', '2026-10-13', 31, 13, 13),
    ('Salida', '2026-10-14', 33, 14, 14),
    ('Traslado', '2026-10-15', 35, 15, 15);

-- Sincroniza las secuencias SERIAL para que el próximo ID generado sea 16.
SELECT setval(pg_get_serial_sequence('public.importador','id_importador'), (SELECT MAX(id_importador) FROM public.importador), true);
SELECT setval(pg_get_serial_sequence('public.agente_aduanal','id_agente'), (SELECT MAX(id_agente) FROM public.agente_aduanal), true);
SELECT setval(pg_get_serial_sequence('public.pais','id_pais'), (SELECT MAX(id_pais) FROM public.pais), true);
SELECT setval(pg_get_serial_sequence('public.partida_arancelaria','id_partida'), (SELECT MAX(id_partida) FROM public.partida_arancelaria), true);
SELECT setval(pg_get_serial_sequence('public.producto','id_producto'), (SELECT MAX(id_producto) FROM public.producto), true);
SELECT setval(pg_get_serial_sequence('public.funcionario','id_funcionario'), (SELECT MAX(id_funcionario) FROM public.funcionario), true);
SELECT setval(pg_get_serial_sequence('public.bodega','id_bodega'), (SELECT MAX(id_bodega) FROM public.bodega), true);
SELECT setval(pg_get_serial_sequence('public.declaracion','id_declaracion'), (SELECT MAX(id_declaracion) FROM public.declaracion), true);
SELECT setval(pg_get_serial_sequence('public.contenedor','id_contenedor'), (SELECT MAX(id_contenedor) FROM public.contenedor), true);
SELECT setval(pg_get_serial_sequence('public.inspeccion','id_inspeccion'), (SELECT MAX(id_inspeccion) FROM public.inspeccion), true);
SELECT setval(pg_get_serial_sequence('public.movimiento_inventario','id_movimiento'), (SELECT MAX(id_movimiento) FROM public.movimiento_inventario), true);

COMMIT;

-- Verificación: cada una de las 13 tablas debe mostrar 15 registros.
SELECT 'importador' AS tabla, COUNT(*) AS registros FROM importador
UNION ALL SELECT 'agente_aduanal', COUNT(*) FROM agente_aduanal
UNION ALL SELECT 'pais', COUNT(*) FROM pais
UNION ALL SELECT 'partida_arancelaria', COUNT(*) FROM partida_arancelaria
UNION ALL SELECT 'producto', COUNT(*) FROM producto
UNION ALL SELECT 'funcionario', COUNT(*) FROM funcionario
UNION ALL SELECT 'bodega', COUNT(*) FROM bodega
UNION ALL SELECT 'declaracion', COUNT(*) FROM declaracion
UNION ALL SELECT 'detalle_declaracion', COUNT(*) FROM detalle_declaracion
UNION ALL SELECT 'contenedor', COUNT(*) FROM contenedor
UNION ALL SELECT 'inventario_bodega', COUNT(*) FROM inventario_bodega
UNION ALL SELECT 'inspeccion', COUNT(*) FROM inspeccion
UNION ALL SELECT 'movimiento_inventario', COUNT(*) FROM movimiento_inventario
ORDER BY tabla;

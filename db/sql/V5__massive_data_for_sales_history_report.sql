---------------------------------------------------------------------
-- CARGA MASIVA INICIAL DE DATOS
-- Inserción ordenada para entorno de pruebas en ambiente corporativo
-- 
-- Se respetan dependencias y relaciones referenciales.
-- Datos coherentes para pruebas de reportes y operaciones.
---------------------------------------------------------------------

------------------------------------------------
-- USUARIOS
------------------------------------------------
INSERT INTO Usuarios (nombreusuario, password, email) VALUES 
('admin', 'hashed_admin_pass', 'admin@example.com'),
('vendedor1', 'hashed_pass1', 'vendedor1@example.com'),
('vendedor2', 'hashed_pass2', 'vendedor2@example.com'),
('vendedor3', 'hashed_pass3', 'vendedor3@example.com'),
('vendedor4', 'hashed_pass4', 'vendedor4@example.com'),
('vendedor5', 'hashed_pass5', 'vendedor5@example.com'),
('vendedor6', 'hashed_pass6', 'vendedor6@example.com'),
('vendedor7', 'hashed_pass7', 'vendedor7@example.com'),
('vendedor8', 'hashed_pass8', 'vendedor8@example.com'),
('vendedor9', 'hashed_pass9', 'vendedor9@example.com');

------------------------------------------------
-- MÉTODOS DE PAGO
------------------------------------------------
INSERT INTO MetodosPago (nombre) VALUES 
('Efectivo'),
('Tarjeta de Crédito'),
('Transferencia Bancaria'),
('Pago Móvil'),
('PayPal');

------------------------------------------------
-- PRODUCTOS
------------------------------------------------
INSERT INTO Productos (nombre, descripcion, precio, stock) VALUES 
('Laptop Gamer', 'Laptop de alto rendimiento', 1500.00, 50),
('Mouse Inalámbrico', 'Mouse Bluetooth ergonómico', 25.00, 500),
('Teclado Mecánico', 'Teclado RGB para gaming', 75.00, 300),
('Monitor 24 pulgadas', 'Monitor FHD 24 pulgadas', 200.00, 100),
('Auriculares Gamer', 'Auriculares surround', 80.00, 200),
('Smartphone Gama Alta', 'Smartphone última generación', 1000.00, 100),
('Tablet 10 pulgadas', 'Tablet Android 10"', 300.00, 150),
('Cargador Portátil', 'Power Bank 20000mAh', 50.00, 400),
('Memoria USB 128GB', 'Pendrive alta velocidad', 20.00, 600),
('Disco Duro Externo 1TB', 'HDD portátil', 70.00, 250),
('Webcam HD', 'Webcam Full HD', 45.00, 150),
('Silla Gamer', 'Silla ergonómica de gaming', 250.00, 50),
('Impresora Multifunción', 'Impresora 3 en 1', 180.00, 70),
('Router WiFi 6', 'Router de alta velocidad', 120.00, 90),
('Switch de Red 8P', 'Switch Ethernet Gigabit', 40.00, 120),
('Auriculares Bluetooth', 'Auriculares inalámbricos', 60.00, 300),
('Teclado Compacto', 'Teclado mini', 45.00, 200),
('Mousepad Gamer XL', 'Alfombrilla grande', 20.00, 350),
('Kit Teclado + Mouse', 'Kit combo inalámbrico', 50.00, 400),
('SSD 500GB', 'Disco sólido SATA', 90.00, 150),
('SSD 1TB', 'Disco sólido alta capacidad', 150.00, 120),
('Placa de Video RTX 4060', 'Tarjeta gráfica potente', 600.00, 30),
('Memoria RAM 16GB', 'Módulo DDR4', 80.00, 200),
('Fuente de Poder 600W', 'Fuente certificada', 100.00, 80),
('Gabinete Gamer', 'Case ATX con RGB', 150.00, 60),
('Smartwatch', 'Reloj inteligente', 150.00, 250),
('Cámara de Seguridad', 'IP WiFi', 90.00, 180),
('Mochila Laptop', 'Mochila acolchada', 70.00, 180),
('Gamepad Bluetooth', 'Control inalámbrico', 45.00, 200),
('Adaptador USB-C', 'Multipuerto USB-C', 30.00, 300),
('Cargador Rápido', 'Cargador de pared', 35.00, 400),
('Auriculares Studio', 'Audio de alta fidelidad', 120.00, 80),
('Tableta Gráfica', 'Para diseño digital', 200.00, 60),
('Proyector Portátil', 'Mini proyector', 250.00, 40),
('Micrófono Condensador', 'Micrófono para streaming', 100.00, 90),
('Controlador MIDI', 'Instrumento musical digital', 150.00, 40),
('Luz Ring LED', 'Iluminación para fotografía', 50.00, 120),
('Servidor NAS', 'Almacenamiento en red', 500.00, 20),
('Batería Externa Solar', 'Cargador solar portátil', 80.00, 100),
('Cámara de Acción', 'Cámara deportiva', 200.00, 70),
('Kit de Herramientas PC', 'Kit técnico de mantenimiento', 60.00, 80),
('Cable HDMI 4K', 'Cable de alta definición', 25.00, 300),
('Cámara Profesional', 'DSLR Full Frame', 2500.00, 10),
('Estabilizador Gimbal', 'Para cámaras o smartphones', 300.00, 30),
('Lente 50mm', 'Fotografía de retrato', 500.00, 15),
('Monitor Ultrawide', 'Monitor panorámico', 600.00, 20),
('Router Mesh', 'Sistema WiFi extensible', 200.00, 30),
('Kit Streaming', 'Paquete para streamers', 400.00, 40),
('Hub USB 7 Puertos', 'Hub de expansión', 35.00, 120),
('Batería de Respaldo UPS', 'UPS 600VA para PC', 120.00, 40);

------------------------------------------------
-- CLIENTES
------------------------------------------------
INSERT INTO Clientes (nombre, correo, telefono, direccion, creadoporusuarioid)
SELECT 
    CONCAT('Cliente_', g), 
    CONCAT('cliente', g, '@example.com'), 
    CONCAT('7000', LPAD(g::TEXT, 4, '0')), 
    CONCAT('Direccion_', g), 
    (1 + (g % 10))
FROM generate_series(1, 200) AS g;

------------------------------------------------
-- VENTAS
------------------------------------------------
INSERT INTO Ventas (clienteid, total, metodopagoid, creadoporusuarioid, fechaventa)
SELECT 
    (1 + (random() * 199)::INT),
    (50 + random() * 5000)::NUMERIC(10,2),
    1,
    (1 + (random() * 9)::INT),
    NOW() - (random() * INTERVAL '365 days')
FROM generate_series(1, 2000);

------------------------------------------------
-- DETALLE DE VENTAS
------------------------------------------------
INSERT INTO DetalleVentas (ventaid, productoid, cantidad, preciounitario)
SELECT 
    (1 + (random() * 1999)::INT),
    (1 + (random() * 49)::INT),
    (1 + (random() * 4)::INT),
    (20 + random() * 2480)::NUMERIC(10,2)
FROM generate_series(1, 4000);
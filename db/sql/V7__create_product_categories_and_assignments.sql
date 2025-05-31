--------------------------------------------------
-- Tabla de Categorías de Productos: Agrupa productos por tipo o línea
--------------------------------------------------
CREATE TABLE CategoriasProducto (
    CategoriaID SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL UNIQUE,
    Descripcion VARCHAR(255),
    Activo BOOLEAN NOT NULL DEFAULT TRUE
);

--------------------------------------------------
-- Actualizar tabla Productos: Relación con CategoriasProducto (sin NOT NULL inicial)
-- Se agrega la columna para clasificación futura sin romper registros existentes
--------------------------------------------------
ALTER TABLE Productos
    ADD COLUMN CategoriaID INTEGER;

--------------------------------------------------
-- Trigger: Prevención de borrado físico (soft-delete) para CategoriasProducto
--------------------------------------------------
CREATE OR REPLACE FUNCTION sp_prevent_delete_CategoriasProducto()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE CategoriasProducto SET Activo = FALSE WHERE CategoriaID = OLD.CategoriaID;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_prevent_delete_CategoriasProducto
BEFORE DELETE ON CategoriasProducto
FOR EACH ROW
EXECUTE FUNCTION sp_prevent_delete_CategoriasProducto();

--------------------------------------------------
-- Funciones almacenadas: Manejo de Categorías de Producto
--------------------------------------------------
-- BorrarCategoriaProducto(_CategoriaID) -> soft-delete
CREATE OR REPLACE FUNCTION BorrarCategoriaProducto(_CategoriaID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE CategoriasProducto SET Activo = FALSE WHERE CategoriaID = _CategoriaID;
END;
$$ LANGUAGE plpgsql;

-- ReactivarCategoriaProducto(_CategoriaID)
CREATE OR REPLACE FUNCTION ReactivarCategoriaProducto(_CategoriaID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE CategoriasProducto SET Activo = TRUE WHERE CategoriaID = _CategoriaID;
END;
$$ LANGUAGE plpgsql;

-- ObtenerCategoriasProductoActivas()
CREATE OR REPLACE FUNCTION ObtenerCategoriasProductoActivas()
RETURNS SETOF CategoriasProducto AS $$
    SELECT * FROM CategoriasProducto WHERE Activo = TRUE;
$$ LANGUAGE sql;

--------------------------------------------------
-- Vista adicional: Facturación mensual por categoría
--------------------------------------------------
CREATE VIEW ReporteFacturacionMensualPorCategoria AS
SELECT 
    to_char(F.FechaEmision, 'YYYY-MM') AS Mes,
    CP.Nombre AS Categoria,
    SUM(DV.Subtotal) AS TotalFacturado
FROM 
    Facturas F
JOIN 
    Ventas V ON F.VentaID = V.VentaID
JOIN 
    DetalleVentas DV ON V.VentaID = DV.VentaID
JOIN 
    Productos P ON DV.ProductoID = P.ProductoID
JOIN 
    CategoriasProducto CP ON P.CategoriaID = CP.CategoriaID
WHERE 
    F.Activo = TRUE AND V.Activo = TRUE AND DV.Activo = TRUE AND P.Activo = TRUE AND CP.Activo = TRUE
GROUP BY 
    Mes, Categoria
ORDER BY 
    Mes, Categoria;

--------------------------------------------------
-- Inserción masiva de datos en CategoriasProducto
-- Incluye categoría 'Sin Clasificar' con ID = 1
--------------------------------------------------
INSERT INTO CategoriasProducto (Nombre, Descripcion, Activo) VALUES
('Sin Clasificar', 'Categoría general para productos sin asignar', TRUE),
('Electrónica', 'Dispositivos electrónicos, computadoras, periféricos', TRUE),
('Ropa', 'Prendas de vestir y accesorios de moda', TRUE),
('Alimentos', 'Productos comestibles y bebidas envasadas', TRUE),
('Muebles', 'Artículos para hogar u oficina como mesas, sillas, estanterías', TRUE),
('Limpieza', 'Productos de higiene, limpieza doméstica e industrial', TRUE),
('Papelería', 'Útiles escolares, de oficina y artículos de escritura', TRUE),
('Ferretería', 'Herramientas, materiales de construcción y artículos varios', TRUE),
('Deportes', 'Equipamiento y ropa deportiva para diversas disciplinas', TRUE),
('Juguetería', 'Juguetes, juegos didácticos y recreativos para niños', TRUE),
('Accesorios de Computadora', 'Periféricos y accesorios para equipos de cómputo', TRUE),
('Fotografía y Video', 'Equipos y accesorios para captura de imagen y video', TRUE),
('Diseño y Creatividad', 'Herramientas para creación gráfica, diseño y arte digital', TRUE),
('Streaming y Producción', 'Equipos y kits para transmisión en vivo y producción multimedia', TRUE),
('Almacenamiento y Respaldo', 'Dispositivos de almacenamiento portátil y protección de datos', TRUE),
('Componentes de PC', 'Partes internas y hardware especializado para computadoras', TRUE),
('Redes y Conectividad', 'Equipos para redes cableadas e inalámbricas', TRUE),
('Movilidad y Wearables', 'Tecnología portátil como smartwatches y accesorios móviles', TRUE),
('Seguridad y Vigilancia', 'Equipos para monitoreo, cámaras y control de seguridad', TRUE),
('Energía y Carga', 'Dispositivos de alimentación eléctrica y respaldo', TRUE),
('Mantenimiento y Herramientas', 'Kits y herramientas especializadas para soporte técnico', TRUE),
('Impresión y Digitalización', 'Dispositivos multifunción para escaneo, copiado e impresión', TRUE),
('Audio Profesional', 'Dispositivos de alta fidelidad para monitoreo, estudio o producción musical', TRUE),
('Accesorios de Transporte', 'Bolsos, mochilas y maletines diseñados para dispositivos electrónicos', TRUE);

--------------------------------------------------
-- Actualización de productos con su respectiva CategoriaID
-- Asignación 100% definida sin dejar productos sin clasificar
--------------------------------------------------

-- CategoriaID = 2 → Electrónica
UPDATE Productos SET CategoriaID = 2 WHERE Nombre IN (
    'Laptop Gamer', 'Smartphone Gama Alta', 'Tablet 10 pulgadas'
);

-- CategoriaID = 3 → Ropa (no se utiliza por ahora)

-- CategoriaID = 4 → Alimentos (no se utiliza por ahora)

-- CategoriaID = 5 → Muebles
UPDATE Productos SET CategoriaID = 5 WHERE Nombre IN (
    'Silla Gamer'
);

-- CategoriaID = 6 → Limpieza (no se utiliza por ahora)

-- CategoriaID = 11 → Accesorios de Computadora
UPDATE Productos SET CategoriaID = 11 WHERE Nombre IN (
    'Mouse Inalámbrico', 'Teclado Mecánico', 'Monitor 24 pulgadas', 'Auriculares Gamer',
    'Webcam HD', 'Teclado Compacto', 'Mousepad Gamer XL', 'Kit Teclado + Mouse',
    'Gamepad Bluetooth', 'Adaptador USB-C', 'Cargador Rápido', 'Luz Ring LED',
    'Hub USB 7 Puertos', 'Cable HDMI 4K', 'Auriculares Bluetooth'
);

-- CategoriaID = 12 → Fotografía y Video
UPDATE Productos SET CategoriaID = 12 WHERE Nombre IN (
    'Cámara de Acción', 'Cámara Profesional', 'Lente 50mm',
    'Proyector Portátil', 'Monitor Ultrawide'
);

-- CategoriaID = 13 → Diseño y Creatividad
UPDATE Productos SET CategoriaID = 13 WHERE Nombre IN (
    'Tableta Gráfica', 'Controlador MIDI'
);

-- CategoriaID = 14 → Streaming y Producción
UPDATE Productos SET CategoriaID = 14 WHERE Nombre IN (
    'Micrófono Condensador', 'Kit Streaming'
);

-- CategoriaID = 15 → Almacenamiento y Respaldo
UPDATE Productos SET CategoriaID = 15 WHERE Nombre IN (
    'Disco Duro Externo 1TB', 'Servidor NAS', 'Memoria USB 128GB'
);

-- CategoriaID = 16 → Componentes de PC
UPDATE Productos SET CategoriaID = 16 WHERE Nombre IN (
    'SSD 500GB', 'SSD 1TB', 'Placa de Video RTX 4060', 'Memoria RAM 16GB',
    'Fuente de Poder 600W', 'Gabinete Gamer'
);

-- CategoriaID = 17 → Redes y Conectividad
UPDATE Productos SET CategoriaID = 17 WHERE Nombre IN (
    'Router WiFi 6', 'Switch de Red 8P', 'Router Mesh'
);

-- CategoriaID = 18 → Movilidad y Wearables
UPDATE Productos SET CategoriaID = 18 WHERE Nombre IN (
    'Smartwatch', 'Cargador Portátil', 'Batería Externa Solar', 'Estabilizador Gimbal'
);

-- CategoriaID = 19 → Seguridad y Vigilancia
UPDATE Productos SET CategoriaID = 19 WHERE Nombre IN (
    'Cámara de Seguridad'
);

-- CategoriaID = 20 → Energía y Carga
UPDATE Productos SET CategoriaID = 20 WHERE Nombre IN (
    'Batería de Respaldo UPS'
);

-- CategoriaID = 21 → Mantenimiento y Herramientas
UPDATE Productos SET CategoriaID = 21 WHERE Nombre IN (
    'Kit de Herramientas PC'
);

-- CategoriaID = 22 → Impresión y Digitalización
UPDATE Productos SET CategoriaID = 22 WHERE Nombre IN (
    'Impresora Multifunción'
);

-- CategoriaID = 23 → Audio Profesional
UPDATE Productos SET CategoriaID = 23 WHERE Nombre IN (
    'Auriculares Studio'
);

-- CategoriaID = 24 → Accesorios de Transporte
UPDATE Productos SET CategoriaID = 24 WHERE Nombre = 'Mochila Laptop';

--------------------------------------------------
-- Aplicar restricción NOT NULL y clave foránea a CategoriaID en Productos
-- Se asegura integridad referencial tras haber asignado todas las categorías
--------------------------------------------------
ALTER TABLE Productos 
ALTER COLUMN CategoriaID SET NOT NULL,
ADD CONSTRAINT fk_categoria_producto FOREIGN KEY (CategoriaID) REFERENCES CategoriasProducto(CategoriaID);
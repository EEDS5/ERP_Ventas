--------------------------------------------------
-- Tabla de Usuarios (con columna Activo)
--------------------------------------------------
CREATE TABLE Usuarios (
    UsuarioID SERIAL PRIMARY KEY,
    NombreUsuario VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,  -- Almacenar hash
    Email VARCHAR(100) UNIQUE NOT NULL CHECK (Email ~ '^[^@]+@[^@]+\.[^@]+$'),
    Is2FAEnabled BOOLEAN DEFAULT FALSE,
    Secret2FA VARCHAR(100),
    FechaRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- Campo para soft-delete
    Activo BOOLEAN NOT NULL DEFAULT TRUE
);

--------------------------------------------------
-- Tabla de Clientes (con columna Activo)
--------------------------------------------------
CREATE TABLE Clientes (
    ClienteID SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Correo VARCHAR(100) UNIQUE NOT NULL CHECK (Correo ~ '^[^@]+@[^@]+\.[^@]+$'),
    Telefono VARCHAR(20),
    Direccion VARCHAR(255),
    FechaRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CreadoPorUsuarioID INT NOT NULL,
    Activo BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (CreadoPorUsuarioID) REFERENCES Usuarios(UsuarioID)
);

--------------------------------------------------
-- Tabla de Métodos de Pago
--------------------------------------------------
CREATE TABLE MetodosPago (
    MetodoPagoID SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Activo BOOLEAN NOT NULL DEFAULT TRUE
);

--------------------------------------------------
-- Tabla de Ventas
--------------------------------------------------
CREATE TABLE Ventas (
    VentaID SERIAL PRIMARY KEY,
    ClienteID INT NOT NULL,
    FechaVenta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Total DECIMAL(10,2) NOT NULL CHECK (Total >= 0),
    MetodoPagoID INT NOT NULL,
    CreadoPorUsuarioID INT NOT NULL,
    Activo BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    FOREIGN KEY (MetodoPagoID) REFERENCES MetodosPago(MetodoPagoID),
    FOREIGN KEY (CreadoPorUsuarioID) REFERENCES Usuarios(UsuarioID)
);

--------------------------------------------------
-- Tabla de Productos
--------------------------------------------------
CREATE TABLE Productos (
    ProductoID SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(255),
    Precio DECIMAL(10,2) NOT NULL CHECK (Precio >= 0),
    Stock INT NOT NULL CHECK (Stock >= 0),
    Activo BOOLEAN NOT NULL DEFAULT TRUE
);

--------------------------------------------------
-- Tabla de Detalle de Ventas
--------------------------------------------------
CREATE TABLE DetalleVentas (
    DetalleID SERIAL PRIMARY KEY,
    VentaID INT NOT NULL,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    PrecioUnitario DECIMAL(10,2) NOT NULL CHECK (PrecioUnitario >= 0),
    Subtotal DECIMAL(10,2) GENERATED ALWAYS AS (Cantidad * PrecioUnitario) STORED,
    Activo BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

--------------------------------------------------
-- Tabla de Facturas
--------------------------------------------------
CREATE TABLE Facturas (
    FacturaID SERIAL PRIMARY KEY,
    VentaID INT UNIQUE NOT NULL,
    NumeroFactura VARCHAR(50) UNIQUE NOT NULL,
    FechaEmision TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    XMLFactura XML,
    CreadoPorUsuarioID INT NOT NULL,
    Activo BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID),
    FOREIGN KEY (CreadoPorUsuarioID) REFERENCES Usuarios(UsuarioID)
);

--------------------------------------------------
-- Tabla de Cuentas por Cobrar
-- IMPORTANTE: esta tabla YA tiene una columna "Estado"
-- con valores ('Pendiente', 'Pagado', 'Vencido').
-- Para el borrado lógico usaremos 'Activo'.
--------------------------------------------------
CREATE TABLE CuentasPorCobrar (
    CuentaID SERIAL PRIMARY KEY,
    ClienteID INT NOT NULL,
    VentaID INT UNIQUE NOT NULL,
    MontoPendiente DECIMAL(10,2) NOT NULL CHECK (MontoPendiente >= 0),
    FechaVencimiento TIMESTAMP NOT NULL,
    Estado VARCHAR(50) NOT NULL CHECK (Estado IN ('Pendiente', 'Pagado', 'Vencido')),
    Activo BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID)
);

--------------------------------------------------
-- Tabla de Pagos
--------------------------------------------------
CREATE TABLE Pagos (
    PagoID SERIAL PRIMARY KEY,
    CuentaID INT NOT NULL,
    FechaPago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Monto DECIMAL(10,2) NOT NULL CHECK (Monto >= 0),
    Activo BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (CuentaID) REFERENCES CuentasPorCobrar(CuentaID)
);

--------------------------------------------------
-- Tabla de Pasarelas de Pago
--------------------------------------------------
CREATE TABLE PasarelasPago (
    PasarelaID SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) UNIQUE NOT NULL,
    Activo BOOLEAN NOT NULL DEFAULT TRUE
);

--------------------------------------------------
-- Tabla de Transacciones con Pasarela
-- También tiene una columna "Estado" con valores ('Pendiente','Aprobado','Rechazado').
-- Para el borrado lógico usaremos 'Activo'.
--------------------------------------------------
CREATE TABLE TransaccionesPasarela (
    TransaccionID SERIAL PRIMARY KEY,
    VentaID INT NOT NULL,
    PasarelaID INT NOT NULL,
    Estado VARCHAR(50) NOT NULL CHECK (Estado IN ('Pendiente', 'Aprobado', 'Rechazado')),
    FechaTransaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Monto DECIMAL(10,2) NOT NULL CHECK (Monto >= 0),
    ReferenciaTransaccion VARCHAR(100) NOT NULL,
    IniciadaPorUsuarioID INT NOT NULL,
    Activo BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID),
    FOREIGN KEY (PasarelaID) REFERENCES PasarelasPago(PasarelaID),
    FOREIGN KEY (IniciadaPorUsuarioID) REFERENCES Usuarios(UsuarioID)
);

--------------------------------------------------
-- Vistas para Reportes
-- (No cambia nada respecto a los campos "Activo", ya que están en tablas)
--------------------------------------------------

CREATE VIEW ReporteHistorialVentas AS
SELECT 
    C.ClienteID, 
    C.Nombre AS Cliente, 
    V.VentaID, 
    V.FechaVenta, 
    V.Total
FROM 
    Clientes C
JOIN 
    Ventas V ON C.ClienteID = V.ClienteID;

CREATE VIEW ReporteFacturacionMensual AS
SELECT 
    to_char(F.FechaEmision, 'YYYY-MM') AS Mes, 
    SUM(V.Total) AS TotalFacturado
FROM 
    Facturas F
JOIN 
    Ventas V ON F.VentaID = V.VentaID
GROUP BY 
    to_char(F.FechaEmision, 'YYYY-MM');

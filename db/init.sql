-- Creación de la base de datos (se ejecuta desde psql o administrador de BD)
-- DROP DATABASE IF EXISTS ERP_Ventas;
CREATE DATABASE ERP_Ventas;
-- Conectar a la base de datos ERP_Ventas
\c ERP_Ventas;

--------------------------------------------------
-- Tabla de Usuarios: Para autenticación con doble factor
-- Se recomienda utilizar TOTP (por ejemplo, Google Authenticator) para doble autenticación.
--------------------------------------------------
CREATE TABLE Usuarios (
    UsuarioID SERIAL PRIMARY KEY,
    NombreUsuario VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,  -- Almacenar hash de la contraseña
    Email VARCHAR(100) UNIQUE NOT NULL CHECK (Email ~ '^[^@]+@[^@]+\.[^@]+$'),
    Is2FAEnabled BOOLEAN DEFAULT FALSE,
    Secret2FA VARCHAR(100),  -- Clave secreta para TOTP si 2FA está activada
    FechaRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--------------------------------------------------
-- Tabla de Clientes: Datos de los clientes con validación de correo
--------------------------------------------------
CREATE TABLE Clientes (
    ClienteID SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Correo VARCHAR(100) UNIQUE NOT NULL CHECK (Correo ~ '^[^@]+@[^@]+\.[^@]+$'),
    Telefono VARCHAR(20),
    Direccion VARCHAR(255),
    FechaRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CreadoPorUsuarioID INT NOT NULL,
    FOREIGN KEY (CreadoPorUsuarioID) REFERENCES Usuarios(UsuarioID)
);

--------------------------------------------------
-- Tabla de Métodos de Pago: Métodos aceptados por el sistema
--------------------------------------------------
CREATE TABLE MetodosPago (
    MetodoPagoID SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL
);

--------------------------------------------------
-- Tabla de Ventas: Registro de ventas con referencias a clientes y métodos de pago
--------------------------------------------------
CREATE TABLE Ventas (
    VentaID SERIAL PRIMARY KEY,
    ClienteID INT NOT NULL,
    FechaVenta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Total DECIMAL(10,2) NOT NULL CHECK (Total >= 0),
    MetodoPagoID INT NOT NULL,
    CreadoPorUsuarioID INT NOT NULL,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    FOREIGN KEY (MetodoPagoID) REFERENCES MetodosPago(MetodoPagoID),
    FOREIGN KEY (CreadoPorUsuarioID) REFERENCES Usuarios(UsuarioID)
);

--------------------------------------------------
-- Tabla de Productos: Almacena productos disponibles con restricciones
--------------------------------------------------
CREATE TABLE Productos (
    ProductoID SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(255),
    Precio DECIMAL(10,2) NOT NULL CHECK (Precio >= 0),
    Stock INT NOT NULL CHECK (Stock >= 0)
);

--------------------------------------------------
-- Tabla de Detalle de Ventas: Relaciona ventas y productos con subtotal generado
--------------------------------------------------
CREATE TABLE DetalleVentas (
    DetalleID SERIAL PRIMARY KEY,
    VentaID INT NOT NULL,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    PrecioUnitario DECIMAL(10,2) NOT NULL CHECK (PrecioUnitario >= 0),
    Subtotal DECIMAL(10,2) GENERATED ALWAYS AS (Cantidad * PrecioUnitario) STORED,
    FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

--------------------------------------------------
-- Tabla de Facturas: Facturación electrónica asociada a una venta única
--------------------------------------------------
CREATE TABLE Facturas (
    FacturaID SERIAL PRIMARY KEY,
    VentaID INT UNIQUE NOT NULL,
    NumeroFactura VARCHAR(50) UNIQUE NOT NULL,
    FechaEmision TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    XMLFactura XML,
    CreadoPorUsuarioID INT NOT NULL,
    FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID),
    FOREIGN KEY (CreadoPorUsuarioID) REFERENCES Usuarios(UsuarioID)
);

--------------------------------------------------
-- Tabla de Cuentas por Cobrar: Gestión de pagos pendientes con estado definido
--------------------------------------------------
CREATE TABLE CuentasPorCobrar (
    CuentaID SERIAL PRIMARY KEY,
    ClienteID INT NOT NULL,
    VentaID INT UNIQUE NOT NULL,
    MontoPendiente DECIMAL(10,2) NOT NULL CHECK (MontoPendiente >= 0),
    FechaVencimiento TIMESTAMP NOT NULL,
    Estado VARCHAR(50) NOT NULL CHECK (Estado IN ('Pendiente', 'Pagado', 'Vencido')),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID)
);

--------------------------------------------------
-- Tabla de Pagos: Registro de pagos realizados a cuentas por cobrar
--------------------------------------------------
CREATE TABLE Pagos (
    PagoID SERIAL PRIMARY KEY,
    CuentaID INT NOT NULL,
    FechaPago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Monto DECIMAL(10,2) NOT NULL CHECK (Monto >= 0),
    FOREIGN KEY (CuentaID) REFERENCES CuentasPorCobrar(CuentaID)
);

--------------------------------------------------
-- Tabla de Pasarelas de Pago: Información sobre pasarelas (por ejemplo, Stripe, PayPal)
--------------------------------------------------
CREATE TABLE PasarelasPago (
    PasarelaID SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) UNIQUE NOT NULL
);

--------------------------------------------------
-- Tabla de Transacciones con Pasarela: Registra la interacción con las pasarelas de pago
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
    FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID),
    FOREIGN KEY (PasarelaID) REFERENCES PasarelasPago(PasarelaID),
    FOREIGN KEY (IniciadaPorUsuarioID) REFERENCES Usuarios(UsuarioID)
);

--------------------------------------------------
-- Vistas para Reportes
--------------------------------------------------

-- Reporte: Historial de ventas por cliente
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

-- Reporte: Facturación mensual
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
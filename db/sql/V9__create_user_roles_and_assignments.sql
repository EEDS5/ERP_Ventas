--------------------------------------------------
-- V9__create_user_roles_and_assignments.sql
--
-- Creación de la tabla de Roles y su asignación a Usuarios
--------------------------------------------------

--------------------------------------------------
-- 1. Tabla de Roles: Definición de roles de usuario
--------------------------------------------------
CREATE TABLE Roles (
    RoleID SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) UNIQUE NOT NULL,
    Descripcion VARCHAR(255),
    Activo BOOLEAN NOT NULL DEFAULT TRUE
);

--------------------------------------------------
-- 2. Poblado inicial de Roles
--------------------------------------------------
INSERT INTO Roles (Nombre, Descripcion, Activo) VALUES
  ('ADMINISTRADOR', 'Acceso total al sistema', TRUE),
  ('VENDEDOR',      'Gestión de ventas y clientes', TRUE),
  ('INVENTARIO',    'Gestión de productos e inventario', TRUE),
  ('CONTADOR',      'Acceso a reportes financieros', TRUE);

--------------------------------------------------
-- 3. Tabla intermedia UsuarioRoles: many-to-many Usuarios ↔ Roles
--------------------------------------------------
CREATE TABLE UsuarioRoles (
    UsuarioRoleID   SERIAL PRIMARY KEY,
    UsuarioID       INT  NOT NULL,
    RoleID          INT  NOT NULL,
    FechaAsignacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Activo          BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (RoleID)    REFERENCES Roles(RoleID)
);

--------------------------------------------------
-- 4. Trigger para soft-delete en Roles
--------------------------------------------------
CREATE OR REPLACE FUNCTION sp_prevent_delete_Roles()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Roles SET Activo = FALSE WHERE RoleID = OLD.RoleID;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_prevent_delete_Roles
BEFORE DELETE ON Roles
FOR EACH ROW
EXECUTE FUNCTION sp_prevent_delete_Roles();

--------------------------------------------------
-- 5. Funciones almacenadas para gestionar Roles
--------------------------------------------------
-- Soft-delete de rol
CREATE OR REPLACE FUNCTION BorrarRol(_RoleID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE Roles SET Activo = FALSE WHERE RoleID = _RoleID;
END;
$$ LANGUAGE plpgsql;

-- Reactivar rol
CREATE OR REPLACE FUNCTION ReactivarRol(_RoleID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE Roles SET Activo = TRUE WHERE RoleID = _RoleID;
END;
$$ LANGUAGE plpgsql;

-- Obtener solo roles activos
CREATE OR REPLACE FUNCTION ObtenerRolesActivos()
RETURNS SETOF Roles AS $$
    SELECT * FROM Roles WHERE Activo = TRUE;
$$ LANGUAGE sql;

--------------------------------------------------
-- 6. Trigger para soft-delete en UsuarioRoles
--------------------------------------------------
CREATE OR REPLACE FUNCTION sp_prevent_delete_UsuarioRoles()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE UsuarioRoles SET Activo = FALSE WHERE UsuarioRoleID = OLD.UsuarioRoleID;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_prevent_delete_UsuarioRoles
BEFORE DELETE ON UsuarioRoles
FOR EACH ROW
EXECUTE FUNCTION sp_prevent_delete_UsuarioRoles();

--------------------------------------------------
-- 7. Funciones almacenadas para asignación de roles a usuarios
--------------------------------------------------
-- Asignar o reactivar rol en un usuario
CREATE OR REPLACE FUNCTION AsignarRolAUsuario(_UsuarioID INT, _RoleID INT)
RETURNS VOID AS $$
BEGIN
    INSERT INTO UsuarioRoles (UsuarioID, RoleID, Activo)
    VALUES (_UsuarioID, _RoleID, TRUE)
    ON CONFLICT (UsuarioID, RoleID) DO
      UPDATE SET Activo = TRUE, FechaAsignacion = NOW();
END;
$$ LANGUAGE plpgsql;

-- Quitar (soft-delete) rol de un usuario
CREATE OR REPLACE FUNCTION RemoverRolAUsuario(_UsuarioID INT, _RoleID INT)
RETURNS VOID AS $$
BEGIN
    UPDATE UsuarioRoles
    SET Activo = FALSE
    WHERE UsuarioID = _UsuarioID
      AND RoleID = _RoleID;
END;
$$ LANGUAGE plpgsql;

-- Listar roles activos de un usuario
CREATE OR REPLACE FUNCTION ObtenerRolesPorUsuario(_UsuarioID INT)
RETURNS TABLE (
    RoleID    INT,
    Nombre    VARCHAR,
    Descripcion VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT r.RoleID, r.Nombre, r.Descripcion
    FROM Roles r
    JOIN UsuarioRoles ur ON r.RoleID = ur.RoleID
    WHERE ur.UsuarioID = _UsuarioID
      AND ur.Activo = TRUE
      AND r.Activo = TRUE;
END;
$$ LANGUAGE plpgsql;

--------------------------------------------------
-- 8. Vista: Usuarios con sus roles asignados
--------------------------------------------------
CREATE OR REPLACE VIEW ViewUsuarioRoles AS
SELECT
    u.UsuarioID,
    u.NombreUsuario,
    ARRAY_AGG(r.Nombre ORDER BY ur.FechaAsignacion) AS Roles
FROM Usuarios u
LEFT JOIN UsuarioRoles ur
  ON u.UsuarioID = ur.UsuarioID
  AND ur.Activo = TRUE
LEFT JOIN Roles r
  ON ur.RoleID = r.RoleID
  AND r.Activo = TRUE
GROUP BY
    u.UsuarioID,
    u.NombreUsuario;

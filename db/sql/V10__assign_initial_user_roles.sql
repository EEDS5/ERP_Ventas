-- Asignación inicial de roles a usuarios

-- Asegura que cada par (UsuarioID, RoleID) sea único, para soportar ON CONFLICT
ALTER TABLE UsuarioRoles
  ADD CONSTRAINT uq_usuario_roles UNIQUE (UsuarioID, RoleID);

-- 1 = ADMINISTRADOR, 2 = VENDEDOR

-- Usuario “admin” → ADMINISTRADOR
SELECT AsignarRolAUsuario(1, 1);

-- Usuarios “vendedor1” … “vendedor9” → VENDEDOR
SELECT AsignarRolAUsuario(2, 2);
SELECT AsignarRolAUsuario(3, 2);
SELECT AsignarRolAUsuario(4, 2);
SELECT AsignarRolAUsuario(5, 2);
SELECT AsignarRolAUsuario(6, 2);
SELECT AsignarRolAUsuario(7, 2);
SELECT AsignarRolAUsuario(8, 2);
SELECT AsignarRolAUsuario(9, 2);
SELECT AsignarRolAUsuario(10, 2);

-- Usuario “EEDS” → ADMINISTRADOR
SELECT AsignarRolAUsuario(11, 1);

export interface Usuario {
  usuarioID: number;            // ID único generado
  nombreUsuario: string;        // Nombre de usuario
  email: string;                // Email del usuario
  twoFAEnabled: boolean;        // 2FA habilitado o no
  fechaRegistro: string;        // Fecha de registro (ISO string)
  activo: boolean;              // Estado de activo (soft-delete)

  roles?: string[];

  // Estas dos propiedades ya no serán obligatorias
  password?: string;
  secret2FA?: string;
}

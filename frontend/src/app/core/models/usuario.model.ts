export interface Usuario {
  usuarioID: number;             // ID único generado
  nombreUsuario: string;         // Nombre de usuario
  password: string;              // Contraseña del usuario
  email: string;                 // Email del usuario
  twoFAEnabled: boolean;         // 2FA habilitado o no
  secret2FA: string;             // Secreto de 2FA
  fechaRegistro: string;         // Fecha de registro (en formato ISO string)
  activo: boolean;               // Estado de activo (soft-delete)
}

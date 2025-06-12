export interface CreateClienteDTO {
  nombre: string;
  correo: string;
  telefono?: string;
  direccion?: string;
  creadoPorUsuarioId: number;
}

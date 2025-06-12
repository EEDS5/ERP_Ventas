export interface Cliente {
  clienteId: number;
  nombre: string;
  correo: string;
  telefono?: string;
  direccion?: string;
  fechaRegistro: string;
  activo: boolean;
}

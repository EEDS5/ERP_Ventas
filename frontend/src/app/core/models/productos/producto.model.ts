export interface Producto {
  productoId: number;
  nombre: string;
  descripcion: string;
  precio: number;
  stock: number;
  categoriaId: number;
  categoriaNombre: string;
  activo: boolean;
}

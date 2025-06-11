// frontend/src/app/core/config/profile.config.ts

/**
 * profile.config.ts
 *
 * Archivo de configuración de endpoints para las operaciones
 * relacionadas con el Perfil de Usuario.
 *
 * Aquí definimos las rutas de la API que el ProfileService consumirá.
 */

export const PROFILE_API = {
  // Devuelve la URL para obtener datos de un usuario por ID:
  // Ejemplo de uso: PROFILE_API.GET_BY_ID(5)  → "/api/users/5"
  GET_BY_ID: (id: number) => `/api/users/${id}`,

  // Devuelve la URL para actualizar datos de un usuario por ID:
  // Ejemplo de uso: PROFILE_API.UPDATE_BY_ID(5) → "/api/users/5"
  UPDATE_BY_ID: (id: number) => `/api/users/${id}`,

  // Devuelve la URL para obtener el perfil del usuario autenticado:
  // Ejemplo de uso: PROFILE_API.GET_MY_PROFILE() → "/api/users/me"
  UPDATE_PASSWORD: (id: number) => `/api/users/${id}/password`,
};

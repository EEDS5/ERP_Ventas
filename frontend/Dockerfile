# Dockerfile optimizado para Angular Frontend

# Etapa 1: Build de la aplicación
FROM node:20 AS build

WORKDIR /app

# Copiar package.json y package-lock.json
COPY package*.json ./

# Usar npm ci para instalación más limpia y rápida
RUN npm ci

# Copiar todo el código fuente
COPY . .

# Compilar el proyecto Angular en modo producción
RUN npm run build -- --configuration production

# Etapa 2: Imagen ligera con Nginx para servir la app
FROM nginx:alpine

# Crear directorios necesarios y dar permisos a nginx (para evitar problemas de permisos)
RUN mkdir -p /var/cache/nginx/client_temp \
 && chown -R nginx:nginx /var/cache/nginx \
 && mkdir -p /run \
 && chown -R nginx:nginx /run

# Elimina archivos de configuración innecesarios de nginx si quieres ultra-optimizar
# RUN rm /etc/nginx/conf.d/default.conf

# Copiar el build de Angular a Nginx
COPY --from=build /app/dist/ /usr/share/nginx/html

# Exponer el puerto 80
EXPOSE 80

# Mejorar seguridad: correr Nginx como usuario no root
USER nginx

# Comando para correr Nginx
CMD ["nginx", "-g", "daemon off;"]

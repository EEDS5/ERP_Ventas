# Dockerfile optimizado para Angular Frontend

# Etapa 1: Build de la aplicación o entorno de desarrollo
FROM node:20 AS build

WORKDIR /app

# Copiar package.json y package-lock.json
COPY package*.json ./

# Usar npm ci para instalación más limpia y rápida
RUN npm ci

# Copiar todo el código fuente
COPY . .

# ⬇️ BLOQUE TEMPORAL PARA NG SERVE (MODO DESARROLLO)
# Este bloque reemplaza el build de producción y Nginx solo mientras depuras

# Instalar Angular CLI globalmente (si no está en devDependencies)
RUN npm install -g @angular/cli

# Exponer el puerto 4200 para servir en modo dev
EXPOSE 4200

# Ejecutar Angular en modo desarrollo con proxy
CMD ["ng", "serve", "--host", "0.0.0.0", "--port", "4200", "--disable-host-check", "--proxy-config", "proxy.conf.json"]

# ⬆️ FIN BLOQUE TEMPORAL

# ================================
# 🔁 PARA VOLVER A PRODUCCIÓN:
# Simplemente elimina el bloque entre "⬇️" y "⬆️", y descomenta las líneas siguientes:
#
# Compilar el proyecto Angular en modo producción
#RUN npm run build -- --configuration production
#
# Etapa 2: Imagen ligera con Nginx para servir la app
#FROM nginx:alpine
#
# Crear directorios necesarios y dar permisos a nginx (para evitar problemas de permisos)
#RUN mkdir -p /var/cache/nginx/client_temp \
#&& chown -R nginx:nginx /var/cache/nginx \
#&& mkdir -p /run \
#&& chown -R nginx:nginx /run

# Elimina archivos de configuración innecesarios de nginx si quieres ultra-optimizar
#RUN rm /etc/nginx/conf.d/default.conf
#
# Copiar el build de Angular a Nginx
#COPY --from=build /app/dist/frontend-app/browser/ /usr/share/nginx/html
#
# Copiar la configuración personalizada de Nginx
#COPY nginx.conf /etc/nginx/conf.d/default.conf
#
#  Exponer el puerto 80
#EXPOSE 80
#
# # Mejorar seguridad: correr Nginx como usuario no root
#USER nginx
#
# Comando para correr Nginx
#CMD ["nginx", "-g", "daemon off;"]
# ================================

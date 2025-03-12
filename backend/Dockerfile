# Dockerfile for Spring Boot Backend (Dockerfile para el backend de Spring Boot)
FROM openjdk:11-jdk-slim

# Establece el directorio de trabajo (WORKDIR = Directorio de trabajo)
WORKDIR /app

# Copia el archivo JAR compilado al contenedor (COPY = Copiar)
COPY target/backend.jar backend.jar

# Expone el puerto 8080 (EXPOSE = Exponer)
EXPOSE 8080

# Comando para ejecutar la aplicación (CMD = Comando)
CMD ["java", "-jar", "backend.jar"]

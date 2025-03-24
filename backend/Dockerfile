# Dockerfile for Spring Boot Backend (Compilación y ejecución automática)

# Etapa 1: Compilación del proyecto usando Maven + JDK
FROM maven:3.9.4-eclipse-temurin-17 AS build

# Establece el directorio de trabajo
WORKDIR /app

# Copia todos los archivos necesarios del proyecto
COPY . .

# Compila el proyecto y genera el JAR
RUN mvn clean package -DskipTests

# Etapa 2: Contenedor liviano solo para ejecutar el JAR
FROM openjdk:17-jdk-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia el JAR compilado desde la etapa anterior
COPY --from=build /app/target/backend-0.0.1-SNAPSHOT.jar backend.jar

# Expone el puerto 8080
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "backend.jar"]
# Etapa 1: Compilación con Maven (cache-friendly)
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app

# 1) Solo pom.xml para descargar dependencias
COPY pom.xml ./
RUN mvn -B dependency:go-offline

# 2) Código fuente y build
COPY src ./src
RUN mvn -B clean package -DskipTests

# Etapa 2: Runtime sólo JRE
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Crear usuario no-root
RUN addgroup -S spring && adduser -S spring -G spring

# Copiar el JAR generado
COPY --from=build /app/target/*.jar backend.jar

# Dar permisos al usuario
RUN chown -R spring:spring /app

# Uso de usuario no-root
USER spring

# Exponer puerto y setear JAVA_OPTS
EXPOSE 8080
ENV JAVA_OPTS="-Xms256m -Xmx512m"

# Healthcheck para orquestadores
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s \
  CMD wget --quiet --tries=1 --spider http://localhost:8080/actuator/health || exit 1

# Ejecutar la aplicación
CMD ["sh", "-c", "java $JAVA_OPTS -jar backend.jar"]
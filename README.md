![CI Status](https://github.com/EEDS5/ERP_Ventas/actions/workflows/ci.yml/badge.svg)

# 🧾 ERP Ventas – Sistema de Gestión de Ventas y Facturación

Este sistema ERP está diseñado para facilitar la administración de clientes, ventas, facturación electrónica, cuentas por cobrar y generación de reportes empresariales. Se ha desarrollado bajo una arquitectura robusta y profesional, aplicando principios de diseño limpio (Clean Architecture), SOLID y separación de responsabilidades. El sistema está dividido en dos grandes módulos: backend y frontend, los cuales se comunican a través de una API RESTful.

---

## 📚 Descripción General

- **Backend**: Spring Boot 3.4.4, PostgreSQL, JasperReports, JWT, TOTP (autenticación de doble factor)
- **Frontend**: Angular 19, Angular Material, Ng Matero, Bootstrap, RxJS
- **Arquitectura**:
  - Backend: Arquitectura Hexagonal (Domain-Driven, Ports & Adapters)
  - Frontend: Arquitectura Hexagonal Invertida (Modularización por feature, inversión de dependencias)
- **Contenerización**: Docker y Docker Compose para entornos replicables
- **Documentación API**: Generada automáticamente con Swagger/OpenAPI 3.0 (`/swagger-ui/index.html`)

---

## 🛠️ Instalación y Ejecución

### Requisitos previos

- Docker y Docker Compose instalados correctamente
- Node.js v20 o superior y Angular CLI (para desarrollo local del frontend)
- JDK 17 instalado para ejecución fuera de contenedores
- Acceso a internet para descarga de dependencias

### 1. Clonar el repositorio

```bash
git clone https://github.com/usuario/erp-ventas.git
cd erp-ventas
```

### 2. Levantar todos los servicios con Docker Compose

```bash
docker compose up --build
```

Este comando inicia automáticamente los siguientes servicios:
- PostgreSQL (servidor de base de datos)
- Backend (Spring Boot REST API)
- Frontend (SPA en Angular 19)

Los puertos por defecto son:
- `localhost:5432` para PostgreSQL
- `localhost:8080` para el backend
- `localhost:4200` para el frontend

## 🚀 Instrucciones de Despliegue

### Requisitos previos

- **Docker** >= 20.10 y **Docker Compose** >= 2.20
- **Git** para clonar el repositorio
- **Node.js** 20 y **Angular CLI** (si se desea ejecutar el frontend sin Docker)
- **JDK** 17 y **Maven** 3.9 (para ejecutar el backend manualmente)

### Despliegue local con Docker Compose

1. Asegúrate de que Docker y Docker Compose estén instalados.
2. Desde la raíz del proyecto ejecuta:

```bash
docker compose up --build
```

Este comando construye las imágenes y levanta PostgreSQL, backend y frontend. Los contenedores permanecerán en segundo plano si añades `-d`.

### Ejecución manual sin Docker

1. Inicia PostgreSQL localmente o usando `docker run postgres`.
2. En `backend/` ejecuta:

```bash
./mvnw spring-boot:run
```

3. En `frontend/` instala dependencias y arranca Angular:

```bash
npm install
npm run start
```

### Acceso a la aplicación

- Frontend: <http://localhost:4200>
- API backend: <http://localhost:8080/api>
- Swagger UI: <http://localhost:8080/swagger-ui/>
- Base de datos: `localhost:5432` (`erp_user` / `erp_pass`)

### Errores comunes

- **Puertos ocupados**: modifica los puertos en `docker-compose.yml` si otros servicios ya utilizan `5432`, `8080` o `4200`.
- **Node incompatible**: usa Node 20 para evitar problemas al ejecutar `npm install`.
- **Base de datos no disponible**: verifica que el contenedor `db` esté corriendo y que las variables de entorno coincidan.

### Despliegue en producción (opcional)

Para un entorno productivo se recomienda usar el archivo `docker-compose.prod.yml`:

```bash
docker compose -f docker-compose.prod.yml up -d
```

Este comando utiliza imágenes previamente construidas y puede desplegarse en cualquier servidor que tenga Docker instalado (por ejemplo, una máquina Linux o un servicio en la nube).

---

## 🔐 Variables de Entorno

Las variables están definidas en `docker-compose.yml`, y pueden adaptarse a entornos específicos según el proveedor de nube o servidor local utilizado.

### Base de datos

- `POSTGRES_USER=erp_user`
- `POSTGRES_PASSWORD=erp_pass`
- `POSTGRES_DB=ERP_Ventas`

### Backend (Spring Boot)

- `SPRING_DATASOURCE_URL=jdbc:postgresql://db:5432/ERP_Ventas`
- `SPRING_DATASOURCE_USERNAME=erp_user`
- `SPRING_DATASOURCE_PASSWORD=erp_pass`
- `MAIL_USERNAME=example@gmail.com`
- `MAIL_PASSWORD=secret`
- `SERVER_PORT=8080` # opcional

Para producción, se recomienda el uso de perfiles (`--spring.profiles.active=prod`) y almacenes de secretos.

---

## 📁 Estructura del Proyecto

```
erp-ventas/
│
├── backend/                  # Backend Java con Spring Boot
│   ├── application/          # Casos de uso (lógica de aplicación)
│   ├── domain/               # Entidades y puertos
│   ├── infrastructure/       # Adaptadores REST, Repos, Seguridad
│   ├── resources/            # yml, reportes Jasper, etc.
│   ├── Dockerfile
│   └── pom.xml
│
├── frontend/                 # Frontend Angular
│   ├── app/                  # Features, componentes, core, shared
│   ├── assets/               # Recursos gráficos y estáticos
│   ├── environments/         # Configuración por entorno
│   ├── Dockerfile
│   ├── angular.json
│   └── package.json
│
├── db/                       # SQL de migración, configuración Flyway
│   ├── sql/
│   └── flyway.conf
│
├── docker-compose.yml        # Orquestación de todos los servicios
└── README.md                 # Documentación general del proyecto
```

---

## ▶️ Comandos Útiles

### Backend

```bash
./mvnw spring-boot:run         # Ejecutar en modo desarrollo
./mvnw clean package           # Compilar JAR
./mvnw test                    # Ejecutar pruebas
```

### Frontend

```bash
npm run start                  # Servidor de desarrollo (4200)
npm run build                  # Compilar para producción
npm run lint                   # Lint y validación de estilo
```

---

## 📌 Accesos Relevantes

| Módulo       | URL                                 |
|--------------|--------------------------------------|
| Frontend     | http://localhost:4200               |
| Backend API  | http://localhost:8080/api           |
| Swagger UI   | http://localhost:8080/swagger-ui/   |

---

## 👤 Credenciales de Prueba

- Usuario: `admin@test.com`
- Contraseña: `admin123`
- 2FA habilitado – escanear QR con Google Authenticator en `/2fa-secret`

---

## 🏛️ Información Institucional

Este sistema fue desarrollado como parte de la asignatura "Desarrollo de Aplicaciones Empresariales" dentro del plan de estudios de la carrera de Ingeniería de Sistemas. Forma parte de un trabajo práctico supervisado y documentado bajo lineamientos de buenas prácticas de desarrollo moderno.

---

## 📄 Licencia

Este sistema ERP se entrega exclusivamente para fines académicos y no puede ser utilizado comercialmente sin autorización formal de la institución responsable.
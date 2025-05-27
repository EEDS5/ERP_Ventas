# 🧾 ERP Ventas – Sistema de Gestión de Ventas y Facturación

Este sistema ERP está diseñado para facilitar la administración de clientes, ventas, facturación electrónica, cuentas por cobrar y generación de reportes empresariales. Utiliza una arquitectura moderna basada en principios de diseño limpio y escalabilidad, con enfoque modular tanto en el frontend como en el backend.

---

## 📚 Descripción General

- **Backend**: Spring Boot 3.4.4, PostgreSQL, JasperReports, JWT, TOTP
- **Frontend**: Angular 19, Angular Material, Ng Matero
- **Arquitectura**:
  - Backend con **Arquitectura Hexagonal**
  - Frontend con **Arquitectura Hexagonal Invertida**
- **Contenerización**: Docker y Docker Compose
- **Documentación API**: Swagger/OpenAPI (habilitado en `/swagger-ui/index.html`)

---

## 🛠️ Instalación y Ejecución

### Requisitos previos

- Docker y Docker Compose instalados
- Node.js 20+ y Angular CLI (solo si se ejecuta el frontend fuera de contenedor)
- Java 17

### 1. Clonar el repositorio

```bash
git clone https://github.com/usuario/erp-ventas.git
cd erp-ventas
```

### 2. Levantar todos los servicios con Docker Compose

```bash
docker compose up --build
```

Esto levantará:

- PostgreSQL en `localhost:5432`
- Backend (API REST Spring Boot) en `http://localhost:8080`
- Frontend (Angular) en `http://localhost:4200`

---

## 🔐 Variables de Entorno

Definidas directamente en `docker-compose.yml`:

### Base de datos
- `POSTGRES_USER=erp_user`
- `POSTGRES_PASSWORD=erp_pass`
- `POSTGRES_DB=ERP_Ventas`

### Backend (spring-boot)
- `SPRING_DATASOURCE_URL=jdbc:postgresql://db:5432/ERP_Ventas`
- `SPRING_DATASOURCE_USERNAME=erp_user`
- `SPRING_DATASOURCE_PASSWORD=erp_pass`

---

## 📁 Estructura del Proyecto

```
erp-ventas/
│
├── backend/                  # Backend Java con Spring Boot
│   ├── src/                 # Código fuente
│   ├── Dockerfile
│   └── pom.xml
│
├── frontend/                # Frontend Angular
│   ├── src/
│   ├── Dockerfile
│   ├── angular.json
│   └── package.json
│
├── db/
│   ├── sql/                 # Scripts iniciales para Flyway
│   └── flyway.conf
│
├── docker-compose.yml       # Orquestación de servicios
└── README.md
```

---

## ▶️ Comandos Útiles

### Backend
```bash
./mvnw spring-boot:run        # Ejecutar backend localmente
./mvnw test                   # Ejecutar pruebas unitarias
```

### Frontend
```bash
npm run start                 # Ejecutar en desarrollo (puerto 4200)
npm run build                 # Compilar para producción
npm run lint                  # Validar estilo de código
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
- (2FA habilitado – usar Google Authenticator si aplica)

---

## 🏛️ Información Institucional

Proyecto desarrollado en el contexto académico de la carrera de Ingeniería de Sistemas, como parte de la asignatura “Desarrollo de Aplicaciones Empresariales”.

---

## 📄 Licencia

Este sistema es parte de un proyecto académico y no debe ser utilizado con fines comerciales sin autorización.
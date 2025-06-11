# Technical Overview

## Project Description and Goals
ERP Ventas is an academic sales management system that demonstrates best practices for modern enterprise development. The goal is to integrate a secure backend, a modular frontend and automated deployment pipelines while keeping the code easy to extend.

## Repository Structure
- **backend**: Spring Boot REST API with JasperReports and Flyway migrations
- **frontend**: Angular application
- **db**: PostgreSQL initialization scripts and Flyway config
- **CI/CD**: `azure-pipelines.yml`, Dockerfiles and compose files

## Key Dependencies
- Spring Boot 3.4
- PostgreSQL with Flyway
- JasperReports for PDF generation
- Angular 19 with Angular Material
- Docker and Docker Compose

## Installation and Configuration
1. Clone the repository
   ```bash
   git clone https://github.com/usuario/erp-ventas.git
   cd erp-ventas
   ```
2. Copy or adjust environment variables defined in `docker-compose.yml`.
3. Launch all services with Docker Compose:
   ```bash
   docker compose up --build
   ```
   This starts PostgreSQL, the backend API and the Angular frontend.

### Development vs. Production
- **Development**: Run `./mvnw spring-boot:run` for the backend and `npm run start` for the frontend. Data will persist in local Docker volumes.
- **Production**: Use `docker-compose.prod.yml` with production environment variables. Enable Spring profile `prod` and configure external databases or secrets as needed.

## Primary Workflows
- **Authentication**: JWT-based login with optional 2FA via TOTP.
- **Sales Flow**: Manage customers and invoices, then track payments through accounts receivable.
- **Reporting**: JasperReports templates generate PDF or XLS reports accessible from the API.

## Architecture
- **Backend**: Implements a hexagonal (ports and adapters) approach. Domain logic is isolated from infrastructure such as web controllers and persistence.
- **Frontend**: Structured by features using a modular approach. Shared modules provide reusable UI components and services.

## Testing and CI/CD
- Backend tests run with Maven (`./mvnw test`).
- Frontend unit tests run with `ng test`.
- CI pipelines build and test on every push using the supplied Azure pipeline configuration.

## Contributing
1. Fork the repository and create feature branches.
2. Follow existing coding style and include tests for new features.
3. Submit pull requests for review.

## Future Expansion
The project can be extended with additional modules such as inventory, purchase orders and advanced reporting dashboards. Contributions and feedback are welcome.
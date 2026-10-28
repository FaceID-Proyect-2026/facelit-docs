# Repositorios del proyecto

**FaceLit | Repositorios oficiales | Corte: 27 oct 2026**
FaceLit | enlaces oficiales, función y rama principal

| Repositorio | Responsabilidad y tecnología | Rama |
|---|---|---|
| [**FaceLit**](https://github.com/FaceID-Proyect-2026/FaceLit) | Interfaz web/móvil; flujos por rol, gestión, asistencia y facial. <br> Expo Router, React Native, TypeScript | `main` |
| [**FaceLit-Backend**](https://github.com/FaceID-Proyect-2026/FaceLit-Backend) | API: autenticación, datos académicos, sesiones, asistencia, facial y notificaciones. <br> Java 17, Spring Boot | `main` |
| [**micro-facial**](https://github.com/FaceID-Proyect-2026/micro-facial) | Embeddings, prueba de vida y comparación facial. <br> Python 3.11, FastAPI | `main` |
| [**FaceLit-DB**](https://github.com/FaceID-Proyect-2026/FaceLit-DB) | Esquema, datos iniciales y migraciones. <br> PostgreSQL 16, pgvector, Liquibase | `main` |
| [**facelit-docs**](https://github.com/FaceID-Proyect-2026/facelit-docs) | Repositorio documental: requisitos, diseño, pruebas, manuales, anexos y despliegue. | `main` |

**Arquitectura:** FaceLit consume la API Spring Boot; el backend coordina el servicio facial FastAPI y consulta PostgreSQL. FaceLit-DB administra las migraciones.

> **Nota:** todos se documentan en la rama principal `main`, según lo solicitado. Esta lista identifica los enlaces y no certifica que los checkouts locales estén cambiados a esa rama ni que sus commits estén desplegados. La carpeta `facelit-docs` tiene reorganización local pendiente de commit.

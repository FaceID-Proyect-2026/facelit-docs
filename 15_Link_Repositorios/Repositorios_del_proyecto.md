# Repositorios del proyecto

**FaceLit | Revisión local del 4 de noviembre de 2026**

| Repositorio | Responsabilidad y tecnología | Rama local | HEAD local |
|---|---|---|---|
| [**FaceLit**](https://github.com/FaceID-Proyect-2026/FaceLit) | Interfaz web/móvil; flujos por rol, gestión, asistencia y facial. · Expo Router, React Native, TypeScript | `main` | `6efd92c` |
| [**FaceLit-Backend**](https://github.com/FaceID-Proyect-2026/FaceLit-Backend) | API: autenticación, datos académicos, sesiones, asistencia, facial y notificaciones. · Java 17, Spring Boot | `main` | `2ba7398` |
| [**micro-facial**](https://github.com/FaceID-Proyect-2026/micro-facial) | Embeddings, prueba de vida y comparación facial. · Python 3.11, FastAPI | `main` | `166e4a7` |
| [**FaceLit-DB**](https://github.com/FaceID-Proyect-2026/FaceLit-DB) | Esquema, datos iniciales y migraciones. · PostgreSQL 16, pgvector, Liquibase | `main` | `cd069ae` |
| [**facelit-docs**](https://github.com/FaceID-Proyect-2026/facelit-docs) | Repositorio documental: requisitos, diseño, pruebas, manuales, anexos y despliegue. | `main` | `c3a96d1` |

**Arquitectura:** FaceLit consume la API Spring Boot; el backend coordina el servicio facial FastAPI y consulta PostgreSQL. FaceLit-DB administra las migraciones.

Los enlaces coinciden con los remotos `origin` configurados. La tabla registra el commit de cada copia local. Para identificar los commits de una publicación, consulta el manifiesto de esa versión.

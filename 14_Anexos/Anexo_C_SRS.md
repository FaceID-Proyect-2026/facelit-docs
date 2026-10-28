# Anexo C — Inventario funcional actual

**FaceLit | Documentación del proyecto | Corte 27 oct 2026**
Capacidades localizadas en los cuatro repositorios FaceLit | Corte 27 de octubre de 2026

Este inventario distingue interfaz, contratos API y persistencia en código. La presencia de una pantalla, endpoint o migracion no prueba por si sola que un flujo se haya aceptado en producción.

## C.1 Arquitectura del sistema

| Capa | Responsabilidad actual | Tecnologías |
|---|---|---|
| Interfaz web/móvil | Rutas por rol, formularios, consultas, captura facial en web y preferencias. | Expo Router, React Native, TypeScript |
| API de negocio | Autenticacion, usuarios, gestión académica, sesiones, eventos faciales/asistencia, notificaciones y perfil. | Java 17, Spring Boot 3.4.1, JWT, JDBC/JPA |
| Servicio facial | Embeddings, retos de prueba de vida y matching de candidatos de sesión. | Python 3.11, FastAPI, InsightFace, MediaPipe, ONNX |
| Datos/migraciones | Esquema relacional compartido, pgvector, catalogos e historico de cambios. | PostgreSQL 16 + pgvector, Liquibase |

### Flujo de reconocimiento

Aprendiz / navegador web captura y completa dos retos aleatorios → API Spring valida cuenta, sesión y autorización → FastAPI analiza imagen/frames y compara plantilla → PostgreSQL conserva los registros definidos por el esquema → API responde el resultado a la interfaz. La API key entre backend y microservicio es de servidor; no debe publicarse en `EXPO_PUBLIC`.

### Repositorios y línea base

FaceLit `5f7d6fe` (dev); FaceLit-Backend `2ab0bcd` (dev); micro-facial `1e12c6c` (dev); FaceLit-DB `41a063f` (main). El checkout frontend presentaba cambios locales en `app.json`/`eas.json` no incluidos en su SHA. No se certifica un artefacto móvil o despliegue con esta inspección.

---

## C.2 Inventario por rol

| Area | Capacidades visibles / conectadas en código | Limite que debe recordarse |
|---|---|---|
| Acceso | Login, recuperacion, verificación de identidad y nueva contraseña. | Configurar correo/SMTP y probar expiración, límites y errores. |
| Coordinador | Usuarios y roles, programas/fichas, CSV, ambientes, vistas de asistencia/reportes, bandeja de notificaciones. | Backend define roles; validar acceso UI/API y cada operación de negocio. |
| Instructor | Consulta de fichas, configuración de sesión facial (ambiente, instructor, ficha, horarios), captura facial y consulta de asistencia/reportes. | La camara de asistencia se ofrece en web; fin de sesión puede requerir contraseña del responsable/reemplazo. |
| Aprendiz | Panel personal, asistencia, notificaciones, perfil/preferencias y registro facial. | El registro facial se muestra como no disponible en celulares; requiere versión web. |
| Comunes | Perfil, idioma ES/EN/DE/FR, tema y notificaciones. | Persistencia y sincronizacion de cada ajuste deben verificarse con versión desplegada. |

---

## C.3 Integraciones identificadas

| Dominio | Integracion localizada | Estado de evidencia |
|---|---|---|
| Autenticacion / perfil | REST `/api/auth`, `/api/profile`, configuración; JWT. | Contrato y persistencia en código; pruebas de seguridad pendientes. |
| Académico / CSV | `/api/academic` para programas, fichas (chip), instructores, aprendices, CSV, transferencias e historial. | Servicios backend/frontend; comprobar todos los casos de carga y traslado. |
| Ambientes / sesiones | `/api/environment` para catalogo soportado y sesiones activas, horarios y clave de salida. | Integracion parcial; no suponer CRUD completo donde no haya endpoint. |
| Facial | `/api/facial` para estado, enrolamiento y autorización; microservicio `/api/v1/facial-embeddings` para imagen, liveness, plantilla y matching. | Flujo actual coordinado en código; aceptar solo tras prueba integrada de versiones compatibles. |
| Asistencia | Eventos faciales persistidos y consultas/matriz de asistencia en API, backend y esquema DB. | Revisar cobertura de informes, eventos manuales, correccion, permisos y exportacion. |
| Notificaciones / tiempo real | Bandeja REST, lectura, resolucion de solicitud facial, catalogo de correo y WebSocket. | Eventos, reintentos, SMTP y reconexión requieren prueba en entorno. |

---

## C.4 Modelo de datos y decisiones de alcance

El modelo compartido incluye cuentas/roles, recuperacion y configuración; programas, fichas, aprendices, instructores y relaciones; ambientes y sesiones; notificaciones; autorizaciones de reinicio facial, plantillas/eventos faciales y asistencia. El esquema real lo controla FaceLit-DB mediante Liquibase. La revisión de clases/changelogs no es una inspección de la base instalada.

### Fuera del alcance o no acreditado

- La administración de horarios académicos/excepciones fue retirada del alcance vigente. Las rutas o notas historicas no son contrato funcional. Las sesiones de ambiente con tiempos de entrada/salida son un dominio separado.
- No se encontro implementación Raspberry Pi ni sincronizacion offline cifrada en los repositorios examinados.
- Cifrado biometrico en reposo, retención y eliminación de imagen original, controles completos de privacidad y calibracion formal del matching no se acreditan por el inventario estatico.
- No se inspeccióno una instancia productiva ni se ejecutaron pruebas de aceptación durante la preparacion de este anexo.

### Fuentes

README, controladores, servicios, configuraciones, migraciones, rutas frontend y contratos de FaceLit, FaceLit-Backend, micro-facial y FaceLit-DB, en los SHAs indicados. Para aceptar una funcion, conservar resultado de prueba por rol, entorno y versión.

---
---

# ANEXO HISTORICO — INVENTARIO ANTERIOR

> Estas paginas reproducen, sin modificacion, el inventario recibido. Algunas rutas, integraciones y limites descritos ya no representan el alcance actual. Usa las paginas iniciales de este PDF para consultar el inventario del corte 27 de octubre de 2026; esta parte se conserva solo como referencia historica.
>
> Fin de la actualizacion; comienza la copia historica sin cambios.

## Anexo C. Inventario funcional del sistema implementado

Este anexo registra las capacidades visibles en el frontend y los servicios/endpoints localizados en FaceLit-Backend. "Existe en interfaz" describe pantallas y lógica cliente; "conectado" indica llamadas encontradas al backend; no equivale a una prueba de ejecución, despliegue o aceptación. Las claves RF-C1 a RF-C4 amplían el inventario funcional original.

### C.1 Requisitos funcionales complementarios

| ID / requisito | Comportamiento evidenciado | Estado y fuente |
|---|---|---|
| RF-C1 Horarios y excepciones | Vistas admin/instructor de lista, registro, detalle y excepciones. Cliente contempla búsqueda/estado, conflictos, sustitución, cancelación o reprogramación. | Interfaz y lógica cliente; store inicializado con datos mock. No se encontró API de horarios en el backend suministrado. |
| RF-C2 Ambientes y sesiones | Vistas admin/instructor para ambientes. Para configurar sesiones el cliente consulta ambientes, instructores y fichas elegibles, crea sesiones y actualiza registros. | Parte del catálogo CRUD usa store/mock; backend ofrece GET/POST ambientes, consultas elegibles y POST/PUT sesiones bajo `/api/environment`. |
| RF-C3 Preferencias de perfil | Perfil y configuración personal; idioma, tema y activación de notificaciones; opciones ES, EN, DE, FR. | Cliente consume GET/POST/PUT `/api/profile/configuration`. Persistencia por opción y entre sesiones debe confirmarse con prueba. |
| RF-C4 Sincronización en tiempo real | WebSocket cliente con token; mensajes ready, sync, data.changed, authentication.failed; reconexión exponencial hasta 30 s. Backend tiene handler e interceptor. | Código cliente/servidor presente; URL, eventos por operación, autorización y reconexión requieren prueba integrada. |

### C.2 Inventario de pantallas frontend

Rutas encontradas como archivos de pantalla. Los layouts por rol invocan guard de autenticación; la inspección estática no certifica permisos en cada acción.

| Área / rol | Rutas encontradas | Alcance visible |
|---|---|---|
| Acceso/común | `/`; `/auth/login`; `/auth/verify-identity`; `/auth/password-recovery`; `/auth/newpassword`; `/notifications`; `/profile`; `/profile/settings` | Acceso, recuperación, notificaciones, perfil y preferencias. |
| Administrador usuarios | `/admin`; `/admin/users`; `/admin/users/create`; `/admin/users/[id]` | Panel, listado, creación y detalle de cuentas. |
| Administrador académico | `/admin/academic`; `/admin/academic/csv-upload`; `/admin/academic/assignments`; `/admin/academic/instructors`; `/admin/academic/programs/register`, `[id]`; `/admin/academic/fichas/register`, `[id]`; `/admin/academic/transfer-requests` | Gestión académica, carga CSV, asignaciones y traslados. |
| Administrador ambiente/horario | `/admin/environments`; `/admin/environments/register`, `[id]`; `/admin/schedules`; `/admin/schedules/register`, `[id]`; `/admin/schedules/exceptions` | Ambientes y horarios/excepciones. |
| Administrador asistencia/reportes | `/admin/attendance`; `/admin/attendance/[id]`; `/admin/attendance/by-user`; `/admin/attendance/by-ficha`; `/admin/attendance/history`; `/admin/reports`; `/admin/reports/by-user`; `/admin/reports/by-ficha`; `/admin/reports/calendar`; `/admin/reports/my-performance`; `/admin/reports/excuses-review` | Consultas, historial, calendario, desempeño, excusas y exportaciones. Asistencia/reportes usan fuente local de demostración; excusas inicia vacía y no se encontró API. |
| Instructor académico | `/instructor`; `/instructor/academic`; `/instructor/academic/programs/register`, `[id]`; `/instructor/academic/fichas/register`, `[id]` | Panel, consulta/registro de información académica. |
| Instructor otros módulos | `/instructor/environments/register`, `[id]`; `/instructor/schedules`; `/instructor/schedules/register`, `[id]`; `/instructor/schedules/exceptions`; `/instructor/facial`; `/instructor/facial/settings`; `/instructor/facial/camera`; `/instructor/attendance`; `/instructor/attendance/[id]`; `/instructor/attendance/by-user`; `/instructor/attendance/by-ficha`; `/instructor/reports`; `/instructor/reports/by-user`; `/instructor/reports/byficha`; `/instructor/reports/calendar`; `/instructor/reports/my-performance`; `/instructor/reports/excuses-review` | Configuración, captura facial, horarios, asistencia y reportes. |
| Aprendiz | `/apprentice`; `/apprentice/attendance`; `/apprentice/facial`; `/apprentice/joinficha`; `/apprentice/transfer-request` | Inicio, asistencia, facial, vinculación y traslado. No se encontró pantalla de horarios ni reportes del aprendiz. |

### C.3 Integraciones y contratos localizados

| Dominio | Endpoints backend encontrados | Correspondencia / límite |
|---|---|---|
| Autenticación | `/api/auth` POST `/login`, `/privacy-acceptance-status`, `/request-recovery`, `/verify-token`, `/reset-password`, `/change-password`. | El frontend además llama registro/verificación/consentimiento/catálogos; no se hallaron esos controladores en el backend entregado. |
| Usuarios/perfil | `/api/admin/users` GET colección/count/search/detalle; POST, PUT, DELETE; `/{id}/role` PUT; `/api/profile/me` GET; `/api/profile/configuration` GET/POST/PUT. | Operaciones de usuarios, perfil y preferencias. |
| Académico | `/api/academic/programs`; `/programs/{id}/chips`; `/chips`; `/chips/{id}`; rutas de apprentices, vínculo/historial/traslado; rutas instructors; `/api/academic/csv/template`, upload, pending-transfers y decisiones; `/api/academic/change-history` GET. | Programas, fichas (Chip), aprendices, instructores, CSV, traslados e historial. |
| Ambiente/sesiones | `/api/environment/environments` GET/POST; `/instructors-for-session` GET; `/chips-for-instructor/{id}` GET; `/sessions` POST; `/sessions/{idRecordEnvironment}` PUT. | No se identificó backend para el store completo CRUD de ambientes del frontend. |
| Notificaciones/asistencia | `/api/notifications` GET, PATCH `/{id}/read`, `/read-all`, POST, `/events`, `/{id}/facial-request`; `/api/attendance/events` POST. | La ruta de evento de asistencia genera notificación; no se encontró entidad de asistencia persistida. Cliente mezcla consulta remota con fixtures/eventos locales. |
| Facial | `/api/facial/profile-photo`; `/me`; `/challenge`; `/enrollment`. Cliente invoca también servicio externo `/api/v1/facial-embeddings/from-image` y PATCH `/api/v1/facial-embeddings/users/{userId}`; no se verificó integración entre ambos contratos. | Contratos distintos entre cliente y backend; integración no verificada. |
| Tiempo real | WebSocket `/ws/realtime`; handler e interceptor de cambios. | Validar permisos, URL de despliegue, token y eventos en prueba integrada. |

### C.4 Fuente de datos y persistencia por módulo

| Módulo | Fuente/persistencia observada | Conclusión |
|---|---|---|
| Usuarios/autenticación/configuración | Servicios REST del backend; JWT y BCrypt en seguridad; entidad de configuración. | Persistencia disponible en código; requiere pruebas operativas/de seguridad. |
| Programas/fichas/instructores/CSV | Entidades, repositorios, controladores y servicios cliente; hidratación del store académico. | Backend implementa esos dominios. Verificar flujo de cada pantalla antes de afirmar integración completa. |
| Ambientes/sesiones | Store local/mock para parte del catálogo; API para ambientes básicos y sesiones. | Integración parcial; documentar qué acción persiste en servidor. |
| Horarios/excepciones | Stores de frontend con datos mock; no hay endpoint/backend localizado. | Persistencia compartida no evidenciada. |
| Asistencia/reportes | Registros locales de demostración; hooks calculan historial, calendario, desempeño y exportación. | No se encontró persistencia de asistencia en backend; reportes no prueban asistencia institucional real. |
| Excusas | Vista inicia vacía; código indica que falta servicio real. | Sin entidad/controlador/API localizado. |
| Biometría | Store mock en frontend; cliente usa servicio externo de embeddings; backend ofrece otro flujo de perfil/reto/enrolamiento. | Contratos distintos; integración end-to-end no verificada. |
| Notificaciones | Controlador/entidad backend y cliente con fixtures, store local y consultas/lecturas REST. | Persistencia existe para operaciones soportadas; no todos los eventos/correos están conectados. |
| Preferencias/idiomas | API de configuración y estado global UI; idiomas ES/EN/DE/FR. | Probar qué opciones persisten por usuario y tras reinicio. |

### C.5 Modelo de dominio y límites de evidencia

Las entidades/clases identificadas abarcan usuarios, credenciales, recuperación, sesión de usuario, configuración, aceptación de términos, roles/permisos; programas, fichas (Chip), aprendices, instructores, asignación instructor-programa, vínculo usuario-ficha, transferencias CSV e historial; ambientes/registros de ambiente o sesión; notificaciones y registro de correo; perfil y datos faciales. La lista deriva de clases del repositorio, no de inspección de una base desplegada.

No se encontró entidad/controlador/servicio de persistencia para asistencia, horarios, excepciones o excusas. `POST /api/attendance/events` recibe evento para generar notificación, según el controlador revisado; no demuestra almacenamiento de asistencia. No se suministró código de Raspberry Pi ni operación offline.

La inspección es estática: hallar una ruta frontend, servicio o endpoint no certifica flujo extremo a extremo, permisos correctos ni entorno productivo. La aceptación requiere pruebas por rol y evidencias.

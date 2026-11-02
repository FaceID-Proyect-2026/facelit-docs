# FaceLit — propuesta técnica y arquitectura implementada

**Corte de referencia:** 27 de octubre de 2026.  
**Distinción:** este documento registra la arquitectura descrita para el sistema actual; la propuesta de Render/Vercel de los documentos previos se conserva como antecedente histórico.

> Estado consolidado de los árboles HU-48: [Arquitectura HU-48](Arquitectura_HU48.md). El contenido fechado del 27 de octubre se conserva como referencia histórica.

## Arquitectura lógica

FaceLit se organiza en tres componentes de ejecución y un repositorio de migraciones para la base compartida:

1. **Cliente FaceLit:** Expo/React Native. La versión web entrega pantallas y controla navegación, captura, estado y solicitudes HTTP.
2. **Backend FaceLit-Backend:** Java 17 y Spring Boot 3.4.1. Es un monolito modular organizado en autenticación, gestión académica, ambientes/sesiones, facial/asistencia, notificaciones y módulos compartidos.
3. **Servicio micro-facial:** Python 3.11 y FastAPI. Ejecuta detección, generación de embeddings, evaluación de retos y búsqueda de coincidencia para el contexto de sesión.
4. **FaceLit-DB:** PostgreSQL 16 con pgvector y Liquibase. El repositorio administra esquemas, datos iniciales y cambios versionados; no es un servicio HTTP separado.

## Conexiones

- Navegador → Caddy por HTTPS para servir la web y para solicitudes HTTP/WebSocket.
- Caddy → backend Spring Boot para API y canal WebSocket.
- Backend → servicio facial por HTTP en la red privada de Compose, con una clave de servicio mantenida en el servidor.
- Backend → PostgreSQL mediante JPA/JDBC.
- Servicio facial → PostgreSQL mediante SQLAlchemy asíncrono y asyncpg.
- Liquibase → PostgreSQL antes de que el backend valide el esquema.

La guía describe el backend como punto de coordinación del flujo de asistencia. El frontend actual envía registro facial al endpoint del backend bajo /api/facial/embeddings; el servicio Java puede invocar el servicio FastAPI. En el código del frontend revisado, la clave facial no se usa en la llamada del flujo, pero el README de ese repositorio aún menciona variables EXPO_PUBLIC de integración facial heredadas. Eliminar esas referencias de configuración/documentación y revisar el bundle es una tarea de seguridad pendiente; no afirmar que toda credencial histórica fue retirada hasta comprobarlo.

## Flujo principal de asistencia

1. El cliente envía por HTTPS la captura y el identificador/contexto de sesión al backend.
2. El backend valida identidad, rol, alcance y contexto de sesión.
3. Para la evaluación facial, el backend llama al servicio FastAPI y espera su respuesta.
4. El servicio decodifica las imágenes, detecta el rostro, genera características y valida la secuencia de retos; consulta candidatos autorizados en PostgreSQL.
5. El backend aplica reglas de horario, entrada/salida y duplicados.
6. Si la operación cumple las reglas, se persiste el evento y se responde al cliente.

La web no debe conectarse directamente a PostgreSQL ni exponerse a la clave interna del servicio facial. El servicio facial no necesita un puerto público para el flujo documentado.

## Capas y responsabilidades

| Componente | Entrada/presentación | Aplicación/negocio | Datos e integraciones |
|---|---|---|---|
| FaceLit | Rutas, pantallas y componentes | Hooks coordinan acciones, formularios y estado | Servicios HTTP y stores |
| Backend | Controladores y DTO | Servicios y políticas de autorización | Repositorios JPA/JDBC, correo, WebSocket y cliente facial |
| Micro-facial | Rutas FastAPI y esquemas Pydantic | Servicio de embedding y política de liveness | SQLAlchemy, PostgreSQL, trabajador de inferencia |
| FaceLit-DB | No aplica como capa web | Reglas de esquema, relaciones y restricciones | SQL, changelogs, índices y Liquibase |

Las tres capas son una separación lógica dentro de las aplicaciones, no tres servidores por aplicación. El backend sigue siendo un monolito modular.

## Tecnologías y motivo de uso

| Tecnología | Responsabilidad documentada |
|---|---|
| Expo, React Native y TypeScript/JavaScript | Interfaz, navegación y acceso a cámara |
| Java/Spring Boot | API, reglas de negocio y coordinación transaccional |
| Spring Security/JWT | Identidad y autorización de solicitudes |
| Python/FastAPI/Pydantic | API facial y contratos de solicitudes/respuestas |
| InsightFace/ONNX Runtime | Detección y representación facial |
| MediaPipe | Puntos/métricas faciales para evaluar movimientos |
| PostgreSQL/pgvector | Datos relacionales y vectores faciales |
| SQLAlchemy/asyncpg | Acceso asíncrono a PostgreSQL desde Python |
| Liquibase | Evolución reproducible del esquema |
| Docker Compose/Caddy | Servicios privados en la red del VPS y terminación/proxy HTTPS |
| WebSocket | Actualizaciones seleccionadas sin depender solo de refrescar la página |

## Decisiones y límites

- Los módulos del backend no son microservicios independientes.
- Backend y facial comparten la base; la independencia de datos no está implementada.
- No se ha medido rendimiento bajo carga ni tiempo máximo garantizado.
- La existencia de interfaces, capas o tests no demuestra que cada requisito esté aceptado en producción.
- El flujo facial y de asistencia físico debe validarse con la versión desplegada y cámara real.

## Referencias de código

SHA de referencia: FaceLit 5f7d6fe, FaceLit-Backend 2ab0bcd, micro-facial 1e12c6c y FaceLit-DB 41a063f. Ejemplos verificables en esos repositorios: FaceLit/features/facial/livenessChallenges.ts; FaceLit-Backend/.../FacialEmbeddingVerificationClient.java; micro-facial/app/services/liveness_validator.py; FaceLit-DB/06_migrations/.

## Addendum HU-48 — límites de dominio y catálogo de ambientes

**Corte del addendum:** 2 de noviembre de 2026. Complementa la referencia histórica anterior; los cambios de HU-48 aún requieren revisión y validación de integración.

### Responsabilidad por dominio

| Componente | Autoridad | Datos que puede solicitar o persistir |
|---|---|---|
| FaceLit | Experiencia, captura, validación de formulario y presentación de resultados | No consulta la base ni conserva credenciales de micro-facial |
| FaceLit-Backend | Identidad autenticada, roles, ficha/sesión, elegibilidad y reglas de asistencia | Resuelve `apprentice_id`, construye el alcance autorizado y persiste el evento |
| micro-facial | Inferencia, liveness, comparación y ciclo de vida de la plantilla facial | Recibe IDs ya resueltos; opera en el código sobre `facialrecognition.user_face` y `facialrecognition.face_reset_request` |
| FaceLit-DB | Esquema, relaciones, restricciones, permisos y migraciones | Liquibase versiona contratos relacionales; CI debe validar cambios compatibles |

### Contratos internos de HU-48

- Para enrolamiento, Spring deriva el aprendiz del JWT validado y envía `apprentice_id`; el `reset_owner_user_id` también proviene del principal autenticado, no del cuerpo del cliente. El microservicio consume el token de reemplazo solo para ese propietario.
- Para asistencia, Spring valida sesión, ficha y operador. Envía a FastAPI `candidate_apprentice_ids` de aprendices activos de esa ficha. FastAPI compara solo contra esa lista; ya no recibe ni consulta el ID de sesión.
- Spring comprueba nuevamente el resultado antes de persistir asistencia. El vector facial no se devuelve al cliente.
- La gestión de catálogo del coordinador vive en `/api/admin/environments/**`; `/api/environment/**` permanece como operación de sesión del instructor. Desactivar conserva historial y se bloquea mientras haya sesiones activas o programadas.

### Límite pendiente de despliegue

El código de micro-facial deja de consultar tablas de `security`, `academic` y `environment`. FaceLit-DB ahora versiona un rol de grupo y grants limitados a los objetos de `facialrecognition`; incluye un script para provisionar el login dedicado. El workflow de micro-facial prepara ese rol en PostgreSQL efímero y comprueba acceso permitido y denegado. Ambos procesos siguen conectados al mismo PostgreSQL físico, así que hay aislamiento de privilegios por esquema, no aislamiento físico.

El usuario de ejecución puede leer/escribir las plantillas y consumir tokens de reset aprobados; no recibe acceso a identidad, fichas, ambientes ni asistencia. La CI incorpora una comprobación de privilegios antes de la suite, pero aún debe ejecutarse en el commit final. Los flujos de enrolamiento, reset y asistencia necesitan aprobación de integración con la credencial restringida antes de declarar cerrado el gate de despliegue.

La evaluación de estadísticas y la matriz completa de brechas está en [Evaluación arquitectónica y brechas HU-48](Evaluacion_Arquitectura_y_Brechas_HU48.md).

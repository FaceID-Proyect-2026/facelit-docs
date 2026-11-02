# FaceLit — Plan profesional de implementación para revisión del equipo

**Alcance:** observaciones 1, 2, 3, 13, 16, 18 y 19 (7 puntos).  
**Responsable propuesta:** Valery.  
**Estado:** borrador técnico-funcional para revisión de la compañera y aprobación institucional.  
**Fecha:** 1 de noviembre de 2026.

> Este documento define una ruta de implementación. No representa aprobación legal, no afirma que el trabajo ya esté implementado y no reemplaza decisiones de la institución responsable.

## 1. Resumen para revisión

| N.º | Observación | Dificultad estimada | Repositorios principales |
|---:|---|---|---|
| 1 | Términos y tratamiento de datos | Alta: inventario, responsables y plazos primero | `facelit-docs`, `FaceLit`, `FaceLit-Backend`, `FaceLit-DB`; `micro-facial` según el flujo real |
| 2 | Informar antes del registro de usuarios | Media: depende del proceso de alta e importación | `FaceLit`, `FaceLit-Backend`, opcionalmente `FaceLit-DB` |
| 3 | Registro biométrico voluntario | Alta: requiere consentimiento separado, alternativa y control de servidor | `FaceLit`, `FaceLit-Backend`, `FaceLit-DB`, `micro-facial` |
| 13 | Acceso a descarga Android | Media: falta confirmar y alojar un APK oficial | `FaceLit`, configuración de compilación/publicación Android |
| 16 | Aviso de vencimiento de notificaciones y purga de asistencia semestral | Media-alta: avisos a tres roles y limpieza de datos con dependencias | `FaceLit-Backend`, `FaceLit-DB`, `FaceLit` |
| 18 | Confirmar eliminación/desactivación | Baja-media: hay confirmaciones parciales que deben aclararse | `FaceLit`; `FaceLit-Backend` si se muestra un resumen de impacto calculado en servidor |
| 19 | Resolver asignaciones antes de retirar instructores | Alta: requiere revisar relaciones e historial | `FaceLit`, `FaceLit-Backend`, `FaceLit-DB` |

### Nota sobre el alcance

Las observaciones 1 y 3 son una combinación de redacción, política institucional, interfaz y persistencia. No deben considerarse resueltas únicamente por añadir un texto. La observación 16 ahora incluye una advertencia de vencimiento para los tres roles y retención de asistencia por seis meses; esto requiere acordar el comportamiento exacto y revisar dependencias de datos antes de purgar. Las observaciones 18 y 19 también afectan el ciclo de vida de datos o relaciones y requieren cambios de backend, aunque la primera tarea visible sea un botón o modal.

## 2. Hallazgos actuales del proyecto

- La pantalla de privacidad presenta finalidades generales, incluyendo asistencia biométrica, pero no detalla responsable, personas con acceso, conservación por tipo de dato ni el procedimiento completo para ejercer derechos. Está en `FaceLit/shared/i18n/locales/es.ts` y `FaceLit/features/auth/components/PrivacyNoticeModal.tsx`.
- El login exige la aceptación del aviso para continuar y el backend la almacena como un indicador booleano. El esquema `legal.terms_acceptance` no identifica el tipo ni la versión del texto aceptado. Ver `FaceLit/features/auth/hooks/useLoginForm.ts`, `FaceLit-Backend/.../LoginServiceImpl.java` y `FaceLit-DB/01_ddl/03_tables/006_create_legal_tables.sql`.
- El recorrido del aprendiz para registrar el rostro muestra una confirmación de identidad/responsabilidad; no equivale por sí sola a una elección independiente de autorización biométrica. Revisar `FaceLit/features/facial/components/FacialIdentityConfirmation.tsx` y `FaceLit/features/facial/hooks/useApprenticeFacial.ts`.
- El cliente y el servidor ya tienen rutas para enrolamiento facial. La validación técnica del proyecto reporta brechas de alineación del flujo, controles biométricos y manejo de imagen/plantilla. Consultar `VALIDACION_SRS.md`, hallazgos H05 y H12, antes de ampliar ese flujo.
- La interfaz administrativa ya solicita confirmación para desactivar una cuenta, pero el mensaje debe explicar con precisión el efecto real. La desactivación de instructor está disponible en backend y revoca sesiones; se debe revisar además el estado de sus asignaciones. Ver el punto 19.
- La configuración `FaceLit/eas.json` contiene un perfil `preview` de distribución interna con salida APK. No se encontró un `.apk` o `.aab` en los repositorios revisados; la observación 13 depende de generar y alojar un artefacto oficial.
- Las notificaciones se persisten en `notification.notification`; hay un `email_log` ligado por FK. No se identificó una política ni tarea programada de purga de 30 días en el código revisado.

## 3. Plan por observación

## Observación 1 — Términos y tratamiento de datos

### Resultado esperado

La persona debe entender qué información trata FaceLit, para qué se usa, quién puede verla, durante cuánto tiempo se conserva y cómo puede ejercer sus derechos. Los términos de uso, el aviso/política de tratamiento y la autorización biométrica se deben poder distinguir.

### Implementación propuesta

1. **Levantar el inventario real antes de redactar.** Documentar datos de cuenta, datos académicos, asistencia, imágenes faciales, embeddings/plantillas, metadatos y registros técnicos. Para cada dato indicar origen, finalidad, sistema que lo recibe, rol que puede consultarlo y ciclo de conservación/eliminación.
2. **Identificar a la entidad responsable.** La institución debe aprobar el nombre legal, datos de contacto, canal de consultas/reclamos y los encargados/proveedores que procesan información.
3. **Separar documentos y decisiones.** Mantener términos de uso, aviso/política general y consentimiento biométrico como elementos distintos. La autorización de datos sensibles no debe esconderse dentro de una aceptación general.
4. **Presentar información por capas.** En la app, mostrar un resumen claro con vínculo al documento íntegro, fecha y versión. Incluir finalidades, datos sensibles, carácter facultativo de biometría, derechos y contacto.
5. **Guardar prueba versionada.** Sustituir o extender el booleano actual por registros que guarden identificador y versión del documento, decisión, fecha/hora, canal, usuario y, para menores, representante y evidencia mínima de verificación.
6. **Aplicar acceso mínimo.** Coordinación e instructores solo deben consultar la información necesaria para su función. No mostrar imágenes o embeddings en pantallas académicas. Confirmar permisos del servidor; la interfaz por sí sola no es control de acceso.
7. **Definir conservación por categoría.** No usar un único plazo para todo. La institución define plazos y criterios para imagen, plantilla facial, asistencia, cuenta, logs y notificaciones; programar borrado o anonimización solo después de aprobarlos.

### Repositorios y archivos a revisar

- **`facelit-docs`:** `14_Anexos/Plan_Terminos_Tratamiento_Datos_y_Consentimientos.md`; anexar inventario de datos, matriz de acceso y borradores aprobados.
- **`FaceLit`:** `shared/i18n/locales/es.ts`, `features/auth/components/PrivacyNoticeModal.tsx`, `app/auth/login.tsx`; separar presentación y decisiones, conservar accesibilidad y enlaces a textos vigentes.
- **`FaceLit-Backend`:** `auth/controller/.../LoginController.java`, `auth/service/.../LoginServiceImpl.java`, DTO y modelo legal. Añadir consulta/registro de aceptación versionada y autorización.
- **`FaceLit-DB`:** migración versionada para documentos/autorizaciones y sus relaciones; conservar historial de decisiones, con restricciones e índices; incluir rollback Liquibase.
- **`micro-facial`:** revisar únicamente después del mapa de datos para determinar datos enviados/recibidos, logs, persistencia de imágenes/embeddings y mecanismo de supresión.

### Criterios de aceptación

- El texto identifica responsable y canal de derechos, finalidades, clases de datos, accesos por rol y plazos aprobados.
- El documento que acepta una persona se puede reconstruir por versión y fecha.
- Una aceptación general no marca automáticamente autorización biométrica.
- No se publican plazos, accesos ni garantías que no correspondan al sistema y a las decisiones institucionales.

### Dependencias

Requiere confirmación institucional y revisión jurídica colombiana antes de publicar. La autorización general puede requerir una base de tratamiento distinta según el contexto; no asumir que todos los tratamientos se resuelven con una única casilla.

## Observación 2 — Informar antes de registrar usuarios

### Resultado esperado

Coordinación puede comunicar cómo funcionará FaceLit antes de crear una cuenta manualmente o confirmar una carga CSV. La comunicación debe preceder al inicio del tratamiento por FaceLit y explicar cómo actuar si el usuario no acepta biometría.

### Implementación propuesta

1. Crear una **vista previa de información para usuarios** con textos aprobados y canal/contacto institucional.
2. Para altas manuales, mostrar esa información antes de guardar la cuenta y registrar que se entregó/comunicó, sin confundirlo con la autorización.
3. Para CSV, separar carga, validación/vista previa y confirmación de importación. La experiencia debe explicar cómo se comunicará a las personas antes de confirmar la importación.
4. Definir con coordinación si FaceLit enviará invitaciones por correo o si el aviso se entrega fuera de la aplicación. Si se automatiza el correo, registrar destinatario, documento/versión, fecha y resultado de entrega; no marcarlo como leído ni aceptado por el simple envío.
5. No habilitar la captura facial como consecuencia automática de importar el CSV. La persona debe tomar su propia decisión antes de la captura.

### Repositorios y archivos a revisar

- **`FaceLit`:** pantallas/hooks de alta de usuarios, carga CSV y asistente de vista previa (`features/academic`, `app/admin` o rutas de coordinación pertinentes); servicio y traducciones.
- **`FaceLit-Backend`:** `academic/service/csv/CsvUserImporter.java`, `CsvLearnerImporter.java`, `CsvInstructorImporter.java`, controlador/servicio de importación y servicios de notificación/correo.
- **`FaceLit-DB` (si se necesita evidencia):** registrar evento de comunicación separado de autorización y aceptación.
- **`facelit-docs`:** guion de comunicación e instructivo para coordinación.

### Criterios de aceptación

- Coordinación puede abrir/copiar o enviar información aprobada antes de confirmar el alta/importación.
- El proceso diferencia “se informó”, “aceptó tratamiento aplicable” y “autorizó biometría”.
- La importación no convierte el silencio, la entrega del correo ni la creación administrativa en autorización biométrica.
- Los errores de envío o las direcciones faltantes se muestran antes de confirmar el proceso, si la institución opta por envío automatizado.

### Dependencias

La institución debe definir canal de comunicación y responsable de usarlo. El envío masivo de correos, plantillas y tratamiento de direcciones requiere revisión operativa y aprobación del contenido.

## Observación 3 — Registro biométrico voluntario

### Resultado esperado

Antes de capturar el rostro, el aprendiz decide de forma explícita si autoriza su uso, por separado del aviso de privacidad general. Si no autoriza o elige decidir después, la cámara no se abre y no se registra su rostro. FaceLit muestra el procedimiento institucional para registrar la asistencia sin biometría; cuando ese procedimiento sea el checklist, solo el instructor lo diligencia.

### Implementación propuesta

1. **Separar la puerta de consentimiento del login.** El aviso de privacidad general no debe incluir una aceptación implícita de biometría como condición de entrada al sistema.
2. **Presentar al aprendiz una pantalla previa a la cámara** que explique qué se captura, si se conserva imagen o solo plantilla, finalidad específica, quién accede, cuánto se conserva y cómo retirar la autorización.
3. Ofrecer opciones claras: **“Autorizar y continuar”** y **“Decidir después”**; también permitir rechazar sin penalizar el acceso a las funciones generales. No precargar la autorización y no tratar cerrar/salir como aceptación. La coordinación puede informar sobre el proceso, pero no decidir por el aprendiz.
4. Guardar quién decidió, qué decidió (autorizó, rechazó o dejó pendiente) y qué versión del aviso vio, junto con la fecha y hora. Antes de abrir la cámara, el backend debe validar una autorización facial vigente. Bloquear también la invocación directa del servicio facial sin autorización verificable.
5. Al revocar autorización, impedir futuros usos faciales y aplicar el procedimiento aprobado para suprimir plantilla e imágenes asociadas; conservar solo la evidencia mínima permitida para acreditar la decisión.
6. Para menores, aplicar el procedimiento institucional de autorización del representante legal, explicar el uso al aprendiz y registrar que se escuchó su opinión considerando madurez y comprensión. No habilitar captura por el solo hecho de que un instructor cree la cuenta.
7. Si el aprendiz no autoriza o deja la decisión pendiente, FaceLit no abre la cámara ni crea un registro facial. La interfaz informa cómo se tomará su asistencia según el procedimiento aprobado por la institución; si corresponde usar checklist, queda disponible para que el instructor registre la asistencia. El aprendiz no diligencia ese checklist.

### Repositorios y archivos a revisar

- **`FaceLit`:** `features/auth/components/PrivacyNoticeModal.tsx`, `app/auth/login.tsx`, `features/auth/hooks/useLoginForm.ts`, `features/facial/components/FacialIdentityConfirmation.tsx`, `features/facial/hooks/useApprenticeFacial.ts`, `shared/services/facialEnrollmentService.ts`, `shared/services/facialEmbeddingService.ts`, `app/instructor/facial` y traducciones.
- **`FaceLit-Backend`:** login/legal controller y servicio; controladores/endpoints de enrolamiento y verificación facial; autorización en servicio, no solo en navegación del cliente.
- **`FaceLit-DB`:** entidad/migración de consentimiento con tipo `FACIAL_BIOMETRIC`, versión, decisión, fecha, titular y representante si aplica.
- **`micro-facial`:** asegurar que la API no permita almacenar/comparar embeddings si la autorización no se validó en backend; revisar si requiere autenticación interna o contrato firmado.
- **`FaceLit-DB`:** revisar la tabla de vectores faciales y estrategia de eliminación/cifrado con la política aprobada.

### Criterios de aceptación

- Si el aprendiz rechaza o pospone la decisión, no se abre la cámara ni se registra el rostro; puede continuar usando las funciones generales autorizadas.
- La interfaz explica el procedimiento institucional de asistencia sin biometría. Si se usa checklist, únicamente el instructor puede registrar allí la asistencia.
- Queda trazabilidad de quién decidió, su decisión, la fecha y hora, y la versión del aviso.
- La cámara y el endpoint de enrolamiento no se activan sin autorización facial vigente.
- El estado de autorización y el estado de “rostro enrolado” son distintos.
- Existe camino de retiro/revocación y la interfaz informa el efecto.
- El recorrido de menor requiere representante y evidencia del ejercicio de escucha.

### Base normativa para revisión

La Ley 1581 clasifica los datos biométricos como sensibles y exige autorización explícita cuando corresponda; su reglamentación exige informar el carácter facultativo y finalidad. La SIC ha ordenado ofrecer mecanismos alternativos que no impliquen biometría y no condicionar el acceso o la actividad. Para menores, la reglamentación exige interés superior, respeto de derechos fundamentales y autorización del representante después de escuchar al menor.

- [Ley 1581 de 2012 — Gestor Normativo](https://www1.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=49981)
- [Decreto 1377 de 2013 — Gestor Normativo](https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=53646)
- [SIC: alternativas al reconocimiento facial y supresión de biometría](https://sedeelectronica.sic.gov.co/comunicado/la-superintendencia-de-industria-y-comercio-ordena-a-un-conjunto-residencial-habilitar-mecanismos-de-ingreso-que-no-impliquen-el-tratamiento)
- [SIC: caso sobre exigir reconocimiento facial para acceso](https://sedeelectronica.sic.gov.co/noticias/214-millones-de-multa-mercado-libre-por-exigir-sus-usuarios-reconocimiento-facial-para-acceder-sus-cuentas)

## Observación 13 — Acceso para descargar la aplicación Android

### Resultado esperado

La aplicación ofrece un enlace visible a una versión oficial de Android, indicando versión y requisitos básicos de instalación.

### Implementación propuesta

1. Confirmar con el equipo si el entregable será APK interno (`eas.json` ya incluye el perfil `preview` con `android.buildType: apk`) o publicación por Play Store. No distribuir un APK de desarrollo como si fuera una versión de producción.
2. Generar el APK desde el perfil aprobado, probar instalación/actualización y comprobar firma/versionado.
3. Alojar el artefacto en una ubicación institucional estable con control de acceso apropiado, versión, fecha y checksum. No meter binarios grandes dentro del repositorio fuente ni usar enlaces personales temporales.
4. Añadir en una pantalla de “Acerca de / Descargar” un botón que abra el enlace oficial y una etiqueta de versión. Si el artefacto no está disponible, mostrar el canal de contacto; no presentar un enlace roto.
5. Establecer quién sube nuevas versiones y cómo se reemplaza el enlace sin tener que publicar una app antigua para actualizarlo.

### Repositorios y archivos a revisar

- **`FaceLit`:** `app.json`, `eas.json`, pantalla de ajustes/acerca de, servicio para abrir enlaces externos y localización.
- **`FaceLit-Backend` (solo si debe publicar URL dinámica):** configuración pública de la versión vigente o endpoint de releases; no es necesario si el link es estable y aprobado en configuración.
- **Infraestructura/repositorio de entregas institucionales:** almacenamiento del APK, release notes y hash. El artefacto no existe actualmente en los repositorios inspeccionados.

### Criterios de aceptación

- El enlace abre un artefacto oficial vigente y el usuario ve claramente la versión.
- Instalación se completa en un Android compatible y la firma corresponde a la distribución del equipo.
- La descarga no expone secretos ni credenciales y no depende de un archivo local del equipo de desarrollo.

## Observación 16 — Aviso de vencimiento y eliminación de notificaciones/asistencias

### Resultado esperado

Mostrar un aviso o advertencia de vencimiento de notificaciones a los tres roles del sistema (coordinador, instructor y aprendiz). Las notificaciones se eliminan después de 30 días según la regla que se apruebe. Los registros de asistencia se eliminan al cumplir seis meses de antigüedad; el alcance de la purga debe definirse por tipo de registro y conservar consistencia entre interfaz, API y base de datos.

### Implementación propuesta

1. Acordar por escrito desde cuándo se cuentan los 30 días para notificaciones (creación, lectura u otra fecha) y el momento del aviso previo. El texto del aviso debe indicar la fecha de vencimiento y explicar qué ocurrirá.
2. Enviar/mostrar el aviso a los tres roles: coordinador, instructor y aprendiz. Definir canales por rol (notificación dentro de FaceLit, correo u otro mecanismo aprobado) y evitar depender de un rol/perfil específico.
3. Mantener la consulta de la interfaz acotada a notificaciones vigentes, incluso si la tarea física de purga aún no ha corrido.
4. Añadir tareas programadas en backend para notificaciones y asistencias, con sus plazos independientes: 30 días y seis meses, respectivamente. Ejecutarlas por lotes, registrar resultado/errores sin guardar contenido personal innecesario en logs y hacerlas idempotentes.
5. Definir exactamente qué significa “registro de asistencia”: eventos faciales/manuales, correcciones, novedades, excusas, reportes o copias de auditoría. Determinar si el plazo de seis meses se cuenta desde la fecha del evento o desde el cierre de la sesión.
6. Resolver las dependencias antes de purgar asistencia: por ejemplo, notificaciones ligadas a eventos, reportes, excusas, cambios y necesidades de auditoría. Borrar o anonimizar solo los datos incluidos en una política aprobada.
7. Resolver el vínculo `notification.email_log.id_notification` antes de borrar: definir si el log también vence, se anonimiza o se conserva separado; no romper la FK ni borrar evidencia que deba mantenerse.
8. Añadir índices por fechas de vencimiento y una política transaccional/por lotes cuando corresponda. La migración debe incluir rollback.
9. Mantener plazos y fecha de aviso configurables/centralizados para que el job, API e interfaz no usen valores distintos.

### Repositorios y archivos a revisar

- **`FaceLit-Backend`:** `notification/service/serviceImpl/NotificationServiceImpl.java`, `notification/repository/NotificationRepository.java`, modelo `Notification`, repositorio/servicios de asistencia, nueva tarea de mantenimiento y configuración de scheduler. El aviso debe dirigirse explícitamente a los tres roles.
- **`FaceLit-DB`:** `01_ddl/03_tables/005_create_notification_tables.sql`, `01_ddl/04_alter/005_create_foreignkeys_notification_tables.sql`, tabla de eventos de asistencia, índices, migración y rollback. La tabla `email_log` tiene FK a notificación.
- **`FaceLit`:** `features/notifications/useNotifications.ts`, `shared/services/notificationService.ts`, caché/estado local y pantalla `app/notifications/index.tsx`; mostrar el aviso sin depender del rol y retirar estado local cuando expire o cuando el servidor lo purgue. Revisar pantallas/reportes de asistencia para manejar los registros vencidos.
- **`micro-facial`:** no debería necesitar cambios para la purga si no almacena eventos de asistencia o notificaciones; confirmar si conserva datos derivados y quién los elimina.

### Criterios de aceptación

- Los tres roles pueden recibir/ver la advertencia previa al vencimiento.
- El aviso informa con precisión la fecha de caducidad y no aparece como si fuera un consentimiento.
- Una notificación de 29 días permanece disponible y una que haya superado el plazo aprobado deja de aparecer.
- Una asistencia anterior al umbral de seis meses permanece y una que alcance el umbral se purga según la política aprobada.
- La purga de asistencia no deja notificaciones/reportes huérfanos ni altera datos fuera del alcance autorizado.
- La purga elimina o trata explícitamente su `email_log` de acuerdo con la política.
- Repetir el job es seguro; errores no causan eliminación parcial incoherente.
- La UI no conserva como activa una notificación que el servidor ya purgó.

### Dependencias

La fecha del aviso, el punto inicial de los 30 días, la definición de datos de asistencia, el inicio del cómputo de seis meses y la política de `email_log` deben aprobarse antes de implementar borrado físico. Coordinar con la observación 15 original y la 17: la retención semestral de asistencia no debe borrar de forma accidental el historial de usuarios inactivos ni incumplir una retención institucional distinta.

## Observación 18 — Confirmar antes de eliminar o desactivar

### Resultado esperado

Antes de confirmar, la persona administradora ve qué acción se ejecutará realmente y qué pasa con acceso, sesiones, asignaciones e historial.

### Implementación propuesta

1. Uniformar el vocabulario. En el estado actual varias rutas hacen **desactivación** de cuenta, no borrado físico; el diálogo debe decir “Desactivar” cuando esa sea la operación.
2. Reemplazar mensajes genéricos por un modal que nombre al usuario y resuma efectos confirmados: acceso bloqueado, sesiones revocadas, relaciones conservadas o cerradas y registros históricos.
3. Diferenciar confirmación de usuario y de instructor. Para instructores, mostrar número de fichas/sesiones futuras afectadas cuando el backend entregue ese resumen.
4. Exigir acción explícita; cancelar no debe llamar al endpoint ni modificar estado.
5. Mantener la autorización y las reglas en el servidor; un modal no debe ser la única protección.

### Estado actual y repositorios/archivos

- **`FaceLit`:** `app/admin/users/index.tsx` ya tiene una confirmación para desactivar un usuario; revisar el texto `users.deactivateConfirm`. El hook `features/academic/hooks/useInstructorManagementScreen.ts` ejecuta la desactivación del instructor; confirmar si la pantalla de gestión muestra una confirmación suficiente. Revisar `shared/i18n/locales/es.ts` y componentes de diálogo compartidos.
- **`FaceLit-Backend`:** `auth/controller/security/UserManagementController.java` y `auth/service/.../UserManagementServiceImpl.java` exponen desactivación; `academic/controller/academic/InstructorController.java` y `InstructorServiceImpl.java` desactivan instructores y revocan sesiones.
- **`FaceLit-DB`:** no requiere cambio si el modal solo explica efectos ya existentes. Sí requerirá cambios si se añade auditoría o cierre de relaciones.

### Criterios de aceptación

- El mensaje coincide con la operación real y no promete un borrado definitivo cuando solo se desactiva.
- Cancelar conserva estado, relaciones e historial.
- Confirmar una vez ejecuta una única llamada y muestra el resultado o el error.
- Para instructor, no se confirma si hay dependencias que requieran una decisión previa.

## Observación 19 — Resolver asignaciones antes de retirar instructores

### Resultado esperado

Antes de desactivar o eliminar un instructor, FaceLit identifica relaciones actuales y futuras, permite resolver las pendientes y conserva la atribución histórica.

### Implementación propuesta

1. Aclarar alcance: en la API actual se observa **desactivación**, no borrado físico del instructor. Diseñar primero un cierre seguro de cuenta; no hacer hard delete de filas históricas.
2. Crear en el backend una consulta de impacto que devuelva asignaciones activas a fichas/programas y sesiones futuras donde el instructor figura como programado o responsable.
3. Usar `instructor_type` para incluir instructores `SPECIFIC` y `CROSS-CUTTING`; verificar las relaciones correspondientes (`instructor_chip`, `instructor_program`) y las referencias de sesiones.
4. Presentar al coordinador opciones: reasignar a otro instructor habilitado, cerrar asignación en fecha acordada o cancelar la baja. No elegir automáticamente un reemplazo.
5. En una transacción, cerrar las relaciones vigentes (`active=false`, fecha fin, auditoría), asignar reemplazos seleccionados y después desactivar credenciales/cuenta y revocar sesiones.
6. Preservar sesiones y asistencias pasadas ligadas al instructor que realmente las atendió. No reescribir atribución histórica como efecto de la baja.
7. Validar la regla también en backend para prevenir llamadas directas que omitan el modal.

### Repositorios y archivos a revisar

- **`FaceLit`:** gestión de instructores, modal de detalle/impacto, hooks y `features/academic/academicApi.ts`.
- **`FaceLit-Backend`:** `academic/controller/academic/InstructorController.java`, `academic/service/serviceImpl/academic/InstructorServiceImpl.java`, `InstructorChipRepository.java`, `InstructorProgramRepository.java`, entidades `InstructorChip`, `InstructorProgram`, servicio de sesiones/ambientes y su relación con instructor programado/a cargo.
- **`FaceLit-DB`:** tablas y FKs en `01_ddl/03_tables/003_create_academic_tables.sql`, `01_ddl/04_alter/003_create_foreignkeys_academic_tables.sql`, tabla de sesiones/ambientes, acciones de auditoría e índices de búsqueda de asignaciones activas. Evitar cascadas que borren historial.
- **`facelit-docs`:** actualizar manual técnico/usuario con el procedimiento de reasignación y desactivación.

### Criterios de aceptación

- El backend devuelve todas las asignaciones relevantes de ambos tipos de instructor y sesiones futuras.
- Una cuenta con dependencias no se desactiva hasta resolverlas o aplicar una política aprobada.
- El cierre de relación conserva fila/historial y registra actor/fecha; la sesión pasada mantiene al instructor original.
- Un reemplazo no recibe sesiones sin autorización/confirmación del coordinador.
- Una operación simultánea o repetida no deja relaciones huérfanas ni sesiones duplicadas.

### Dependencias

Coordinar este flujo con la observación 18: el modal debe mostrar el resumen de impacto calculado por backend. Acordar qué se entiende por “pendiente”, “futuro” y “asignación transversal”.

## 4. Orden sugerido de trabajo

1. **Aprobaciones y diseño:** cerrar el inventario/avisos (1), comunicación previa (2), elección biométrica y alternativa (3), y reglas de desactivación/retención (16, 18, 19).
2. **Cambios de interfaz rápidos:** actualizar confirmaciones (18), añadir aviso de vencimiento accesible a los tres roles (16) y preparar pantalla/enlace de descarga (13), condicionado a tener APK oficial.
3. **Cambios de servidor y datos:** aceptación versionada y gate biométrico (1, 3), flujo de importación/notificación (2), purga (16) y cierre de relaciones (19).
4. **Integración:** verificar desde el recorrido real que los registros, permisos, notificaciones, historial y textos coinciden entre los cuatro repositorios.

## 5. Casos de revisión del equipo

- ¿Quién es oficialmente responsable del tratamiento y cuál es el canal institucional para derechos?
- ¿Qué plazo se aplicará a cada tipo de dato? ¿Qué ocurre si se retira una autorización biométrica?
- ¿Qué alternativa manual concreta se ofrecerá a quien rechace biometría?
- ¿El aviso antes del CSV se envía automáticamente o se entrega por coordinación fuera de FaceLit?
- ¿Qué APK es el oficial y dónde estará publicado para que el enlace no caduque?
- ¿Los 30 días de notificaciones corren desde creación o lectura? ¿Qué política aplica al log de correo?
- ¿Qué sesiones futuras y asignaciones cuentan como pendientes para desactivar un instructor transversal?
- ¿El alcance de cuatro días significa prototipo demostrable, código integrado o flujo listo para producción? No asumir que son equivalentes.

## 6. Fuentes de referencia

- [Ley 1581 de 2012 — Gestor Normativo de Función Pública](https://www1.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=49981)
- [Decreto 1377 de 2013 — Gestor Normativo de Función Pública](https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=53646)
- [SIC: mecanismos alternativos al reconocimiento facial](https://sedeelectronica.sic.gov.co/comunicado/la-superintendencia-de-industria-y-comercio-ordena-a-un-conjunto-residencial-habilitar-mecanismos-de-ingreso-que-no-impliquen-el-tratamiento)
- [Validación técnica SRS del proyecto](../../VALIDACION_SRS.md)

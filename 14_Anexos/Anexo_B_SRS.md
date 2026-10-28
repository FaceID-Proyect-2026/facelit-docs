# Anexo B — Backlog de conformidad

**FaceLit | Documentación del proyecto | Corte 27 oct 2026**
Pendientes actuales, criterios de cierre y evidencia requerida | Corte 27 de octubre de 2026

Este backlog conserva los identificadores RF/RNF del SRS y separa trabajo de implementación, decisión de alcance y validación. Las funciones presentes en código no se consideran aceptadas hasta reunir evidencia del flujo integrado.

## Prioridad P0 — seguridad, privacidad y acceso

| IDs | Pendiente actual | Evidencia de cierre |
|---|---|---|
| RF 1.2-1.3; RNF 1.4, 1.16 | Alínear guards de interfaz con permisos del backend y alcance por rol/propiedad. | Casos negativos: aprendiz consulta solo su asistencia; instructor solo fichas asignadas; coordinador operaciones permitidas. Registrar respuestas API y pantalla. |
| RF 3.4; RNF 3.3 | Revisar exposicion de credenciales temporales y los mecanismos de alta/CSV. | Inspeccion UI, API y exportaciones; verificar que no se devuelve ni comparte contraseña en claro fuera del flujo temporal aprobado. |
| RNF 5.4; RF 5.4 | Documentar ciclo de datos biométricos, cifrado, retención y respuestas API. | Revisar DB, microservicio, TLS, logs y borrado. Aprobacion de responsable de datos; no compartir capturas biométricas. |
| RNF 1.10-1.11; RNF 4.2-4.4 | Revalidar identificador de login, correo expuesto, expiración/invalidez de token y logout. | Pruebas de autenticación, perfil, cierre de sesión y solicitudes posteriores; registrar configuración efectiva. |

## Prioridad P1 — aceptación integrada de facial y asistencia

| IDs | Situacion al corte | Trabajo de cierre |
|---|---|---|
| RF 5.1-5.2; RF 6.1-6.2 | Los flujos de enrolamiento, autorización de reemplazo, sesión y captura estan integrados en código. | Prueba con cuentas ficticias: dos retos distintos, enrolamiento, solicitud/resolucion, autorización de un solo uso, sesión activa, asistencia guardada, errores y cierre. Registrar SHAs de todos los componentes. |
| RF 7.1-7.3; RF 9.1 | Eventos y consultas de asistencia estan disponibles en el código actual; los criterios de todos los reportes/exportaciones no estan aceptados. | Cotejar DB/API/UI por ficha y aprendiz; validar entrada/salida, estados, calculos, filtros, correcciones y exportaciones. Verificar permisos. |
| RF 5.3; RNF 5.2, 5.5 | Umbral y calidad de captura necesitan evidencia de configuración y calibracion. | Aprobar rango/valor, probar fronteras, falsos positivos/negativos y documentar equipo, iluminacion y datos de ensayo. |

## P2 — completar modulos y contratos

| IDs | Trabajo pendiente | Cierre verificable |
|---|---|---|
| RF 2.1 / RF 2.1.1 | CSV: transacciones, validaciones, duplicados, filas mixtas, feedback y seguridad del archivo. | Pruebas de carga, errores parciales, rollback, tipos de filas y revisión por el Coordinador. No persistir archivos cargados sin necesidad. |
| RF 2.3 | Unificar el traslado académico disponible en backend con el flujo soportado de interfaz; algunas rutas antiguas del aprendiz redirigen. | Definir un flujo vigente, validar ficha origen/destino, historial, autorización y notificación. Retirar instrucciones para rutas no activas. |
| RF-C2 | Verificar que cada accion de ambientes visible tenga contrato API; no todas las operaciones CRUD del catalogo estan demostradas. | Matriz pantalla-accion-endpoint, pruebas de alta/consulta/edicion y errores. |
| RF-C3 / RF-C4 | Validar persistencia de preferencias y contrato de eventos WebSocket. | Pruebas tras reinicio y cambio de navegador; autenticar WS, probar eventos, autorización y reconexión. |
| RF 8.1-8.4; RNF 8.1-8.4 | Validar categorias, bandeja, email, límites, reintentos y deduplicacion. | Pruebas SMTP/WebSocket y scheduler con tiempos medidos; conservar IDs y evidencias sin secretos. |

## P3 — requisitos operaciónales

| IDs | Accion |
|---|---|
| RNF 1.12-1.14, 2.5, 2.12-2.14 | Aprobar protocolo de rendimiento, capacidad, usabilidad, interrupcion/recuperacion y compatibilidad. Guardar entorno, datos, métricas y criterios de aceptación. |
| RNF 1.6-1.8, 3.4-3.7 | Documentar seguridad de despliegue, secretos, cifrado, auditoria y evidencia operaciónal. |
| RNF 5.7 | Decidir formalmente si Raspberry/offline se excluye del alcance de entrega o se planifica como versión futura; no marcar implementado. |
| RF-C1 / horarios | Mantener fuera del alcance vigente. Si se reintroduce, aprobar requisitos, API, permisos y persistencia antes de anunciarlo. |

## Regla de cierre

Cada fila pasa a **Conforme** solo cuando exista criterio aprobado, prueba en versión identificada, resultado verificable y revisión del responsable. Las ejecuciones unitarias, la existencia de rutas o un HTTP 200 aislado no sustituyen la aceptación completa. No se ejecutaron pruebas para preparar este anexo.

Criterios originales detallados: consultar el SRS V3 fuente; los IDs permanecen para trazabilidad. Este backlog actualiza el orden y la evidencia pendiente frente a los cuatro repositorios inspeccionados.

---
---

# ANEXO HISTORICO — BACKLOG ANTERIOR

> Estas paginas reproducen, sin modificacion, el backlog recibido. Sus observaciones y priorizacion pertenecen a un corte anterior; las paginas iniciales de este PDF actualizan los pendientes conocidos al 27 de octubre de 2026. Conserva esta parte como trazabilidad de los criterios y estados previamente documentados.
>
> Fin de la actualizacion; comienza la copia historica sin cambios.

**FACELIT | SRS V3 | Anexo B**

## Anexo B. Requisitos pendientes para completar la conformidad

**Propósito.** Este anexo reúne de forma accionable los requisitos que no están demostrados como plenamente conformes en el código revisado. Conserva los identificadores originales RF/RNF para mantener trazabilidad. Los criterios de aceptación se toman de las fichas del SRS; "siguiente paso" indica el trabajo requerido para decidir, implementar o validar cada punto. Ningún elemento de este backlog se declara disponible en el sistema actual.

### Resumen del backlog

Desarrollo/decisión de alcance: 24 requisitos (brecha observable o sin componente encontrado). Cierre de implementación parcial: 34 requisitos. Validación pendiente: 35 requisitos. Total trazado: 93 de 93.

Orden recomendado: primero resolver privacidad y seguridad; después acordar alcance e integración facial/asistencia; por último ejecutar pruebas operativas, rendimiento, disponibilidad y usabilidad.

> **Leyenda de textos repetidos** (se abrevian con claves en las tablas):
> **[P]** Acción: Precisar qué parte pertenece al baseline actual y qué parte queda pendiente; verificar el límite en el flujo real.
> **[D]** Acción: Decidir si se retira del baseline actual o se conserva como requisito futuro; no declarar disponible sin cambio aprobado y nueva verificación.
> **[V]** Acción: Inspeccionar configuración/endpoint aplicable y documentar evidencia o registrar la brecha concreta.
> **[T]** Acción: Definir caso, datos, entorno y umbral de aceptación; adjuntar resultado de ejecución antes de marcar conforme.
> **[E]** Acción: Confirmar si el componente falta del alcance entregado; excluirlo del baseline o enlazar el repositorio/evidencia que falta.
> **[N]** Criterio de aceptación no especificado en la ficha; definirlo y aprobarlo antes de cerrar el requisito.
> **[G]** Definir caso de aceptación y reunir evidencia de ejecución; no se concluye conformidad por inspección estática.

---

### B.1 Requieren decisión de alcance o desarrollo (24 requisitos)

| ID / requisito | Estado | Brecha observada / siguiente paso | Criterio de cierre del SRS |
|---|---|---|---|
| RF 3.4 — | Brecha | Frontend muestra/exporta la contraseña inicial en claro, contrario a criterios de privacidad. [D] | [N] |
| RF 5.1 — | Brecha | Cliente envía una imagen al servicio de embeddings; backend define reto/múltiples muestras. No se evidencia integración. [D] | [N] |
| RF 5.3 — | Brecha | Backend usa umbral fijo 0.45; SRS pide configurable y default 0.6. [D] | No permitir valores fuera de rango; dejar claro desde cuándo aplican; el cálculo RF-7 usa la versión vigente para la fecha del evento. |
| RF 7.1 — | Brecha | UI usa registros locales/demostrativos; no se encontró persistencia backend de asistencia por ficha. [D] | 1. Las tarjetas de ficha (Pantalla 1) muestran únicamente porcentaje de inasistencia y de retardo del día — esto no cambia.<br>2. En la tabla de detalle (Pantalla 2), toda celda tiene un color según su estado: rojo (inasistencia), amarillo (retraso), o verde (asistencia puntual).<br>3. Toda celda, sin importar su color, puede mostrar hora, día, ambiente e instructor al consultarla.<br>4. Todo archivo exportado identifica claramente el programa y la ficha de origen, e incluye las 3 categorías (asistencias, retrasos e inasistencias), no solo las fallas. |
| RF 7.2 — | Brecha | Consulta individual usa datos locales; falta API/backend de asistencia persistida. [D] | 1. La búsqueda funciona tanto por nombre como por número de documento.<br>2. El comportamiento de colores y detalle es idéntico al de RF-6.1, solo que a nivel de un único aprendiz. |
| RF 7.3 — | Brecha | Vista historial existe, con fuente local, no historial real persistido. [D] | 1. Las 3 formas de búsqueda (fecha, nombre, documento) funcionan de forma independiente y también combinadas.<br>2. Las tarjetas quedan agrupadas por ficha, no mezcladas sin orden.<br>3. El alcance de qué se puede ver sigue la misma regla de rol que el resto del módulo. |
| RF 8.4 — | Brecha | Resolución de solicitud no dispara re-enrolamiento. [D] | 1. El Coordinador resuelve todo desde la notificación misma.<br>2. La decisión queda registrada (quién, cuándo, qué decidió). |
| RNF 1.10 — | Brecha | Login admite correo y perfil expone correo completo. [D] | El sistema debe rechazar el intento de autenticación cuando el usuario intente utilizar el correo electrónico como identificador de acceso. |
| RNF 1.11 — | Brecha | Token de ocho horas; logout no invalida sesión en backend. [D] | Un usuario no debe poder modificar los datos de su sesión para obtener permisos correspondientes a otro rol. |
| RNF 1.16 — | Brecha | Permisos UI/API desalineados. [D] | Después de modificar el rol de un usuario, el sistema debe aplicar únicamente los permisos correspondientes al nuevo rol. |
| RNF 3.3 — | Brecha | Backend almacena hash, pero frontend muestra/exporta contraseña inicial en claro. [D] | • La contraseña nunca se almacena ni transmite en texto plano.<br>• La contraseña cumple mínimo 8 caracteres alfanuméricos.<br>• Ningún endpoint del sistema devuelve la contraseña en texto legible. |
| RNF 4.2 — | Brecha | `app/profile/index.tsx` muestra correo sin enmascarar. [D] | • El correo completo nunca es visible en ninguna pantalla de la app.<br>• El enmascaramiento es consistente en todas las vistas.<br>• El correo completo solo se usa internamente para envío de correos. |
| RNF 4.3 — | Brecha | Logout elimina token local; servidor no invalida sesión. [D] | • El cierre de sesión se completa en menos de 1 segundo.<br>• El botón "atrás" del dispositivo no permite regresar a pantallas autenticadas.<br>• El token invalidado es rechazado en cualquier solicitud posterior.<br>• Los datos locales sensibles son eliminados del dispositivo. |
| RNF 4.4 — | Brecha | No se encontró timeout tras 30 minutos de inactividad. [D] | • El cierre automático se ejecuta exactamente a los 30 minutos de inactividad.<br>• Cualquier interacción del usuario reinicia el contador de inactividad.<br>• El mensaje de sesión expirada se muestra al usuario antes de redirigirlo. |
| RNF 5.3 — | Brecha | Requisito pide tres capturas; backend requiere siete muestras y cliente envía una. [D] | • El sistema no completa el registro con menos de 3 capturas.<br>• El sistema detecta y rechaza capturas con ángulos demasiado similares.<br>• El proceso completo de registro toma menos de 60 segundos en condiciones normales. |
| RNF 5.4 — | Brecha | Backend persiste vector y foto JPEG; no se evidencia cifrado del vector ni descarte de imagen original. [D] | • Ninguna imagen original del rostro se almacena en el servidor ni en el dispositivo.<br>• Los descriptores están encriptados en reposo y en tránsito.<br>• El proceso de encriptación se completa antes de cualquier transmisión de datos. |
| RNF 5.5 — | Brecha | Umbral fijo 0.45, no configurable. [D] | • El umbral acepta valores entre 0.4 y 0.9 únicamente.<br>• El cambio se aplica inmediatamente a las identificaciones posteriores.<br>• Valores fuera del rango son rechazados con mensaje de error. |
| RNF 5.7 — | Sin evidencia | No se halló sincronización offline cifrada/Raspberry. [E] | • Los datos locales están encriptados durante el almacenamiento temporal.<br>• La sincronización se ejecuta automáticamente sin intervención manual.<br>• La cola local no supera 24 horas de registros acumulados sin alerta al Coordinador.<br>• Los datos locales se eliminan tras confirmación de sincronización exitosa. |
| RNF 6.1 — | Brecha | No hay asistencia persistida conectada; cliente usa fuente local temporal. [D] | • El registro se crea en menos de 2 segundos tras la identificación.<br>• No puede existir más de un registro de entrada para el mismo usuario en la misma sesión.<br>• El registro incluye todos los campos requeridos sin excepción. |
| RNF 6.2 — | Brecha | No se halló clasificación de asistencia real por horario. [D] | • La clasificación se ejecuta en menos de 500 ms por registro.<br>• El margen de tolerancia es configurable entre 0 y 30 minutos.<br>• Los estados son consistentes con los datos mostrados en los reportes.<br>• Las excepciones de horario activas son consideradas en el cálculo. |
| RNF 6.3 — | Brecha | No se encontró servicio persistente con inmutabilidad/anulación auditada. [D] | • La API rechaza modificaciones de asistencia de roles no autorizados con error 403.<br>• Toda anulación por el Coordinador requiere campo de justificación obligatorio.<br>• Las anulaciones quedan registradas en auditoría con la justificación provista. |
| RNF 6.4 — | Brecha | No se identificó cálculo mensual de retrasos/alerta. [D] | • La alerta se genera en menos de 5 segundos tras el registro que supera el umbral.<br>• El umbral de retrasos graves es configurable por el Coordinador.<br>• La alerta se envía al instructor correcto según la ficha del aprendiz.<br>• No se generan alertas duplicadas para el mismo evento. |
| RNF 8.3 — | Brecha | No se encontró límite de cinco correos por usuario/hora. [D] | • El sistema no supera 5 correos por hora por usuario bajo ninguna circunstancia.<br>• Los correos descartados por límite quedan en cola y se envían en la siguiente ventana.<br>• Ningún correo contiene datos biométricos ni contraseñas.<br>• El estado de cada envío (exitoso/fallido/en cola) queda registrado en auditoría. |
| RNF 8.4 — | Brecha | Dispatcher hasta tres reintentos cada cinco minutos; SRS solicita push con backoff 1/2/4 segundos. [D] | • No se generan notificaciones duplicadas por los reintentos.<br>• Tras 3 fallos de entrega push la notificación sigue disponible en la bandeja.<br>• El backoff exponencial entre reintentos es respetado. |

---

### B.2 Requieren cerrar una implementación parcial (34 requisitos)

| ID / requisito | Estado | Brecha observada / siguiente paso | Criterio de cierre del SRS |
|---|---|---|---|
| RF 1.1 — | Parcial | LoginServiceImpl admite búsqueda por documento y correo; el criterio exige documento. [P] | • El identificador de acceso es el documento, no el correo, para los 3 roles.<br>• No se puede iniciar sesión utilizando el correo electrónico como identificador.<br>• No se repite el aviso de privacidad si ya existe una aceptación registrada.<br>• Las contraseñas cumplen la política definida de seguridad.<br>• Las contraseñas nunca se almacenan en texto plano.<br>• El sistema registra los intentos de acceso exitosos y fallidos. |
| RF 1.2 — | Parcial | SecurityConfig protege API por rol; layouts del frontend usan useAuthGuard sin validar rol. [P] | • El sistema aplica permisos según el rol del usuario.<br>• Un Aprendiz no puede consultar las asistencias de otro Aprendiz.<br>• Un Instructor no puede consultar las asistencias de fichas que no tenga asignadas.<br>• Un Aprendiz no puede modificar directamente sus datos personales.<br>• Un Instructor no puede modificar directamente sus datos personales.<br>• El Coordinador puede actualizar los datos personales de los usuarios.<br>• El sistema registra las modificaciones realizadas por el Coordinador.<br>• Los usuarios no pueden acceder a funcionalidades que no correspondan a su rol.<br>• El acceso a la información debe validarse tanto en la interfaz como en el servidor. |
| RF 1.3 — | Parcial | Backend asigna rol/permisos; falta validar matriz de acceso completa. [P] | • Los roles no pueden ser definidos ni modificados por el usuario durante el login.<br>• Solo el Coordinador puede asignar o modificar roles.<br>• El sistema determina automáticamente el rol después de autenticar al usuario.<br>• El acceso a funcionalidades está restringido según la matriz de permisos.<br>• Un Instructor solo puede acceder a las fichas que tenga asignadas.<br>• Un Aprendiz solo puede consultar sus propias asistencias.<br>• Las restricciones de permisos se validan en el backend. |
| RF 1.4 — | Parcial | Código de seis dígitos, expira en cinco minutos y se marca usado; falta prueba funcional. [P] | • El token es de un solo uso.<br>• El token tiene un vencimiento corto de máximo 5 minutos.<br>• El correo electrónico se utiliza únicamente para recuperación de contraseña.<br>• La nueva contraseña debe cumplir la política de seguridad definida.<br>• Nunca se revela la contraseña anterior.<br>• Los tokens utilizados o vencidos no pueden volver a utilizarse.<br>• El proceso de recuperación queda registrado para auditoría. |
| RF 2.1 — | Parcial | Existe carga CSV UI/API; atomicidad y límites requieren pruebas. [P] | 1. Un archivo que solo trae un tipo de fila (por ejemplo, solo instructores nuevos) actualiza únicamente esa información, sin tocar el resto de programas, fichas o aprendices ya existentes.<br>2. Un instructor específico puede quedar asociado a uno o varios programas (mediante varias filas con el mismo documento); uno transversal nunca queda restringido a ningún programa en particular.<br>3. Toda fila aprendiz o instructor sin correo se rechaza.<br>4. El resumen final siempre indica las 4 categorías (creadas, actualizadas, inconsistencias bloqueadas, errores), nunca un solo número general.<br>5. Cada inconsistencia bloqueada tiene un botón que lleva directo al registro exacto en conflicto para resolverlo manualmente.<br>6. Toda cuenta de aprendiz o instructor creada por primera vez mediante el CSV queda con una contraseña generada automáticamente, vinculada a su documento, lista para su primer inicio de sesión — nunca queda una cuenta nueva sin contraseña asignada. |
| RF 2.1.1 — | Parcial | Existe plantilla/guía; cotejar columnas y validaciones de extremo a extremo. [P] | 1. La tabla de ayuda de columnas siempre es visible antes de subir el archivo, no solo en un mensaje de error posterior.<br>2. La plantilla descargable siempre tiene al menos un ejemplo de cada uno de los 4 tipos de fila.<br>3. Los mensajes de error del proceso de carga (RF-3.1) usan el mismo lenguaje simple que esta guía, nunca términos técnicos como "constraint" o "foreign key". |
| RF 2.3 — | Parcial | Endpoint de traslado de Coordinador existe; UI también contiene flujo de código/solicitud del aprendiz, requiere unificación. [P] | 1. El traslado se ejecuta completo desde Gestión académica, sin ningún código ni acción requerida del aprendiz.<br>2. El listado de fichas destino nunca incluye la ficha en la que el aprendiz ya está.<br>3. El cambio de ficha anterior a inactiva es automático e inmediato, parte de la misma operación que activa la nueva.<br>4. Toda ejecución de este traslado genera notificación al Coordinador. |
| RF 3.1 — | Parcial | Hay panel/listado; validar filtros, paginación y alcance. [P] | [N] |
| RF 3.2 — | Parcial | Hay consultas y gestión; probar estados y permisos. [P] | [N] |
| RF 3.3 — | Parcial | Hay alta de usuario; la UI recibe y presenta credenciales iniciales. [P] | [N] |
| RF 3.5 — | Parcial | API restringe roles; guards de rutas UI no están alineados. [P] | [N] |
| RF 3.6 — | Parcial | Existe gestión de estado; probar bloqueo, preservación de historial y auditoría. [P] | [N] |
| RF 4.1 — | Parcial | Existe perfil propio; muestra correo completo, contrario a RNF 4.2. [P] | Cada rol ve solo sus datos; campos vacíos tienen estado claro; no mostrar contraseña, token ni vector facial; carga/error tienen estados definidos. |
| RF 5.2 — | Parcial | Hay pantallas/endpoints de sesión sin flujo facial completo conectado. [P] | No guardar campos obligatorios vacíos; permitir sustitución solo con permiso; guardar original y reemplazante; validación contra horario/excepción. |
| RF 6.1 — | Parcial | Hay configuración visual pero no está conectada a asistencia real. [P] | • El campo Instructor debe permitir seleccionar tanto al instructor autenticado como a cualquier otro instructor registrado.<br>• Si el instructor seleccionado difiere del autenticado, el sistema debe almacenar ambos (original y reemplazo).<br>• No debe permitirse guardar la configuración si falta alguno de los tres campos. |
| RF 6.2 — | Parcial | Ajustes locales/UI; persistencia durable no evidenciada. [P] | • El sistema debe clasificar automáticamente a los aprendices como puntual o retardo según el tiempo de registro y la hora de salida configurados.<br>• Entre la hora de salida y la hora de apagado, el sistema debe solicitar un nuevo registro facial como evidencia de salida.<br>• No debe permitir guardar ajustes con horas incoherentes (apagado ≤ salida, o salida ≤ fin del tiempo de registro). |
| RF 8.1 — | Parcial | Backend crea algunas notificaciones; falta comprobar catálogo completo. [P] | 1. Todas y cada una de las 15 notificaciones del catálogo se generan automáticamente en el momento del evento correspondiente, sin que el Coordinador tenga que pedirlas.<br>2. Ningún evento válido del catálogo se pierde, incluso si hay una falla temporal (se reintenta).<br>3. Cada notificación queda con fecha, hora y estado (leída/no leída). |
| RF 8.2 — | Parcial | Hay listado/marcado; validar sincronización, retención y alcance por rol. [P] | 1. Las notificaciones se muestran siempre ordenadas por fecha, más recientes primero.<br>2. Existen los filtros de estado (Todas/No leídas/Leídas) y de categoría.<br>3. Marcar como leída es inmediato, sin recargar toda la pantalla.<br>4. El Coordinador nunca ve notificaciones que pertenecen a otro rol o a otro usuario específico (ej. no ve el buzón personal de un Instructor, solo los eventos que el catálogo define como visibles para él). |
| RF 8.3 — | Parcial | Hay envío/reintentos; no se evidencia límite de cinco correos por hora. [P] | 1. Solo las notificaciones marcadas "App + Correo" en el catálogo generan envío de correo — ninguna otra.<br>2. El correo se envía en menos de 5 segundos bajo condiciones normales.<br>3. El correo nunca incluye datos sensibles innecesarios (ej. no incluye contraseñas ni el detalle biométrico, solo la descripción del evento).<br>4. Toda falla de envío queda registrada en bitácora, sin que eso afecte a que la notificación siga disponible dentro de la app. |
| RF 9.1 — | Parcial | Pantallas/exportaciones existen; reportes de asistencia usan datos locales. [P] | Definir fórmulas/denominadores, períodos, filtros, columnas, exportación y tiempos; no mostrar aprendices ajenos al rol. |
| RNF 1.1 — | Parcial | BCrypt/JWT presentes; transporte/despliegue requiere revisión. [P] | Las credenciales del usuario deben transmitirse y almacenarse de forma segura, sin exponer la contraseña original. |
| RNF 1.3 — | Parcial | Hay bloqueo temporal; probar límite y duración. [P] | Los intentos repetitivos de autenticación fallida deben ser detectados y controlados por el sistema. |
| RNF 1.4 — | Parcial | RBAC en API; guards UI no validan rol. [P] | Un usuario no debe poder ejecutar mediante solicitudes directas al backend una operación que no esté autorizada para su rol. |
| RNF 1.5 — Restricción de información por rol | Parcial | SecurityConfig aplica autorización por rol en API; los layouts de frontend usan guard de autenticación y no validan el rol. Las restricciones específicas de fichas/asistencia requieren pruebas. [P] | El sistema debe impedir que un usuario acceda a información perteneciente a otro usuario, ficha o rol fuera de su ámbito autorizado. |
| RNF 1.9 — | Parcial | Código de recuperación con vencimiento/uso único visible; probar escenarios negativos. [P] | Un código utilizado o vencido no debe permitir nuevamente el restablecimiento de la contraseña. |
| RNF 3.7 — | Parcial | Hay exportación; verificar filtros y exclusión de credenciales. [P] | • El archivo contiene exactamente los registros del listado filtrado, sin omisiones ni extras.<br>• El archivo se genera en menos de 5 segundos.<br>• Los datos exportados no incluyen contraseñas ni descriptores biométricos. |
| RNF 5.1 — | Parcial | Validación visual difiere en web/nativo; probar los escenarios. [P] | • La detección de rostros se ejecuta en tiempo real sin superar 500 ms por frame.<br>• El sistema bloquea la captura si detecta 0 o 2+ rostros.<br>• El mensaje de error indica claramente la causa. |
| RNF 5.2 — | Parcial | Validación de calidad no está acreditada en todos los dispositivos. [P] | • Las capturas con score de calidad menor al umbral son rechazadas automáticamente.<br>• El umbral de calidad es configurable.<br>• El mensaje de error indica la causa específica del rechazo. |
| RNF 6.5 — | Parcial | Hay UI manual local; falta evidencia de persistencia/auditoría. [P] | • Los registros manuales son visualmente distinguibles de los automáticos en todos los reportes.<br>• El Coordinador recibe notificación de registros manuales pendientes de validación.<br>• Los registros manuales incluyen el ID del instructor que los creó. |
| RNF 7.1 — | Parcial | Vistas por rol existen; datos locales y autorización API no demostrada. [P] | • Un Aprendiz nunca puede consultar registros de otro usuario.<br>• Un Instructor solo accede a reportes de aprendices en sus fichas asignadas.<br>• El Coordinador accede a reportes de cualquier usuario.<br>• La API rechaza solicitudes no autorizadas con error 403. |
| RNF 7.3 — | Parcial | Hay exportación XLSX; verificar igualdad con filtros visibles. [P] | • El archivo contiene exactamente los registros del reporte filtrado.<br>• El archivo se genera en menos de 5 segundos.<br>• El archivo no contiene datos de otros usuarios no incluidos en el reporte visible. |
| RNF 7.5 — | Parcial | Calendario visible; eventos locales/demostrativos. [P] | • El calendario del mes actual carga en menos de 2 segundos.<br>• La navegación entre meses no recarga la pantalla completa.<br>• Los estados se distinguen por color e icono simultáneamente para accesibilidad.<br>• El detalle del día seleccionado incluye hora, estado, ambiente e instructor. |
| RNF 8.1 — | Parcial | Se generan algunos eventos; validar catálogo entero. [P] | • Las notificaciones se generan en menos de 3 segundos tras el evento.<br>• El sistema nunca pierde una notificación generada aunque falle la entrega push.<br>• No se generan notificaciones duplicadas para el mismo evento.<br>• Cada notificación contiene información suficiente para entender el evento sin navegar a otra pantalla. |
| RNF 8.2 — | Parcial | Persistencia/listado presentes; verificar retención 30 días y sincronización. [P] | • El centro de notificaciones carga en menos de 1.5 segundos.<br>• En modo offline muestra al menos las últimas 50 notificaciones en caché.<br>• Las notificaciones de más de 30 días se eliminan automáticamente.<br>• El badge de no leídas se actualiza en tiempo real. |

---

### B.3 Requieren verificación técnica u operacional (35 requisitos)

| ID / requisito | Estado | Brecha observada / siguiente paso | Criterio de cierre del SRS |
|---|---|---|---|
| RF-2.2 — | Por verificar | [G] [V] | 1. Ninguna de las 4 entidades se elimina permanentemente mientras esté activa.<br>2. Ninguna se elimina permanentemente si tiene relaciones activas dependientes, y el sistema siempre indica cuál relación específica lo impide.<br>3. Toda creación y modificación queda con fecha y hora exactas. |
| RF-4.2 — | Por verificar | [G] [V] | Cambio inmediato de vista; estados de guardado/error; idioma admitido indicado; persistencia tras cerrar y volver a abrir la app. |
| RF-5.4 — | Por verificar | [G] [V] | No aprobar dos veces; no habilitar cámara antes de aceptación; notificar la decisión; rechazo no impone espera salvo política explícita. |
| RNF 1.2 — Política de contraseñas | Por verificar | El código revisado no acredita de forma concluyente la regla de 8–15 caracteres con letra, número y símbolo en todos los flujos. La persistencia de contraseñas se realiza con hash; verificar política en alta y recuperación. [V] | El sistema debe rechazar cualquier contraseña que no cumpla con las reglas establecidas. |
| RNF 1.6 — | Por verificar | Cifrado en reposo/secretos dependen de infraestructura. [V] | Un usuario sin permisos suficientes no debe poder consultar ni modificar datos personales de otros usuarios. |
| RNF 1.7 — | Por verificar | [G] [V] | Una solicitud realizada por un Aprendiz o Instructor para modificar directamente sus datos debe ser rechazada por el backend. |
| RNF 1.8 — | Por verificar | No se acreditó auditoría completa de operaciones. [V] | Las operaciones críticas del módulo deben poder ser rastreadas posteriormente mediante los registros de auditoría. |
| RNF 1.12 — | Por probar | No hay medición de rendimiento de acceso. [T] | Al menos el 95 % de los intentos de inicio de sesión realizados bajo condiciones normales deberían recibir una respuesta en un máximo de 3 segundos. |
| RNF 1.13 — | Por probar | Disponibilidad requiere evidencia del entorno operativo. [T] | Una falla del servidor de autenticación no debe permitir el acceso no autorizado al sistema. |
| RNF 1.14 — | Por probar | Usabilidad requiere validación con usuarios. [T] | Un usuario debe poder identificar fácilmente cómo ingresar al sistema y cómo recuperar su contraseña. |
| RNF 1.15 — | Por verificar | [G] [V] | La autenticación exitosa de un usuario no debe otorgarle automáticamente permisos administrativos. |
| RNF 2.1 — | Por verificar | [G] [V] | Una solicitud directa al backend desde una cuenta que no sea Coordinador para cualquiera de estas operaciones debe ser rechazada con un código de error de autorización, no procesada parcialmente. |
| RNF 2.2 — | Por verificar | [G] [V] | No debe ser posible, por ningún camino (CSV o manual), dejar guardada una Ficha sin Programa, o un Aprendiz sin Ficha, o un Instructor específico sin Programa. |
| RNF 2.3 — | Por verificar | No se acreditó trazabilidad integral de operaciones. [V] | Para cualquier dato de Programa, Ficha, Aprendiz o Instructor, debe poder reconstruirse su historial completo de cambios sin ambigüedad. |
| RNF 2.4 — | Por verificar | [G] [V] | Ningún archivo CSV cargado queda accesible o descargable después de haberse procesado. |
| RNF 2.5 — | Por probar | Medir requisito de carga de CSV con volumen indicado. [T] | El Coordinador siempre tiene una señal visual de que el archivo se está procesando mientras dura la carga. |
| RNF 2.6 — | Por verificar | [G] [V] | Antes de aprobar este RNF, definir el horario operativo y la meta de disponibilidad (porcentaje y periodo de medición). Después, verificar consultas de Programas, Fichas, Aprendices e Instructores durante el periodo acordado y registrar indisponibilidades. Meta cuantitativa: pendiente de aprobación; no asumir un porcentaje no acordado. |
| RNF 2.7 — | Por verificar | [G] [V] | Un Coordinador sin conocimientos técnicos debe poder entender y corregir cualquier error mostrado, sin necesidad de soporte técnico, en la mayoría de los casos. |
| RNF 2.8 — | Por verificar | [G] [V] | Para una misma entidad y datos equivalentes, ejecutar alta/actualización por CSV y formulario manual; los valores y relaciones persistidos deben coincidir. Registrar el resultado de ambas rutas, incluyendo reglas de validación y errores. |
| RNF 2.9 — | Por verificar | [G] [V] | Un intento de crear un duplicado, por cualquier vía, siempre se resuelve como actualización del registro existente (si los datos son consistentes) o como error/inconsistencia bloqueada (si no lo son) — nunca se crean dos registros distintos con el mismo identificador. |
| RNF 2.10 — | Por probar | Existe traslado; probar atomicidad y rollback. [T] | Simular fallo antes y durante el traslado. En cada fallo, la ficha de origen y destino deben quedar en un único estado coherente, sin relaciones parciales; el traslado confirmado debe actualizar todos los registros relacionados como una sola operación. |
| RNF 2.11 — | Por verificar | [G] [V] | Al resolver/cancelar una inconsistencia, comprobar que queda evidencia consultable con actor, fecha/hora, entidad, valores relevantes, decisión y motivo cuando aplique. La operación debe poder rastrearse hasta la carga CSV que la originó. |
| RNF 2.12 — | Por probar | Prueba de carga con volúmenes representativos. [T] | Ejecutar pruebas con el volumen de referencia del requisito (cientos de fichas y miles de aprendices), medir operaciones de consulta/gestión y registrar tiempos y errores. Umbrales de respuesta: pendientes de aprobación antes de declarar conformidad. |
| RNF 2.13 — | Por probar | Ensayar interrupción y recuperación CSV. [T] | Interrumpir una carga durante el procesamiento y verificar que no queden entidades ni relaciones parciales; al restablecer el servicio, volver a procesar el archivo debe producir un resultado consistente y trazable. |
| RNF 2.14 — | Por probar | Validar acentos/ñ por toda la cadena de datos. [T] | Procesar nombres y apellidos con tildes, diéresis y ñ por CSV, formulario, API, almacenamiento, visualización y exportación. Los caracteres deben conservarse sin sustitución ni corrupción en todas las etapas. |
| RNF 3.1 — | Por verificar | [G] [V] | • El listado carga en menos de 2 segundos con hasta 500 usuarios.<br>• El acceso desde otro rol retorna error 403.<br>• Los filtros responden en menos de 1 segundo. |
| RNF 3.2 — | Por verificar | [G] [V] | • El sistema bloquea el registro duplicado.<br>• El error se muestra en tiempo real sin necesidad de enviar el formulario.<br>• No se crea ningún registro parcial en la base de datos. |
| RNF 3.4 — | Por verificar | [G] [V] | • El campo está visualmente deshabilitado en el formulario.<br>• La API rechaza peticiones de actualización del documento con error 400.<br>• El historial del usuario se mantiene intacto tras cualquier otra edición. |
| RNF 3.5 — | Por verificar | No se encontró auditoría completa con actor y valores antes/después. [V] | • Toda modificación genera un registro de auditoría sin excepción.<br>• El registro incluye usuario responsable, fecha/hora, campo y valores.<br>• Los registros de auditoría son de solo lectura; no pueden eliminarse ni modificarse. |
| RNF 3.6 — | Por verificar | [G] [V] | • El acceso se bloquea en menos de 5 segundos tras la desactivación.<br>• Los registros de asistencia del usuario desactivado siguen apareciendo en reportes históricos.<br>• No se elimina ningún dato del usuario al desactivarlo.<br>• El sistema siempre mantiene al menos un Coordinador activo. |
| RNF 4.1 — | Por verificar | [G] [V] | • La pantalla carga en menos de 2 segundos.<br>• Un usuario nunca puede visualizar el perfil de otro usuario.<br>• Los datos mostrados están actualizados al momento de la consulta. |
| RNF 4.5 — | Por verificar | [G] [V] | • Los campos están deshabilitados visualmente para Aprendiz e Instructor.<br>• La API rechaza peticiones de modificación de datos personales de esos roles con error 403.<br>• El Coordinador puede editar datos de cualquier usuario desde el panel de gestión. |
| RNF 5.6 — | Por verificar | URL por defecto puede ser HTTP; comprobar HTTPS de producción. [V] | • Toda transmisión de datos biométricos usa HTTPS sin excepción.<br>• El servidor rechaza datos recibidos por HTTP con error 403.<br>• Los datos con firma inválida son descartados y registrados en auditoría. |
| RNF 7.2 — | Por probar | No hay dataset/backend real de asistencia para medir rendimiento. [T] | • Reporte de hasta 365 días carga en menos de 5 segundos.<br>• Reporte de ficha con 40 aprendices y 90 días carga en menos de 5 segundos.<br>• La paginación muestra máximo 50 registros por página. |
| RNF 7.4 — | Por probar | Validar umbral 80% con datos reales. [T] | • Los aprendices con asistencia < 80% siempre se resaltan en el reporte.<br>• El umbral de alerta es configurable por el Coordinador.<br>• La distinción visual no depende únicamente del color (accesibilidad WCAG 2.1). |

---

### B.4 Regla para continuar la documentación

- Los documentos posteriores (casos de uso, diseño, arquitectura, plan de pruebas y manuales) deben citar el mismo ID y respetar el estado indicado en las fichas y matrices.
- No convertir una secuencia objetivo en evidencia de implementación. Al aceptar una brecha para el release actual, actualizar el código y repetir la verificación; si se difiere, mantenerla fuera del baseline operativo y conservarla en este backlog.
- Antes de aprobar cambios de seguridad facial, credenciales, sesiones o asistencia, obtener decisión del responsable del producto y evidencias de pruebas pertinentes.

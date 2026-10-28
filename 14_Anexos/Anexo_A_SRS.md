# Anexo A — Matriz de trazabilidad

**FaceLit | Documentación del proyecto | Corte 27 oct 2026**
Actualización de estados frente al proyecto revisado el 27 de octubre de 2026

**Objeto.** Esta versión reevalua los requisitos que cambiaron de estado desde la matriz anterior y conserva los identificadores SRS para trazabilidad. La revisión de código no constituye prueba funcional, de seguridad, carga, disponibilidad ni aceptación del despliegue.

## Componentes revisados

| Componente | SHA de HEAD | Alcance evidenciado |
|---|---|---|
| FaceLit frontend | 5f7d6fe | Interfaz Expo web/Android, flujos de roles, asistencia, facial, academic y settings. |
| FaceLit-Backend | 2ab0bcd | API Spring Boot, persistencia, seguridad, asistencia, facial, notificaciones. |
| micro-facial | 1e12c6c | API FastAPI, embeddings, prueba de vida y consultas PostgreSQL. |
| FaceLit-DB | 41a063f | PostgreSQL/pgvector y migraciones Liquibase. |

## Estados usados en esta actualización

- **Integrado en código:** existen ruta, servicio y persistencia/contrato relacionado en el snapshot; requiere prueba integrada para declarar aceptación.
- **Parcial:** hay implementación, pero uno o mas criterios del SRS, permisos, límites o evidencia siguen pendientes.
- **Brecha / sin evidencia:** el criterio no se observa resuelto en los repositorios revisados o queda fuera del alcance vigente.

Esta matriz actualiza los hallazgos afectados por la evolucion reciente. Los requisitos que no aparecen en las siguientes tablas mantienen su estado previo solo como referencia historica y deben reinspecciónarse antes de afirmar conformidad.

---

## A.1 Requisitos funcionales reevaluados

| ID SRS | Estado al corte | Evidencia / limite observado |
|---|---|---|
| RF 5.1 - Registro facial | Integrado en código; aceptar con prueba | Frontend ejecuta flujo de enrolamiento; backend coordina estado, confirmacion y autorización; microservicio genera/guarda plantilla y valida prueba de vida. Requiere validar navegador/camara, persistencia y respuesta en despliegue. |
| RF 5.2 - Sesion de reconocimiento | Parcial | Configuración de sesión, ambiente, Instructor, ficha y tiempos se conecta con API/backend; el flujo presencial y el cierre requieren prueba por rol y entorno. |
| RF 5.3 / RNF 5.5 - Umbral | Parcial / verificar criterio | El servicio facial declara configuración de coincidencia (`FACIAL_MATCH_THRESHOLD`, default 0.65). No se declara conformidad con rangos/tiempos del SRS sin comprobar validación, aplicación y despliegue. |
| RF 5.4 / RNF 5.4 - Privacidad biométrica | Brecha / requiere revisión | La integración facial existe, pero esta evidencia no acredita cifrado de plantillas en reposo, descarte de imagen original, minimizacion de respuestas ni ciclo de retención. |
| RF 6.1-6.2 - Configuración/tiempos | Integrado en código; aceptar con prueba | El backend mantiene sesiones de ambiente con Instructor responsable/reemplazo y horarios. Validar reglas, persistencia y expiración en la versión desplegada. |
| RF 7.1-7.3 - Registro/consulta asistencia | Integrado parcialmente | Existe flujo de captura facial hacia API/backend y modelo de eventos/matriz en PostgreSQL. La cobertura de reportes, correcciones manuales, exportaciones y todos los criterios del SRS requiere pruebas y cotejo por rol. |
| RF 8.4 - Solicitud de nuevo rostro | Integrado en código; aceptar con prueba | El aprendiz solicita reinicio; el Coordinador resuelve notificación; la sustitucion exige autorización aprobada, vigente y de un solo uso. Probar errores y consumo atomico en entorno coordinado. |
| RF 9.1 - Reportes | Parcial | Hay pantallas y consultas de asistencia. La revisión estatica no demuestra calculos, filtros, permisos y exportaciones completos para todos los reportes. |
| RF 2.1 / RF 3.x - CSV y cuentas | Parcial | Se observan APIs, pantallas de gestión/CSV y servicios; deben probarse validaciones, transacciones, acceso por rol y presentacion de credenciales. |
| RF-C1 - Horarios académicos | Fuera del alcance actual | La gestión de horarios/excepciones fue retirada del alcance vigente. No presentar rutas historicas o archivos residuales como una funcion soportada. |
| RF-C2 - Ambientes/sesiones | Parcial | API y persistencia de sesiones presentes; ciertas operaciones de catalogo de ambientes pueden no tener soporte completo. |
| RF-C3 / RF-C4 - Preferencias/tiempo real | Parcial | API de preferencias y WebSocket existen; persistencia por opcion, autorización y eventos de extremo a extremo requieren prueba. |

---

## A.2 Requisitos no funcionales y evidencia

| Tema / IDs | Estado | Evaluacion actual |
|---|---|---|
| Acceso por rol (RF 1.2-1.3, RNF 1.4, 1.16) | Parcial | API define controles por rol; el frontend documenta guards que no verifican todas las restricciones de rol/propiedad. Probar acceso directo y alcance por ficha en API y UI. |
| Recuperacion de cuenta (RF 1.4, RNF 1.9) | Parcial | Se localiza flujo de solicitud, verificación y restablecimiento; validar expiración, uso unico, límites y auditoria en ejecucion. |
| Credenciales (RF 3.4, RNF 3.3) | Brecha por cerrar | No afirmar que la presentacion/exportacion de credenciales iniciales cumple privacidad hasta inspecciónar y corregir el flujo completo. |
| Biometria (RNF 5.1-5.6) | Parcial / brecha de privacidad | Prueba de vida e integración estan en código. La revisión no certifica cifrado, retención, manejo de imagen, transporte productivo ni calibracion del umbral. |
| Disponibilidad, rendimiento, usabilidad (RNF 1.12-1.14 y 2.12) | Por probar | Requiere protocolo, ambiente, volumen, métricas y resultados del despliegue. No hay conformidad por inspección estatica. |
| Offline/Raspberry (RNF 5.7) | Sin evidencia / fuera del baseline | No se encontro componente Raspberry ni cola offline cifrada en los cuatro repositorios revisados. Mantener como evolucion aprobada o excluir explicitamente. |
| Notificaciones/correo (RF 8.x, RNF 8.x) | Parcial | Servicios, catalogo y politicas existen. Límites, cronologia, reintentos, deduplicacion y recepcion real dependen de pruebas SMTP/WebSocket y entorno. |

---

## A.3 Linea base y restricciones

- Corte: 27 de octubre de 2026; rama frontend/backend/micro-facial `dev` y base de datos `main` segun HEAD local indicado.
- FaceLit tiene cambios locales no confirmados en `app.json` y `eas.json`; el SHA de frontend no incluye esos cambios. No inferir que el PDF describe un APK/export final.
- No se ejecutaron pruebas ni se valido el entorno productivo para esta actualización.
- La matriz completa de 93 requisitos originales se mantiene como fuente historica; esta revisión delta reemplaza solamente las afirmaciones de estado relacionadas arriba.

**Fuentes tecnicas:** README y código de los cuatro repositorios FaceLit, FaceLit-Backend, micro-facial y FaceLit-DB en los SHA indicados.

---
---

# ANEXO HISTORICO - MATRIZ ANTERIOR

> Estas paginas reproducen, sin modificacion, el anexo recibido antes de la actualizacion. Sus estados de codigo corresponden a una revision anterior y no deben tomarse como estado vigente cuando contradigan las paginas iniciales. Para el corte 27 de octubre de 2026, usa primero la actualizacion delta que abre este PDF. El original completo se conserva en el repositorio.
>
> Fin de la actualizacion; comienza la copia historica sin cambios.

**FACELIT | SRS V3 | Anexo A**

## Anexo A. Matriz de trazabilidad de implementación

**Método y alcance.** Inspección estática del frontend FaceLit y backend FaceLit-Backend entregados. No equivale a prueba funcional, seguridad, carga, disponibilidad ni validación del despliegue. *Parcial* = hay evidencia de parte del requisito; *Brecha* = diferencia observable; *Por verificar* = falta confirmar el comportamiento/configuración en el repositorio o entorno; *Por probar* = criterio medible sin evidencia de ejecución; *Sin evidencia* = no se encontró componente/soporte en los repositorios revisados. La ficha de cada RF/RNF muestra su estado junto al identificador; el texto original y sus criterios se conservan como requisitos objetivo, no como funciones certificadas.

### Hallazgos prioritarios

- **Asistencia:** frontend usa datos locales de demostración y backend revisado no contiene persistencia de asistencia; registro automático/manual y reportes no están integrados.
- **Reconocimiento facial:** cliente envía una imagen; backend define reto/múltiples muestras. No se evidencia integración; vector/foto persisten, umbral fijo 0.45 y resolver solicitud no inicia re-enrolamiento.
- **Credenciales y privacidad:** frontend presenta/exporta contraseña inicial en claro y muestra correo completo.
- **Sesiones:** se acepta correo además de documento; logout no invalida sesión en backend y no se encontró timeout de 30 minutos.
- **Notificaciones:** cobertura parcial; límite horario no evidenciado y reintentos observados difieren del backoff solicitado.

**Pendiente de completar en las fichas RF:** 43 campos de secuencia/alternativa fueron identificados sin contenido y se reemplazaron por una indicación explícita de "no documentado"; 9 fichas no tenían campo de escenario alternativo y se agregó. No son flujos inventados: requieren levantamiento funcional/ejecución.

**Orden sugerido para los documentos derivados:** (1) congelar y fechar esta línea base; (2) acordar alcance futuro de asistencia real, Raspberry/offline y enrolamiento facial integrado; (3) elaborar plan de pruebas para estados "Por probar/Por verificar"; (4) derivar casos de uso, arquitectura, diseño y casos de prueba usando solo requisitos aprobados.

**Uso como documento maestro:** para describir la versión existente, prevalecen el alcance actual y la columna "Estado frente al baseline" de cada ficha. Los criterios originales con estado Parcial/Brecha/Pendiente se conservan como objetivos no cumplidos; deben retirarse del alcance vigente o mantenerse como evolución aprobada, sin presentarlos como funciones disponibles.

**Cobertura de la matriz original del Anexo A:** 30 RF y 63 RNF (93 requisitos). El Anexo C agrega 4 requisitos funcionales complementarios observados (RF-C1 a RF-C4); total del inventario documental: 34 RF y 63 RNF (97 requisitos). Los RF-C1 a RF-C4 no forman parte de los conteos del backlog original del Anexo B.

### Resumen para documentos derivados

- **P0 Seguridad/privacidad:** RF 1.1, RF 3.4, RNF 1.10, RNF 1.11, RNF 3.3, RNF 4.2, RNF 4.3, RNF 4.4, RNF 5.4, RNF 5.5.
- **P1 Funciones de negocio no integradas:** RF 5.1, RF 5.3, RF-5.4, RF 6.1, RF 6.2, RF 7.1, RF 7.2, RF 7.3, RF 8.4, RF 9.1, RNF 5.3, RNF 5.7, RNF 6.1, RNF 6.2, RNF 6.3, RNF 6.4, RNF 6.5, RNF 7.1, RNF 7.3, RNF 7.5, RNF 8.3, RNF 8.4.
- **Pendiente de decisión/desarrollo (23):** RF 3.4, RF 5.1, RF 5.3, RF 7.1, RF 7.2, RF 7.3, RF 8.4, RNF 1.10, RNF 1.11, RNF 1.16, RNF 3.3, RNF 4.2, RNF 4.3, RNF 4.4, RNF 5.3, RNF 5.4, RNF 5.5, RNF 6.1, RNF 6.2, RNF 6.3, RNF 6.4, RNF 8.3, RNF 8.4.
- **Componente no evidenciado (1):** RNF 5.7.
- **Pendiente de inspección/configuración (25):** RF-2.2, RF-4.2, RF-5.4, RNF 1.2, RNF 1.6, RNF 1.7, RNF 1.8, RNF 1.15, RNF 2.1, RNF 2.2, RNF 2.3, RNF 2.4, RNF 2.6, RNF 2.7, RNF 2.8, RNF 2.9, RNF 2.11, RNF 3.1, RNF 3.2, RNF 3.4, RNF 3.5, RNF 3.6, RNF 4.1, RNF 4.5, RNF 5.6.
- **Pendiente de prueba (10):** RNF 1.12, RNF 1.13, RNF 1.14, RNF 2.5, RNF 2.10, RNF 2.12, RNF 2.13, RNF 2.14, RNF 7.2, RNF 7.4.
- **Implementación parcial (34):** RF 1.1, RF 1.2, RF 1.3, RF 1.4, RF 2.1, RF 2.1.1, RF 2.3, RF 3.1, RF 3.2, RF 3.3, RF 3.5, RF 3.6, RF 4.1, RF 5.2, RF 6.1, RF 6.2, RF 8.1, RF 8.2, RF 8.3, RF 9.1, RNF 1.5, RNF 1.1, RNF 1.3, RNF 1.4, RNF 1.9, RNF 3.7, RNF 5.1, RNF 5.2, RNF 6.5, RNF 7.1, RNF 7.3, RNF 7.5, RNF 8.1, RNF 8.2.

---

### A.1 Requerimientos funcionales

> **Texto de "Siguiente paso" (se abrevia con claves en las tablas):**
> **[P]** Precisar qué parte pertenece al baseline actual y qué parte queda pendiente; verificar el límite en el flujo real.
> **[D]** Decidir si se retira del baseline actual o se conserva como requisito futuro; no declarar disponible sin cambio aprobado y nueva verificación.
> **[V]** Inspeccionar configuración/endpoint aplicable y documentar evidencia o registrar la brecha concreta. (Evidencia genérica: "Definir caso de aceptación y reunir evidencia de ejecución; no se concluye conformidad por inspección estática.")
> **[T]** Definir caso, datos, entorno y umbral de aceptación; adjuntar resultado de ejecución antes de marcar conforme.
> **[E]** Confirmar si el componente falta del alcance entregado; excluirlo del baseline o enlazar el repositorio/evidencia que falta.

| ID y requisito | Estado del baseline | Evidencia del código revisado | Siguiente paso |
|---|---|---|---|
| RF 1.1 — | Parcial | LoginServiceImpl admite búsqueda por documento y correo; el criterio exige documento. | [P] |
| RF 1.2 — | Parcial | SecurityConfig protege API por rol; layouts del frontend usan useAuthGuard sin validar rol. | [P] |
| RF 1.3 — | Parcial | Backend asigna rol/permisos; falta validar matriz de acceso completa. | [P] |
| RF 1.4 — | Parcial | Código de seis dígitos, expira en cinco minutos y se marca usado; falta prueba funcional. | [P] |
| RF 2.1 — | Parcial | Existe carga CSV UI/API; atomicidad y límites requieren pruebas. | [P] |
| RF 2.1.1 — | Parcial | Existe plantilla/guía; cotejar columnas y validaciones de extremo a extremo. | [P] |
| RF-2.2 — | Por verificar | Definir caso de aceptación y reunir evidencia de ejecución; no se concluye conformidad por inspección estática. | [V] |
| RF 2.3 — | Parcial | Endpoint de traslado de Coordinador existe; UI también contiene flujo de código/solicitud del aprendiz, requiere unificación. | [P] |
| RF 3.1 — | Parcial | Hay panel/listado; validar filtros, paginación y alcance. | [P] |
| RF 3.2 — | Parcial | Hay consultas y gestión; probar estados y permisos. | [P] |
| RF 3.3 — | Parcial | Hay alta de usuario; la UI recibe y presenta credenciales iniciales. | [P] |
| RF 3.4 — | Brecha | Frontend muestra/exporta la contraseña inicial en claro, contrario a criterios de privacidad. | [D] |
| RF 3.5 — | Parcial | API restringe roles; guards de rutas UI no están alineados. | [P] |
| RF 3.6 — | Parcial | Existe gestión de estado; probar bloqueo, preservación de historial y auditoría. | [P] |
| RF 4.1 — | Parcial | Existe perfil propio; muestra correo completo, contrario a RNF 4.2. | [P] |
| RF-4.2 — | Por verificar | Definir caso de aceptación y reunir evidencia de ejecución; no se concluye conformidad por inspección estática. | [V] |
| RF 5.1 — | Brecha | Cliente envía una imagen al servicio de embeddings; backend define reto/múltiples muestras. No se evidencia integración. | [D] |
| RF 5.2 — | Parcial | Hay pantallas/endpoints de sesión sin flujo facial completo conectado. | [P] |
| RF 5.3 — | Brecha | Backend usa umbral fijo 0.45; SRS pide configurable y default 0.6. | [D] |
| RF-5.4 — | Por verificar | Definir caso de aceptación y reunir evidencia de ejecución; no se concluye conformidad por inspección estática. | [V] |
| RF 6.1 — | Parcial | Hay configuración visual pero no está conectada a asistencia real. | [P] |
| RF 6.2 — | Parcial | Ajustes locales/UI; persistencia durable no evidenciada. | [P] |
| RF 7.1 — | Brecha | UI usa registros locales/demostrativos; no se encontró persistencia backend de asistencia por ficha. | [D] |
| RF 7.2 — | Brecha | Consulta individual usa datos locales; falta API/backend de asistencia persistida. | [D] |
| RF 7.3 — | Brecha | Vista historial existe, con fuente local, no historial real persistido. | [D] |
| RF 8.1 — | Parcial | Backend crea algunas notificaciones; falta comprobar catálogo completo. | [P] |
| RF 8.2 — | Parcial | Hay listado/marcado; validar sincronización, retención y alcance por rol. | [P] |
| RF 8.3 — | Parcial | Hay envío/reintentos; no se evidencia límite de cinco correos por hora. | [P] |
| RF 8.4 — | Brecha | Resolución de solicitud no dispara re-enrolamiento. | [D] |
| RF 9.1 — | Parcial | Pantallas/exportaciones existen; reportes de asistencia usan datos locales. | [P] |

---

### A.2 Requerimientos no funcionales

| ID y requisito | Estado del baseline | Evidencia del código revisado | Siguiente paso |
|---|---|---|---|
| RNF 1.2 — Política de contraseñas | Por verificar | El código revisado no acredita de forma concluyente la regla de 8–15 caracteres con letra, número y símbolo en todos los flujos. La persistencia de contraseñas se realiza con hash; verificar política en alta y recuperación. | [V] |
| RNF 1.5 — Restricción de información por rol | Parcial | SecurityConfig aplica autorización por rol en API; los layouts de frontend usan guard de autenticación y no validan el rol. Las restricciones específicas de fichas/asistencia requieren pruebas. | [P] |
| RNF 1.1 — | Parcial | BCrypt/JWT presentes; transporte/despliegue requiere revisión. | [P] |
| RNF 1.3 — | Parcial | Hay bloqueo temporal; probar límite y duración. | [P] |
| RNF 1.4 — | Parcial | RBAC en API; guards UI no validan rol. | [P] |
| RNF 1.6 — | Por verificar | Cifrado en reposo/secretos dependen de infraestructura. | [V] |
| RNF 1.7 — | Por verificar | Definir caso de aceptación y reunir evidencia de ejecución; no se concluye conformidad por inspección estática. | [V] |
| RNF 1.8 — | Por verificar | No se acreditó auditoría completa de operaciones. | [V] |
| RNF 1.9 — | Parcial | Código de recuperación con vencimiento/uso único visible; probar escenarios negativos. | [P] |
| RNF 1.10 — | Brecha | Login admite correo y perfil expone correo completo. | [D] |
| RNF 1.11 — | Brecha | Token de ocho horas; logout no invalida sesión en backend. | [D] |
| RNF 1.12 — | Por probar | No hay medición de rendimiento de acceso. | [T] |
| RNF 1.13 — | Por probar | Disponibilidad requiere evidencia del entorno operativo. | [T] |
| RNF 1.14 — | Por probar | Usabilidad requiere validación con usuarios. | [T] |
| RNF 1.15 — | Por verificar | Definir caso de aceptación y reunir evidencia de ejecución; no se concluye conformidad por inspección estática. | [V] |
| RNF 1.16 — | Brecha | Permisos UI/API desalineados. | [D] |
| RNF 2.1 — | Por verificar | Definir caso de aceptación y reunir evidencia de ejecución; no se concluye conformidad por inspección estática. | [V] |
| RNF 2.2 — | Por verificar | Definir caso de aceptación y reunir evidencia de ejecución; no se concluye conformidad por inspección estática. | [V] |
| RNF 2.3 — | Por verificar | No se acreditó trazabilidad integral de operaciones. | [V] |
| RNF 2.4 — | Por verificar | Definir caso de aceptación y reunir evidencia de ejecución; no se concluye conformidad por inspección estática. | [V] |
| RNF 2.5 — | Por probar | Medir requisito de carga de CSV con volumen indicado. | [T] |
| RNF 2.6 — | Por verificar | Definir caso de aceptación y reunir evidencia de ejecución; no se concluye conformidad por inspección estática. | [V] |
| RNF 2.7 — | Por verificar | Definir caso de aceptación y reunir evidencia de ejecución; no se concluye conformidad por inspección estática. | [V] |
| RNF 2.8 — | Por verificar | Definir caso de aceptación y reunir evidencia de ejecución; no se concluye conformidad por inspección estática. | [V] |
| RNF 2.9 — | Por verificar | Definir caso de aceptación y reunir evidencia de ejecución; no se concluye conformidad por inspección estática. | [V] |
| RNF 2.10 — | Por probar | Existe traslado; probar atomicidad y rollback. | [T] |
| RNF 2.11 — | Por verificar | Definir caso de aceptación y reunir evidencia de ejecución; no se concluye conformidad por inspección estática. | [V] |
| RNF 2.12 — | Por probar | Prueba de carga con volúmenes representativos. | [T] |
| RNF 2.13 — | Por probar | Ensayar interrupción y recuperación CSV. | [T] |
| RNF 2.14 — | Por probar | Validar acentos/ñ por toda la cadena de datos. | [T] |
| RNF 3.1 — | Por verificar | Definir caso de aceptación y reunir evidencia de ejecución; no se concluye conformidad por inspección estática. | [V] |
| RNF 3.2 — | Por verificar | Definir caso de aceptación y reunir evidencia de ejecución; no se concluye conformidad por inspección estática. | [V] |
| RNF 3.3 — | Brecha | Backend almacena hash, pero frontend muestra/exporta contraseña inicial en claro. | [D] |
| RNF 3.4 — | Por verificar | Definir caso de aceptación y reunir evidencia de ejecución; no se concluye conformidad por inspección estática. | [V] |
| RNF 3.5 — | Por verificar | No se encontró auditoría completa con actor y valores antes/después. | [V] |
| RNF 3.6 — | Por verificar | Definir caso de aceptación y reunir evidencia de ejecución; no se concluye conformidad por inspección estática. | [V] |
| RNF 3.7 — | Parcial | Hay exportación; verificar filtros y exclusión de credenciales. | [P] |
| RNF 4.1 — | Por verificar | Definir caso de aceptación y reunir evidencia de ejecución; no se concluye conformidad por inspección estática. | [V] |
| RNF 4.2 — | Brecha | `app/profile/index.tsx` muestra correo sin enmascarar. | [D] |
| RNF 4.3 — | Brecha | Logout elimina token local; servidor no invalida sesión. | [D] |
| RNF 4.4 — | Brecha | No se encontró timeout tras 30 minutos de inactividad. | [D] |
| RNF 4.5 — | Por verificar | Definir caso de aceptación y reunir evidencia de ejecución; no se concluye conformidad por inspección estática. | [V] |
| RNF 5.1 — | Parcial | Validación visual difiere en web/nativo; probar los escenarios. | [P] |
| RNF 5.2 — | Parcial | Validación de calidad no está acreditada en todos los dispositivos. | [P] |
| RNF 5.3 — | Brecha | Requisito pide tres capturas; backend requiere siete muestras y cliente envía una. | [D] |
| RNF 5.4 — | Brecha | Backend persiste vector y foto JPEG; no se evidencia cifrado del vector ni descarte de imagen original. | [D] |
| RNF 5.5 — | Brecha | Umbral fijo 0.45, no configurable. | [D] |
| RNF 5.6 — | Por verificar | URL por defecto puede ser HTTP; comprobar HTTPS de producción. | [V] |
| RNF 5.7 — | Sin evidencia | No se halló sincronización offline cifrada/Raspberry. | [E] |
| RNF 6.1 — | Brecha | No hay asistencia persistida conectada; cliente usa fuente local temporal. | [D] |
| RNF 6.2 — | Brecha | No se halló clasificación de asistencia real por horario. | [D] |
| RNF 6.3 — | Brecha | No se encontró servicio persistente con inmutabilidad/anulación auditada. | [D] |
| RNF 6.4 — | Brecha | No se identificó cálculo mensual de retrasos/alerta. | [D] |
| RNF 6.5 — | Parcial | Hay UI manual local; falta evidencia de persistencia/auditoría. | [P] |
| RNF 7.1 — | Parcial | Vistas por rol existen; datos locales y autorización API no demostrada. | [P] |
| RNF 7.2 — | Por probar | No hay dataset/backend real de asistencia para medir rendimiento. | [T] |
| RNF 7.3 — | Parcial | Hay exportación XLSX; verificar igualdad con filtros visibles. | [P] |
| RNF 7.4 — | Por probar | Validar umbral 80% con datos reales. | [T] |
| RNF 7.5 — | Parcial | Calendario visible; eventos locales/demostrativos. | [P] |
| RNF 8.1 — | Parcial | Se generan algunos eventos; validar catálogo entero. | [P] |
| RNF 8.2 — | Parcial | Persistencia/listado presentes; verificar retención 30 días y sincronización. | [P] |
| RNF 8.3 — | Brecha | No se encontró límite de cinco correos por usuario/hora. | [D] |
| RNF 8.4 — | Brecha | Dispatcher hasta tres reintentos cada cinco minutos; SRS solicita push con backoff 1/2/4 segundos. | [D] |

---

### A.3 Consistencia editorial y pendientes

- Corregida la perspectiva del producto que describía recetas/restaurantes; ahora describe FaceLit.
- Corregido el índice funcional: añadido RF-2.3 y corregida referencia RF-3.4 duplicada a RF-3.6 para estado de usuario.
- Las 30 fichas funcionales tienen vacíos los campos "Secuencia Normal" y "Escenario Alternativo"; completarlos antes de entrega.
- RF-4.1/RF-4.2 y RF-5.4 mantienen metadatos de propuesta/aprobación pendiente; confirmar aprobación y versión.
- El SRS menciona Raspberry Pi y operación offline; no se entregó repositorio de ese componente.
- La matriz es diagnóstico estático. Completar pruebas de aceptación y guardar evidencia antes de declarar conformidad.

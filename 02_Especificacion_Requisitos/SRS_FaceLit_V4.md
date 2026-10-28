# FaceLit
**Especificación de requisitos de software**

Sistema de gestión académica y asistencia con apoyo de reconocimiento facial

| RF principales | RF complementarios | RNF |
|---|---|---|
| 30 | 4 | 63 |

Versión 4.0 · baseline de requisitos: 13 de octubre de 2026  
Actualización de estado documentado: 27 de octubre de 2026  
Valery Sinaí Trujillo · María José Rodríguez Oyola · Mariana Valenzuela Penagos  
Instructor: Motta Vargas José de Jesús  
SENA · Análisis y Desarrollo de Software · Ficha 3145555  

---

# Control documental

FaceLit es un sistema para gestionar información académica y registrar asistencia mediante reconocimiento facial en ambientes de formación del SENA. Esta especificación consolida funciones, reglas, restricciones, criterios de aceptación e interfaces del producto para orientar su implementación, revisión y entrega académica.

| Dato | Valor |
|---|---|
| Documento | Especificación de requisitos de software de FaceLit |
| Versión | 4.0 — baseline de requisitos |
| Fecha del baseline de requisitos | 13 de octubre de 2026 |
| Fecha de actualización de estado | 27 de octubre de 2026 |
| Institución | Servicio Nacional de Aprendizaje SENA |
| Programa y ficha | Análisis y Desarrollo de Software 3145555 |
| Equipo | Valery Sinaí Trujillo; María José Rodríguez Oyola; Mariana Valenzuela Penagos |
| Instructor | Motta Vargas José de Jesús |
| Estado documental | SRS V4.0; actualización documental del estado conocido al 27 de octubre de 2026. Los requisitos conservan el baseline del 13 de octubre. |
| Cobertura | 30 RF principales, 4 RF complementarios y 63 RNF |
| Idioma | Español |

## Historial de versiones

| Versión | Referencia | Cambio |
|---|---|---|
| 3.0 | Documento previo | Requisitos objetivo y diagnóstico de implementación. |
| 4.0 | 13 octubre 2026 | Baseline de requisitos: alcance, contratos, seguridad, numeración, criterios y trazabilidad. |
| Actualización de estado | 27 octubre 2026 | Se incorpora evidencia documentada de HU-45, H-50 y despliegue; no se declaran cerrados requisitos sin revalidación por ID. |

La versión documental no constituye una certificación de cumplimiento del software. El anexo de trazabilidad separa el comportamiento requerido del estado observado. Las decisiones DEC-01 a DEC-06 requieren validación institucional antes de aceptar los aspectos que dependen de ellas; su existencia no invalida los requisitos ya determinados.

# 1 Introducción

## 1.1 Propósito

Establecer de manera verificable el comportamiento de FaceLit, sus límites de acceso, sus datos y sus atributos de calidad. El documento sirve al equipo desarrollador, instructor, responsables académicos y evaluadores como referencia para diseño, implementación, pruebas y aceptación.

## 1.2 Problema y justificación

El control manual de asistencia exige registrar cada aprendiz, comprobar su llegada y conservar evidencia de puntualidad e inasistencia. Las omisiones, la duplicidad de registros y la dispersión de información dificultan el seguimiento. FaceLit propone automatizar parte de ese proceso y reunir la gestión académica, las sesiones y los reportes en una fuente trazable. El reconocimiento facial aporta una verificación de identidad, pero su eficacia debe demostrarse con pruebas y controles contra suplantación.

## 1.3 Objetivo general

Desarrollar un sistema de gestión y registro de asistencia académica mediante reconocimiento facial que permita identificar a los aprendices, registrar entrada y salida, clasificar puntualidad y consultar información confiable por rol.

## 1.4 Objetivos específicos

- Gestionar programas, fichas, personas y relaciones por CSV y formularios con integridad y auditoría.
- Establecer sesiones vinculadas a horario, ambiente, responsables y dispositivo.
- Registrar referencias faciales y verificar capturas con controles de vida, calidad y privacidad.
- Generar consultas, reportes y exportaciones a partir de eventos reales y consistentes.
- Proteger autenticación, autorización, sesiones, credenciales y datos personales.
- Verificar requisitos funcionales y de calidad mediante casos de aceptación trazables.

## 1.5 Convenciones de lectura

“Deberá” expresa una obligación del producto. Cada RF identifica actor, entrada, flujo, alternativas, resultado y aceptación. Los RNF definen controles y atributos comprobables. Los IDs RF-1.1 a RF-9.1 y RNF-1.1 a RNF-8.4 se conservan; RF-C1 a RF-C4 pertenecen al inventario complementario. El orden del módulo de RNF no se asume equivalente al número de RF: las relaciones se indican explícitamente.

# 2 Alcance y perspectiva del producto

## 2.1 Alcance funcional requerido

- Acceso por documento, recuperación, roles, permisos, sesiones y perfil.
- Gestión académica institucional, vínculos, traslados y decisiones sobre inconsistencias CSV.
- Gestión de cuentas, estado y credenciales iniciales protegidas.
- Registro y re-registro facial autorizado, parámetros y sesiones de captura.
- Asistencia por entrada y salida, consulta, respaldo manual y anulación auditada.
- Notificaciones, reportes, calendario, exportaciones y sincronización en tiempo real.
- Horarios, excepciones, ambientes y dispositivos como soporte de asistencia.

## 2.2 Alcance operativo observado

El proyecto contiene una aplicación Expo y React Native, un backend Java Spring Boot, migraciones PostgreSQL con Liquibase y un servicio facial Python FastAPI. Hay llamadas reales para autenticación, gestión académica, usuarios, preferencias, notificaciones, sesiones y captura/consulta de asistencia. El servicio facial usa InsightFace y persiste referencias en la base de datos. La presencia de estos componentes no prueba por sí sola un flujo aceptado. Persisten reportes e historiales con fuentes locales, horarios/excepciones sin API persistente encontrada, contratos de enrolamiento Java incompatibles con el esquema suministrado y controles de autorización/sesión incompletos. El anexo 11 registra cada estado con evidencia y evita presentar una meta como función certificada.

## 2.3 Exclusiones y condicionantes

No se incluyen calificaciones, evaluación pedagógica, nómina, pagos o sanciones automáticas. La identificación no sustituye decisiones académicas del personal autorizado. La operación de Raspberry Pi y sincronización facial offline se conserva como requisito RNF-5.7; no se suministró componente para considerarla implementada. Su incorporación a un despliegue debe cumplir DEC-04.

## 2.4 Dependencias y supuestos

- Catálogos institucionales y responsables autorizados mantienen datos académicos correctos.
- Los dispositivos cuentan con cámara y permisos; los servicios tienen conexión protegida y reloj sincronizado.
- Producción provee administración de claves, respaldo y canal de correo/push cuando se habilite.
- La aceptación biométrica utiliza un conjunto de pruebas representativo aprobado; no se asume precisión por la selección de una biblioteca.
- Las reglas de retención, consentimiento, disponibilidad y recuperación se aprueban por los responsables indicados en el registro de decisiones.

# 3 Actores y matriz de permisos

| Actor | Responsabilidad |
|---|---|
| Aprendiz | Consulta sus datos y asistencia, confirma identidad, registra su rostro y solicita re-registro. |
| Instructor | Configura sesiones autorizadas, consulta sus fichas y registra respaldo manual cuando falla reconocimiento. |
| Coordinador | Gestiona información académica y cuentas; decide traslados, solicitudes, anulaciones y parámetros institucionales. |
| Coordinador de Registro | Rol objetivo restringido previsto en RF-3.3 y RF-3.5. No equivale automáticamente a COORDINATOR. Su conjunto de operaciones se establece en DEC-01. |
| Sistema | Valida, persiste, clasifica, audita, notifica y sincroniza. |
| Servicio facial y dispositivo | Capturan/procesan evidencia y devuelven una verificación; no conceden permisos administrativos. |

| Operación | Aprendiz | Instructor | Coordinador | Registro |
|---|---|---|---|---|
| Perfil y preferencias propios | Propio | Propio | Propio | Propio |
| Gestión académica CSV/manual | No | Consulta de alcance | Sí | DEC-01 |
| Gestión de cuentas y roles | No | No | Sí | No por defecto |
| Preparar sesión facial | No | Asignada o suplencia | Permiso específico | DEC-01 |
| Registro facial | Titular autorizado | No sobre terceros | Resuelve solicitudes | No por defecto |
| Consultar asistencia | Propia | Fichas autorizadas | Ámbito administrativo | DEC-01 |
| Registro manual de respaldo | No | Asignado | Valida | No por defecto |
| Anular asistencia | No | No | Con justificación | No |
| Cambiar umbral institucional | No | Solo delegación de sesión | Sí | No |
| Bandeja de notificaciones | Propia | Propia | Propia | Propia |

Las celdas “DEC-01” no conceden autorización. Mientras no exista perfil aprobado e implementado, se aplica denegación por defecto. La elegibilidad de un instructor transversal para un programa no implica permiso para cualquier sesión: se requiere asignación o reemplazo autorizado. Toda consulta valida también el objeto solicitado, no únicamente el rol.

# 4 Reglas de negocio

| Regla | Definición |
|---|---|
| RB-01 | El documento identifica la cuenta y es inmutable en la edición ordinaria; el correo se utiliza para recuperación y comunicación. |
| RB-02 | Cada documento, correo de cuenta, código de programa y código de ficha debe cumplir las reglas de unicidad del dominio. |
| RB-03 | Una ficha pertenece a un programa. El aprendiz operativo tiene una única ficha activa; el historial conserva vínculos previos. |
| RB-04 | Instructor específico puede tener uno o varios programas. Instructor transversal no se restringe a un programa; su operación de sesión mantiene autorización por asignación/reemplazo. |
| RB-05 | Alta administrativa crea solo Coordinador de Registro; altas académicas asignan aprendiz o instructor según la entidad. Coordinador pleno no se concede implícitamente. |
| RB-06 | Toda cuenta nueva obtiene credencial aleatoria protegida; el coordinador no escribe, ve ni exporta la contraseña. |
| RB-07 | Cambios de ficha propuestos por CSV quedan pendientes hasta decisión del coordinador. Traslado confirmado es atómico y conserva la historia. |
| RB-08 | Error de negocio de una fila CSV se informa y excluye. Un fallo técnico antes del commit revierte el conjunto de cambios de esa carga. |
| RB-09 | Solo un rostro por captura; referencia inicial exige al menos tres ángulos distintos, calidad y vida. Re-registro necesita autorización temporal de un uso. |
| RB-10 | Se conservan descriptor protegido y metadatos de modelo/versión. Las imágenes de captura no se usan como foto de perfil ni se conservan tras el procesamiento. |
| RB-11 | La sesión tiene ficha, ambiente, dispositivo, instructor programado, responsable real y tiempos. Reemplazo queda identificado y autorizado. |
| RB-12 | Para entrada E, tolerancia T, salida S y cierre A: 0 <= T <= 30; E + T < S < A. Entrada [E,E+T] puntual; (E+T,S) retardo; [S,A) salida. |
| RB-13 | Máximo una entrada y una salida por aprendiz/sesión. Una salida sin entrada no acredita una asistencia puntual. |
| RB-14 | Ausencia solo se evalúa sobre una sesión efectiva para el aprendiz; horario cancelado o día sin clase no constituye ausencia. |
| RB-15 | Los hechos son inmutables; anulación y excusa se registran de forma trazable. El respaldo manual queda pendiente de validación. |
| RB-16 | Se mantienen al menos un coordinador activo y el historial de cuentas desactivadas. Logout/desactivación/cambio de rol afectan tokens y canales. |
| RB-17 | Porcentajes se calculan sobre sesiones aplicables. Se distinguen puntualidad, retardo, ausencia, sin clase y sin registro; el denominador se muestra/documenta. |
| RB-18 | Reportes y exportaciones usan eventos reales y el mismo filtro/alcance. No incluyen contraseñas, imágenes ni descriptores. |
| RB-19 | Notificación se asocia a evento/destinatario; lectura no implica aprobación. Reintentos no duplican eventos ni entregas exitosas. |
| RB-20 | Parámetros institucionales se versionan. Cambios retroactivos requieren recálculo autorizado y no borran los hechos originales. |

# 5 Datos, interfaces y arquitectura

## 5.1 Componentes y responsabilidades

| Componente | Responsabilidad | Límite |
|---|---|---|
| FaceLit | Interfaz web/móvil, captura, consultas y preferencias. | No determina identidad autorizada, resultado definitivo ni privilegios. |
| FaceLit Backend | API, permisos, reglas de negocio, sesión, asistencia y auditoría. | No confía en actor/fecha/score libres enviados por cliente. |
| Micro facial | Extracción y comparación, validación de vida/calidad. | Opera con autorización del servidor o identidad/alcance equivalente. |
| FaceLit DB | Esquema, restricciones, transacciones y migraciones. | Una base nueva debe aceptar los mismos contratos que la API. |
| Correo y canal de tiempo real | Entrega y actualización de interfaz. | Un mensaje no sustituye un registro persistente ni una decisión. |

## 5.2 Modelo de datos lógico

| Entidad | Datos y relaciones mínimos |
|---|---|
| Usuario y credencial | UUID, documento, nombre/apellido, correo protegido, hash, estado, contador/bloqueo y marcas de creación/cambio. |
| Rol, permiso y sesión | Asignación vigente, permisos, emisión/expiración, revocación y eventos de autenticación. |
| Programa, ficha y personas | Códigos, nombres, estado, fechas; vínculos de aprendiz/ficha e instructor/programa/ficha con historia. |
| Carga y propuesta CSV | Identidad de carga, actor, resumen por fila, conflicto, valores, propuesta y resolución. |
| Horario, excepción y ambiente | Vigencia, ambiente, ficha, franjas, responsable, sustitución/cancelación y motivo. |
| Sesión y dispositivo | Ambiente, ficha, dispositivo, programado/reemplazo, entrada, tolerancia, salida, cierre y versión. |
| Referencia y solicitud facial | Aprendiz, descriptor protegido, modelo/dimensión/versión, estado; solicitud, decisión y autorización de un uso. |
| Asistencia y anotación | Aprendiz, sesión, fecha/hora confiable, ENTRY/EXIT, resultado, estado, score, origen, creador y versión; anulación/excusa separadas. |
| Notificación y entrega | Evento, destinatario, tipo, prioridad, canal, lectura, intento, estado, fechas y deduplicación. |
| Preferencias y auditoría | Idioma, tema, notificaciones; actor, acción, entidad, anterior/nuevo, motivo y resultado sin secretos. |

Los nombres Chip, UserChip y RecordEnvironment del código corresponden a ficha, vínculo aprendiz-ficha y sesión del dominio. El UUID del usuario no es intercambiable con el UUID del aprendiz; toda conversión debe resolver y validar su relación. El esquema actual de referencia facial usa id_apprentice y embedding vector. Unificarlo con el enrolamiento Java es requisito de implementación, no una equivalencia ya existente.

## 5.3 Contratos observados y contratos requeridos

| Familia observada | Rutas principales | Condición de aceptación |
|---|---|---|
| Autenticación | /api/auth/login; request-recovery; verify-token; reset-password; change-password | Documento como acceso; recuperación por titular; revocación y bloqueo persistente. |
| Perfil y usuarios | /api/profile/me; configuration; /api/admin/users | Perfil propio; edición administrativa; documento inmutable y rol de registro diferenciado. |
| Académico | /api/academic/programs; chips; csv/template; csv/upload; pending-transfers | Integridad, alcance, transacciones y respuestas sin contraseñas. |
| Sesión | /api/environment/environments; instructors-for-session; chips-for-instructor; sessions | Elegibilidad y tiempos validados en servidor, no solo en selector. |
| Asistencia | /api/facial/events; from-image; attendance-status; attendance-matrix; excuse | Proteger operación/objeto; ruta automática exige verificación; respaldo manual separado. |
| Registro facial | /api/facial/challenge; enrollment; registration-status | Contrato Java/DB por unificar; no se considera integrado solo por existir endpoints. |
| Micro facial | /api/v1/facial-embeddings/from-image; verify-session; users/{id} | Identidad/alcance por operación; no exponer API key administrativa al cliente. |
| Notificaciones | /api/notifications; read; read-all; facial-request | Decisión facial durable; lectura independiente de autorización. |
| Tiempo real | /ws/realtime | Autenticación y revocación; cambios limitados al destinatario. |

Las rutas anteriores describen el inventario actual, no congelan un diseño incompatible. Se requieren contratos efectivos para logout/revocación, horarios/excepciones, parámetros versionados, respaldo manual, anulaciones y autorización de re-registro. Sus nombres finales se documentarán en el contrato API junto con versión, payload, respuestas y permisos. No se presentarán rutas propuestas como rutas ya desplegadas.

## 5.4 Errores y consistencia

- 400: entrada inválida; 401: autenticación ausente, vencida o inválida; 403: operación/recurso no autorizado.
- 404: recurso inexistente sin filtrar datos ajenos; 409: duplicado o conflicto concurrente; 410: reto/autorización consumidos o vencidos.
- Errores del servicio facial o correo no se convierten en reconocimiento aprobado ni en entrega exitosa.
- Respuestas deben incluir mensaje útil y referencia de operación, sin stack trace, claves, secretos, imágenes o vectores.
- Persistencia e idempotencia se validan antes de comunicar éxito; un reintento no duplica asistencia.

## 5.5 Formato institucional CSV

El encabezado establecido es: tipo,documento,nombre,apellido,correo,programa_codigo,ficha_codigo,instructor_tipo. El formato es UTF-8 con separador coma; se respetan comillas de campos CSV y se dejan vacías las columnas que no aplican. Se admite archivo parcial y se resuelven las dependencias independientemente del orden de filas.

| Tipo | Campos obligatorios | Regla adicional |
|---|---|---|
| programa | tipo, programa_codigo, nombre | Código identifica programa y nombre describe la formación. |
| ficha | tipo, ficha_codigo, programa_codigo | Programa existente o creado en la misma carga. |
| aprendiz | tipo, documento, nombre, apellido, correo, ficha_codigo | Ficha válida; cambio de ficha genera propuesta. |
| instructor específico | tipo, documento, nombre, apellido, correo, instructor_tipo, programa_codigo | Repetir documento para asociar más programas; ficha_codigo puede indicar asignación válida si el contrato la admite. |
| instructor transversal | tipo, documento, nombre, apellido, correo, instructor_tipo | Sin restricción a programa; código de programa innecesario se informa como advertencia. |

Ejemplo ilustrativo con datos ficticios. Los contactos de ejemplo no representan personas del proyecto.

```csv
tipo,documento,nombre,apellido,correo,programa_codigo,ficha_codigo,instructor_tipo
programa,,Análisis y Desarrollo de Software,,,ADSO,,
ficha,,,,,ADSO,2825551,
aprendiz,1002345678,Juan,Pérez,juan@example.com,,2825551,
instructor,1029384756,Laura,Gómez,laura@example.com,ADSO,,especifico
instructor,1050607080,Carlos,Ruiz,carlos@example.com,,,transversal
```

Documentos se validan como secuencias numéricas de 6 a 15 dígitos según el contrato actual y no se almacenan como números que pierdan ceros iniciales. Códigos y longitudes adicionales deben coincidir en plantilla, DTO, interfaz y restricciones de base. El correo es obligatorio para aprendiz/instructor y no habilita autenticación por email.

| Categoría del resumen | Información |
|---|---|
| Creados | Fila, tipo, identidad/código y resultado. |
| Actualizados | Fila, tipo, identidad/código y campos aplicados. |
| Inconsistencias bloqueadas | Fila, entidad, valor actual/propuesto y acción Ir a corregir. |
| Errores de referencia | Fila, dato faltante o inválido y explicación. |
| Traslados pendientes | Solicitud persistente ligada a carga/fila, origen/destino y estado. |

El resumen nunca incluirá contraseñas legibles. La resolución del conflicto se registra como operación propia vinculada a la carga original.

# 6 Requisitos funcionales

Las fichas siguientes definen el comportamiento requerido. El estado observado se registra para trazabilidad, sin sustituir los criterios de aceptación. Prioridad Alta indica dependencia de la integridad, acceso o flujo principal; Media indica función de apoyo que mantiene sus obligaciones de seguridad.

*6 Requisitos funcionales › Accesos al sistema*

## RF-1.1 Inicio de sesión

**Identificador** RF-1.1 | Prioridad Alta

**Actores** Aprendiz, Instructor, Coordinador y Coordinador de Registro

**Requisito** El sistema deberá autenticar mediante número de documento y contraseña, verificar el estado de la cuenta y emitir una sesión con el rol vigente. El correo se reservará para recuperación y comunicaciones.

**Precondiciones** Cuenta existente, activa, con credencial y rol asignados. Aviso de privacidad disponible.

**Entradas** Documento, contraseña y aceptación del aviso cuando corresponda.

**Secuencia normal**

1. El usuario ingresa documento y contraseña.
2. El servidor verifica credencial, estado y bloqueo; valida la aceptación requerida.
3. Obtiene rol y permisos desde su fuente autorizada y registra el acceso.
4. Emite el token y la interfaz abre la pantalla correspondiente.

**Escenarios alternativos**

- Credenciales incorrectas: responder sin revelar existencia de la cuenta y persistir el intento fallido.
- Cuenta inactiva, bloqueo, falta de rol o servicio no disponible: denegar acceso y ofrecer una acción recuperable.

**Postcondiciones** Sesión asociada a la identidad real, con emisión, expiración y evidencia de acceso.

**Criterios de aceptación**

- El documento identifica la cuenta; el correo no permite iniciar sesión.
- Un error no emite token ni privilegios; los intentos fallidos persisten aunque el acceso sea rechazado.
- El rol no se elige ni modifica desde el cliente.

**Relaciones** RF-1.2, RF-1.3, RF-1.4; RNF-1.1 a RNF-1.5, RNF-1.10 a RNF-1.16

**Estado observado** Parcial. Documento/contraseña, hash, privacidad y sesión implementados; H02/H03. API también admite email: confirmar alcance aprobado.

**Prueba vinculada** CP-RF-1.1 según sección 8

## RF-1.2 Derechos de acceso

**Identificador** RF-1.2 | Prioridad Alta

**Actores** Todos los roles y Sistema

**Requisito** El sistema deberá autorizar cada operación y cada recurso conforme a rol, permiso y relación con la información, tanto en interfaz como en servidor.

**Precondiciones** Sesión válida y matriz de permisos vigente.

**Entradas** Operación, recurso solicitado e identidad autenticada.

**Secuencia normal**

1. El usuario solicita una función o recurso.
2. El servidor verifica sesión, rol y permiso de operación.
3. Comprueba propiedad o relación vigente con aprendiz, ficha y sesión.
4. Devuelve solo los datos autorizados o ejecuta la operación y registra su resultado.

**Escenarios alternativos**

- Sin sesión: responder 401.
- Sesión válida sin permiso o recurso fuera de alcance: responder 403 y no efectuar cambios.

**Postcondiciones** Acceso limitado al ámbito autorizado, sin exposición de datos ajenos.

**Criterios de aceptación**

- Cambiar un UUID o una ruta no permite consultar otra ficha o usuario.
- La denegación funciona en solicitudes directas y no depende de ocultar botones.
- El aprendiz consulta solo su información; el instructor solo sus fichas o reemplazos autorizados.

**Relaciones** RNF-1.4, RNF-1.5, RNF-1.6, RNF-1.15, RNF-1.16, RNF-7.1

**Estado observado** Brecha. Autorización por objeto incompleta y rutas solo protegidas por autenticación; H01/H14.

**Prueba vinculada** CP-RF-1.2 según sección 8

## RF-1.3 Definición de rol al iniciar sesión

**Identificador** RF-1.3 | Prioridad Alta

**Actores** Sistema y usuarios autenticados

**Requisito** El sistema deberá determinar el rol y los permisos desde los registros de autorización y dirigir al usuario al área correspondiente.

**Precondiciones** Autenticación satisfactoria y asignación vigente.

**Entradas** Identidad validada y asignación de rol.

**Secuencia normal**

1. Consulta la asignación vigente.
2. Construye la sesión con permisos mínimos.
3. La interfaz carga el menú y las rutas habilitadas.
4. Un cambio posterior invalida o actualiza las sesiones anteriores.

**Escenarios alternativos**

- Rol inexistente o ambiguo: no habilitar operaciones hasta su regularización.
- Acceso a área de otro rol: denegar y regresar al área propia.

**Postcondiciones** Rol coherente en token, interfaz y servidor.

**Criterios de aceptación**

- El cliente no puede atribuirse un rol diferente.
- Los permisos anteriores no permanecen activos después de un cambio de rol.
- Coordinador de Registro tiene una asignación independiente y no hereda administración por su nombre.

**Relaciones** RF-3.3, RF-3.5; RNF-1.4, RNF-1.11, RNF-1.16

**Estado observado** Parcial. Rol desde servidor y redirección; discrepancias de roles/guards, H08/H14.

**Prueba vinculada** CP-RF-1.3 según sección 8

## RF-1.4 Restablecimiento de contraseña

**Identificador** RF-1.4 | Prioridad Alta

**Actores** Usuario y Sistema

**Requisito** El sistema deberá permitir recuperar una contraseña mediante verificación enviada al correo registrado y un código temporal asociado a la solicitud y al titular.

**Precondiciones** Cuenta habilitada y correo de recuperación registrado.

**Entradas** Correo, código de seis dígitos, nueva contraseña y confirmación.

**Secuencia normal**

1. El usuario solicita la recuperación con el correo registrado.
2. Se genera un código de seis dígitos con vencimiento de cinco minutos, se vincula a la solicitud y se envía al titular.
3. El usuario verifica el código y define una nueva contraseña conforme a la política.
4. El servidor actualiza el hash, consume el código, revoca sesiones anteriores y confirma.

**Escenarios alternativos**

- Código vencido, usado o incorrecto: rechazar y permitir solicitar otro sin reutilizar el anterior.
- Contraseña inválida, confirmación diferente o límite de intentos superado: conservar la credencial y aplicar la limitación.

**Postcondiciones** Nueva credencial segura; código y sesiones previas inutilizables.

**Criterios de aceptación**

- El código no puede usarse para otra cuenta ni para dos restablecimientos.
- Reenviar invalida el código anterior.
- La contraseña cumple RNF-1.2 y no aparece en respuestas o registros.

**Relaciones** RNF-1.2, RNF-1.8, RNF-1.9, RNF-1.10, RNF-1.11

**Estado observado** Parcial. Recuperación con código, expiración, uso único y política; falta prueba integrada y limitación de intentos de código.

**Prueba vinculada** CP-RF-1.4 según sección 8

*6 Requisitos funcionales › Gestión académica*

## RF-2.1 Carga institucional por archivo CSV

**Identificador** RF-2.1 | Prioridad Alta

**Actores** Coordinador y Sistema

**Requisito** El sistema deberá crear o actualizar programas, fichas, aprendices e instructores desde un CSV UTF-8, sin sobrescribir relaciones en conflicto ni exponer credenciales.

**Precondiciones** Coordinador autorizado; archivo .csv con encabezado válido.

**Entradas** Archivo y sus filas programa, ficha, aprendiz o instructor.

**Secuencia normal**

1. Valida archivo, codificación, encabezados y tipos.
2. Resuelve primero programas y fichas, después personas y relaciones, aunque el archivo use otro orden.
3. Crea o actualiza filas válidas; separa conflictos y referencias inexistentes.
4. Registra la carga y presenta resumen de creados, actualizados, inconsistencias y errores, con acceso al registro en conflicto.

**Escenarios alternativos**

- Archivo ilegible o encabezado inválido: rechazar sin cambios.
- Error de una fila: excluirla del conjunto aplicable; un fallo técnico antes del commit revierte todos los cambios de la carga.

**Postcondiciones** Cambios válidos confirmados juntos; resultados por fila y propuestas de traslado trazables.

**Criterios de aceptación**

- CSV parcial solo afecta las entidades indicadas.
- Un instructor específico puede acumular programas por documento; uno transversal no queda restringido a un programa.
- Una ficha diferente para un aprendiz genera propuesta, nunca traslado automático.
- Las cuentas nuevas reciben credencial segura; el resumen y sus exportaciones no contienen contraseñas.

**Relaciones** RF-2.1.1, RF-2.2, RF-2.3, RF-3.4; RNF-2.1 a RNF-2.14, RNF-3.3

**Estado observado** Parcial. CSV institucional, resumen y propuestas de traslado; contraseñas expuestas H06 y pruebas de carga/rollback pendientes.

**Prueba vinculada** CP-RF-2.1 según sección 8

## RF-2.1.1 Guía y plantilla del archivo CSV

**Identificador** RF-2.1.1 | Prioridad Media

**Actores** Coordinador

**Requisito** El sistema deberá mostrar ayuda de columnas y ofrecer una plantilla UTF-8 correcta antes de seleccionar el archivo.

**Precondiciones** Acceso autorizado a carga institucional.

**Entradas** Solicitud de ayuda o descarga.

**Secuencia normal**

1. Muestra significado, obligatoriedad y ejemplo de cada columna.
2. Entrega una plantilla con programa, ficha, aprendiz e instructores específico y transversal.
3. Explica encabezado, campos vacíos y posibilidad de carga parcial.
4. El usuario completa el archivo y continúa con RF-2.1.

**Escenarios alternativos**

- Fallo de descarga: informar y permitir reintento.
- Columnas no reconocidas o tipos inválidos: explicar corrección con lenguaje de la guía.

**Postcondiciones** Plantilla válida y reglas visibles; no cambia información académica.

**Criterios de aceptación**

- La ayuda aparece antes de cargar, no solo después de un error.
- Los ejemplos incluyen nombre de programa y referencias consistentes.
- Mensajes comprensibles sin términos internos de base de datos.

**Relaciones** RF-2.1; RNF-2.5, RNF-2.7, RNF-2.14

**Estado observado** Por probar. Endpoint de plantilla y descarga presentes; validar guía, encabezados y mensajes con usuarios.

**Prueba vinculada** CP-RF-2.1.1 según sección 8

## RF-2.2 Gestión académica manual

**Identificador** RF-2.2 | Prioridad Alta

**Actores** Coordinador

**Requisito** El sistema deberá crear, consultar, editar, desactivar, reactivar y eliminar entidades académicas según relaciones y preservación del historial.

**Precondiciones** Rol autorizado, catálogos disponibles y entidad identificada.

**Entradas** Datos de programa, ficha, aprendiz, instructor y relaciones.

**Secuencia normal**

1. El coordinador selecciona entidad y acción.
2. El sistema muestra datos y campos permitidos.
3. Valida unicidad, formato, estado y dependencias.
4. Confirma la operación, persiste atómicamente y registra actor y cambios.

**Escenarios alternativos**

- Duplicado o relación inválida: rechazar sin registros parciales.
- Eliminación con historial o dependencias: bloquear y ofrecer desactivación.

**Postcondiciones** Entidad coherente y cambio trazable; historial conservado.

**Criterios de aceptación**

- Toda ficha tiene programa y toda vinculación activa de aprendiz una ficha válida.
- Instructor específico tiene al menos un programa; transversal mantiene su alcance definido.
- Documento no editable; no se permite escribir una contraseña inicial.
- Reactivar vuelve a validar relaciones; eliminación física solo sin dependencias ni historial protegido.

**Relaciones** RF-2.3, RF-3.4; RNF-2.1 a RNF-2.4, RNF-2.8, RNF-2.9, RNF-3.4

**Estado observado** Parcial. CRUD académico y credenciales implementados; H06/H07 y aceptación de ciclo de vida pendiente.

**Prueba vinculada** CP-RF-2.2 según sección 8

## RF-2.3 Traslado de ficha de un aprendiz

**Identificador** RF-2.3 | Prioridad Alta

**Actores** Coordinador

**Requisito** El sistema deberá trasladar a un aprendiz entre fichas activas del mismo programa mediante una decisión explícita y una transacción indivisible.

**Precondiciones** Aprendiz con una ficha activa; destino activo y diferente, del mismo programa.

**Entradas** Aprendiz, destino y motivo de traslado.

**Secuencia normal**

1. Consulta ficha actual y destinos permitidos.
2. El coordinador selecciona destino y confirma motivo.
3. Desactiva origen y activa destino en una única transacción.
4. Registra valores anteriores y nuevos, comunica resultado y conserva historia.

**Escenarios alternativos**

- Destino inválido, misma ficha o programa diferente: rechazar.
- Fallo o traslado concurrente: revertir o resolver conflicto sin duplicar asignaciones activas.

**Postcondiciones** Una única ficha activa y traslado con actor, fecha y motivo.

**Criterios de aceptación**

- No queda sin ficha ni con dos activas al confirmar.
- Fallo durante el cambio restaura el origen.
- Propuestas CSV usan la misma operación al aceptarse y registran aceptación o cancelación.

**Relaciones** RF-2.1; RNF-2.3, RNF-2.9, RNF-2.10, RNF-2.11

**Estado observado** Por probar. Traslado transaccional, destino activo/mismo programa e historial; falta ensayo de fallo y concurrencia.

**Prueba vinculada** CP-RF-2.3 según sección 8

*6 Requisitos funcionales › Gestión de usuarios*

## RF-3.1 Panel de usuarios registrados

**Identificador** RF-3.1 | Prioridad Alta

**Actores** Coordinador

**Requisito** El sistema deberá ofrecer un listado filtrable de usuarios con identidad, rol y estado, limitado a los permisos del solicitante.

**Precondiciones** Sesión de coordinador válida.

**Entradas** Filtros por documento, nombre, apellido, correo, rol o estado.

**Secuencia normal**

1. Consulta el listado paginado.
2. Presenta documento, nombre, apellido, correo enmascarado, rol y estado.
3. Aplica filtros y muestra total coherente.
4. Permite abrir detalle o exportar exactamente el conjunto autorizado.

**Escenarios alternativos**

- Sin coincidencias: lista vacía y mensaje.
- API no disponible: error recuperable sin sustituir datos reales por datos de demostración.

**Postcondiciones** Listado autorizado sin cambios sobre cuentas.

**Criterios de aceptación**

- Cada columna corresponde a la cuenta real.
- Otro rol no obtiene la colección mediante la API.
- Filtros, detalle y exportación conservan el mismo alcance.

**Relaciones** RF-3.2; RNF-3.1, RNF-3.7

**Estado observado** Parcial. Listado/búsqueda real; validar filtros, estados, tiempos y paginación.

**Prueba vinculada** CP-RF-3.1 según sección 8

## RF-3.2 Consulta y gestión de usuarios

**Identificador** RF-3.2 | Prioridad Alta

**Actores** Coordinador

**Requisito** El sistema deberá buscar y gestionar cuentas mediante sus datos permitidos, preservando identidad y relaciones históricas.

**Precondiciones** Cuenta existente y autorización administrativa.

**Entradas** Criterio de búsqueda, cuenta y cambios permitidos.

**Secuencia normal**

1. Busca por nombre, apellido, documento o correo.
2. Abre detalle con estado y relaciones.
3. Edita campos permitidos o ejecuta un cambio de estado.
4. Valida, confirma y registra cada modificación.

**Escenarios alternativos**

- Cuenta inexistente, correo duplicado o intento de cambiar documento: rechazar.
- Eliminación con relaciones o afectación del último coordinador: bloquear.

**Postcondiciones** Información actualizada con auditoría, sin pérdida del historial.

**Criterios de aceptación**

- Documento permanece inmutable.
- Aprendiz e instructor no editan datos personales mediante solicitudes directas.
- Cambio de estado o rol afecta inmediatamente la autorización de sesiones.

**Relaciones** RF-3.5, RF-3.6; RNF-1.7, RNF-3.4, RNF-3.5, RNF-3.6

**Estado observado** Parcial. Gestión real; modificación de documento H07 y revocación H03.

**Prueba vinculada** CP-RF-3.2 según sección 8

## RF-3.3 Creación de usuarios de registro

**Identificador** RF-3.3 | Prioridad Alta

**Actores** Coordinador

**Requisito** El sistema deberá permitir al coordinador crear cuentas de Coordinador de Registro con datos mínimos y sin selector de otro rol. La identidad de ese rol debe implementarse por separado de COORDINATOR.

**Precondiciones** Coordinador autorizado y perfil de permisos del rol de registro establecido.

**Entradas** Documento, nombres, apellidos y correo del titular.

**Secuencia normal**

1. El coordinador abre el alta y diligencia identidad y contacto.
2. Valida formato y unicidad de documento y correo.
3. Crea cuenta y asigna automáticamente Coordinador de Registro.
4. Genera credencial segura y comunica al coordinador solo el resultado del alta.

**Escenarios alternativos**

- Duplicado o datos inválidos: no crear cuenta.
- Perfil de rol no disponible o fallo de credencial: no habilitar una cuenta incompleta.

**Postcondiciones** Cuenta con rol restringido y mecanismo seguro de primer acceso.

**Criterios de aceptación**

- La operación no permite crear aprendiz, instructor o coordinador pleno.
- Rol enviado manualmente distinto al permitido es rechazado.
- Contraseña no visible ni exportable por el coordinador.

**Relaciones** RF-3.4, RF-3.5; RNF-3.2, RNF-3.3

**Estado observado** Brecha. Crea COORDINATOR en vez del rol diferenciado exigido; H08.

**Prueba vinculada** CP-RF-3.3 según sección 8

## RF-3.4 Credencial inicial generada por el sistema

**Identificador** RF-3.4 | Prioridad Alta

**Actores** Sistema y titular de la cuenta

**Requisito** El sistema deberá generar una credencial inicial aleatoria que cumpla la política, almacenar solo su hash y entregarla o habilitarla únicamente mediante un canal seguro al titular.

**Precondiciones** Alta autorizada y contacto validado.

**Entradas** Cuenta nueva e información de entrega segura.

**Secuencia normal**

1. Genera un secreto aleatorio independiente del documento.
2. Guarda su hash y estado de primer acceso.
3. Habilita un mecanismo de activación o entrega protegida al titular.
4. Informa estado de entrega sin revelar el secreto en panel, resumen o CSV.

**Escenarios alternativos**

- Fallo de entrega: conserva estado pendiente y permite reintento autorizado.
- Fallo de creación: revierte el alta y evita credenciales huérfanas.

**Postcondiciones** Credencial asociada al titular sin exposición administrativa.

**Criterios de aceptación**

- Ningún endpoint, Excel, CSV o log devuelve la contraseña legible.
- Secreto cumple 8 a 15 caracteres, letras, número y símbolo.
- Preferir activación mediante enlace de un uso para evitar contraseñas en correo ordinario; mecanismo final registrado en DEC-02.

**Relaciones** RF-1.4; RNF-1.2, RNF-3.3, RNF-8.3

**Estado observado** Brecha. Generación y hash presentes; CSV expone contraseña H06.

**Prueba vinculada** CP-RF-3.4 según sección 8

## RF-3.5 Restricción de roles asignables

**Identificador** RF-3.5 | Prioridad Alta

**Actores** Coordinador y Sistema

**Requisito** El sistema deberá aplicar un conjunto explícito de roles asignables por operación. El alta administrativa RF-3.3 solo asignará Coordinador de Registro; las altas académicas asignarán Aprendiz o Instructor según entidad.

**Precondiciones** Actor y operación autorizados; rol destino vigente.

**Entradas** Cuenta, operación y rol previsto.

**Secuencia normal**

1. Identifica quién solicita la asignación.
2. Comprueba el rol permitido para ese flujo.
3. Valida relaciones necesarias y ausencia de privilegios incompatibles.
4. Registra asignación e invalida permisos previos de sesiones afectadas.

**Escenarios alternativos**

- Rol no permitido o intento de escalación: rechazar 403.
- Cambio que deje sin coordinador activo: bloquear.

**Postcondiciones** Asignación única y auditable, coherente con el tipo de cuenta.

**Criterios de aceptación**

- Alterar el cuerpo de una solicitud no amplía el rol.
- El rol de registro no recibe permisos de administración por defecto.
- Una modificación legítima no deja vigentes permisos anteriores.

**Relaciones** RF-1.3, RF-2.2, RF-3.3; RNF-1.16, RNF-3.6

**Estado observado** Brecha. No existe Coordinador de Registro en backend; H08.

**Prueba vinculada** CP-RF-3.5 según sección 8

## RF-3.6 Estado del usuario

**Identificador** RF-3.6 | Prioridad Alta

**Actores** Coordinador

**Requisito** El sistema deberá activar, desactivar o bloquear cuentas preservando historial y relaciones. La eliminación física se admitirá solo cuando no afecte información protegida.

**Precondiciones** Cuenta existente; actor autorizado; al menos un coordinador activo al terminar.

**Entradas** Cuenta, nuevo estado, motivo y confirmación.

**Secuencia normal**

1. Consulta estado y dependencias.
2. El coordinador elige acción y motivo.
3. Valida transición y conservación del último coordinador.
4. Guarda estado, revoca sesiones cuando aplique y notifica sin borrar historia.

**Escenarios alternativos**

- Transición inválida o último coordinador: rechazar.
- Cancelación del usuario: conservar estado previo.

**Postcondiciones** Cuenta con estado coherente; historia disponible para reportes.

**Criterios de aceptación**

- Cuenta desactivada pierde acceso en menos de cinco segundos.
- Token previo no permite seguir operando.
- Registros históricos no se eliminan por desactivación.

**Relaciones** RNF-1.11, RNF-3.5, RNF-3.6

**Estado observado** Parcial. Desactivación preserva entidades; token previo sigue válido H03.

**Prueba vinculada** CP-RF-3.6 según sección 8

*6 Requisitos funcionales › Perfil y preferencias*

## RF-4.1 Consulta del perfil propio

**Identificador** RF-4.1 | Prioridad Media

**Actores** Todos los usuarios

**Requisito** El sistema deberá presentar el perfil del usuario autenticado con identidad, rol, vínculos académicos pertinentes y correo enmascarado.

**Precondiciones** Sesión válida.

**Entradas** Identidad tomada de la sesión; no de un UUID libre del cliente.

**Secuencia normal**

1. El usuario abre Mi perfil.
2. El servidor consulta solo su perfil.
3. La interfaz muestra datos actuales y relaciones relevantes al rol.
4. Ofrece preferencias y recuperación o cambio seguro de contraseña.

**Escenarios alternativos**

- Sesión vencida: cerrar acceso y volver al login.
- Fallo de consulta: informar y permitir reintento sin revelar otro perfil.

**Postcondiciones** Perfil propio consultado, sin modificación de datos personales.

**Criterios de aceptación**

- Cambiar parámetros no muestra un perfil ajeno.
- Correo se muestra enmascarado.
- Aprendiz e instructor ven identidad en solo lectura.

**Relaciones** RF-4.2; RNF-4.1, RNF-4.2, RNF-4.5

**Estado observado** Parcial. Perfil propio conectado; máscara ausente H12 y tiempos por probar.

**Prueba vinculada** CP-RF-4.1 según sección 8

## RF-4.2 Configuración de preferencias personales

**Identificador** RF-4.2 | Prioridad Media

**Actores** Todos los usuarios

**Requisito** El sistema deberá guardar idioma, tema y activación de notificaciones por usuario y restaurarlos en nuevas sesiones y dispositivos.

**Precondiciones** Perfil autenticado con contrato de preferencias vigente.

**Entradas** Idioma ES, EN, DE o FR; tema claro u oscuro; notificaciones activas o inactivas.

**Secuencia normal**

1. Carga preferencias actuales o valores por defecto.
2. El usuario modifica las opciones.
3. Valida catálogo y guarda en servidor.
4. Aplica y confirma; en otro inicio restaura los valores guardados.

**Escenarios alternativos**

- Idioma no soportado: rechazar sin sustituir silenciosamente.
- Fallo de guardado: mostrar estado sin guardar y permitir reintento.

**Postcondiciones** Preferencias del titular persistidas sin afectar las de otros usuarios.

**Criterios de aceptación**

- Los cuatro idiomas tienen el mismo catálogo en cliente, API y base.
- Desactivar notificaciones se conserva y no se fuerza a true.
- Seguridad y recuperación siguen sus canales obligatorios según política, aun con preferencias informativas desactivadas.

**Relaciones** RF-C3; RNF-4.1, RNF-4.5

**Estado observado** Brecha. Preferencias conectadas; DE incompatible y notificaciones forzadas H14.

**Prueba vinculada** CP-RF-4.2 según sección 8

*6 Requisitos funcionales › Reconocimiento facial*

## RF-5.1 Registro facial inicial del aprendiz

**Identificador** RF-5.1 | Prioridad Alta

**Actores** Aprendiz, Sistema y servicio facial

**Requisito** El sistema deberá registrar la referencia biométrica del aprendiz autenticado con consentimiento, validación de vida y al menos tres capturas desde ángulos distintos.

**Precondiciones** Cuenta de aprendiz activa, identidad confirmada, cámara autorizada y ausencia de referencia activa o autorización RF-5.4.

**Entradas** Capturas temporales, reto del servidor, evidencia de calidad/vida e identidad autenticada.

**Secuencia normal**

1. Confirma identidad y presenta finalidad/consentimiento.
2. Servidor inicia un reto temporal asociado al titular.
3. Guía centro, izquierda y derecha; verifica un rostro, calidad, variación y vida.
4. Consolida el descriptor con modelo y versión compatibles, lo protege y persiste para el aprendiz; descarta imágenes.

**Escenarios alternativos**

- Rostro múltiple, evidencia insuficiente, reto vencido/reutilizado o mala calidad: rechazar sin registro parcial.
- Servicio no disponible o autorización ausente: permitir reintento seguro, sin aprobación local simulada.

**Postcondiciones** Referencia biométrica activa única, vinculada al aprendiz y trazable.

**Criterios de aceptación**

- No se completa con menos de tres ángulos válidos; máximo 60 s en condiciones normales.
- El usuario no puede registrar el rostro de otro UUID.
- Modelo, dimensiones y contrato coinciden en cliente, servidor y DB; no se guarda foto original.

**Relaciones** RF-5.4; RNF-5.1 a RNF-5.6

**Estado observado** Brecha. Registro por microservicio existe; contrato Java/DB y autorización desalineados H04/H05.

**Prueba vinculada** CP-RF-5.1 según sección 8

## RF-5.2 Preparación de sesión de reconocimiento

**Identificador** RF-5.2 | Prioridad Alta

**Actores** Instructor; Coordinador según permiso explícito

**Requisito** El sistema deberá preparar una sesión facial con ambiente, ficha, dispositivo e instructor válidos, conservando original y reemplazo cuando corresponda.

**Precondiciones** Ficha y ambiente activos; instructor asignado o reemplazo autorizado; horario aplicable.

**Entradas** Ambiente, ficha, instructor programado, responsable y dispositivo.

**Secuencia normal**

1. Consulta opciones elegibles desde el servidor.
2. El instructor confirma datos y eventual reemplazo.
3. Verifica relaciones, horario, excepciones y disponibilidad del dispositivo.
4. Guarda sesión y presenta resumen para definir tiempos en RF-6.2.

**Escenarios alternativos**

- Relación fuera de alcance, horario conflictivo o datos faltantes: rechazar.
- Sesión duplicada o dispositivo ocupado: devolver conflicto sin duplicación.

**Postcondiciones** Sesión configurada con autor y responsables diferenciados.

**Criterios de aceptación**

- Campos obligatorios completos.
- Una llamada directa no permite elegir ficha no elegible.
- Reemplazo conserva instructor programado, responsable real, autorización y fecha.

**Relaciones** RF-6.1, RF-6.2, RF-C1, RF-C2; RNF-1.5, RNF-6.1

**Estado observado** Parcial. Sesión persistida, instructor original/reemplazo; validaciones incompletas H09.

**Prueba vinculada** CP-RF-5.2 según sección 8

## RF-5.3 Administración de parámetros faciales

**Identificador** RF-5.3 | Prioridad Alta

**Actores** Coordinador; Instructor para ajustes expresamente delegados

**Requisito** El sistema deberá administrar parámetros globales y de sesión, con versión, alcance y fecha de aplicación, sin alterar silenciosamente eventos históricos.

**Precondiciones** Permiso específico; catálogo de rangos y versión vigente.

**Entradas** Umbral facial, tolerancia y demás parámetros autorizados.

**Secuencia normal**

1. Consulta valor vigente, versión y alcance.
2. El actor cambia parámetros permitidos e indica motivo.
3. Servidor valida rangos y genera nueva versión.
4. Aplica a las identificaciones posteriores y conserva versión de cada evento.

**Escenarios alternativos**

- Valor fuera de rango o cambio global no autorizado: rechazar.
- Cambio retroactivo: requerir recálculo explícito y auditado, sin sobrescribir hechos originales.

**Postcondiciones** Configuración versionada y uso verificable por fecha de evento.

**Criterios de aceptación**

- Umbral por defecto 0.6 y rango inclusivo 0.4 a 0.9.
- Tolerancia entre 0 y 30 minutos, compatible con la sesión.
- Cambio se aplica sin reinicio y deja actor, anterior/nuevo, motivo y vigencia.

**Relaciones** RF-6.2; RNF-5.5, RNF-6.2, RNF-6.4

**Estado observado** Brecha. No hay configuración institucional versionada del umbral; default efectivo 0.65, rango 0..1.

**Prueba vinculada** CP-RF-5.3 según sección 8

## RF-5.4 Resolución de solicitud de registro facial

**Identificador** RF-5.4 | Prioridad Alta

**Actores** Aprendiz solicitante y Coordinador resolutor

**Requisito** El sistema deberá permitir un nuevo registro facial mediante solicitud persistente y autorización temporal de un único uso, concedida por un coordinador autorizado.

**Precondiciones** Referencia facial previa y solicitud del propio aprendiz.

**Entradas** Solicitud, decisión, motivo y plazo de autorización.

**Secuencia normal**

1. El aprendiz crea solicitud; el servidor evita duplicados y notifica.
2. El coordinador consulta solicitudes de su alcance.
3. Acepta o rechaza; servidor persiste decisión, actor y fecha.
4. Si acepta, habilita el reto de re-registro y consume autorización solo al completarlo.

**Escenarios alternativos**

- Solicitud ya resuelta o actor no autorizado: rechazar.
- Fallo de notificación: conservar decisión y estado de entrega; no perder autorización.

**Postcondiciones** Decisión trazable y referencia anterior preservada hasta completar reemplazo válido.

**Criterios de aceptación**

- No se habilita cámara de re-registro antes de aceptación.
- Dos resoluciones o registros concurrentes no consumen la autorización dos veces.
- Rechazo permite solicitar otra vez salvo política explícita; vencimiento no modifica la referencia activa.

**Relaciones** RF-5.1, RF-8.4; RNF-1.8, RNF-5.4

**Estado observado** Brecha. Solicitud local/decisión sin autorización durable H10.

**Prueba vinculada** CP-RF-5.4 según sección 8

*6 Requisitos funcionales › Configuración de asistencia*

## RF-6.1 Configuración de asistencia facial

**Identificador** RF-6.1 | Prioridad Alta

**Actores** Instructor

**Requisito** El sistema deberá iniciar una sesión de asistencia a partir de la configuración RF-5.2 y vincular cada reconocimiento con su sesión, ficha y dispositivo.

**Precondiciones** Sesión preparada y tiempos válidos; fichas y responsables activos.

**Entradas** Identificador de sesión y configuración de reconocimiento.

**Secuencia normal**

1. Consulta el resumen de ambiente, ficha y responsables.
2. El servidor vuelve a validar elegibilidad y disponibilidad.
3. Activa la sesión y vincula el dispositivo.
4. La captura identifica aprendices de esa ficha y deriva la asistencia en servidor.

**Escenarios alternativos**

- Sesión cerrada o fuera de horario: no registrar entrada.
- Dispositivo diferente o ficha fuera de alcance: rechazar.

**Postcondiciones** Sesión activa disponible para entrada y salida de asistencia.

**Criterios de aceptación**

- Original y reemplazo son consultables en la sesión.
- No hay aprobación facial basada solo en parámetros enviados por cliente.
- Cada evento incluye aprendiz, sesión, ambiente, dispositivo y hora confiable.

**Relaciones** RF-5.2, RF-6.2; RNF-6.1, RNF-6.2, RNF-6.3

**Estado observado** Parcial. Configuración y captura conectadas; horario/asignación y contrato de reemplazo por completar H09.

**Prueba vinculada** CP-RF-6.1 según sección 8

## RF-6.2 Ajustes de registro, salida y apagado

**Identificador** RF-6.2 | Prioridad Alta

**Actores** Instructor autorizado y Sistema

**Requisito** El sistema deberá validar y aplicar entrada, ventana de puntualidad, salida y cierre de la sesión, incluyendo la segunda captura de salida.

**Precondiciones** Sesión preparada o activa sin cambio incompatible con eventos previos.

**Entradas** Hora de entrada, minutos de registro, hora de salida y hora de apagado.

**Secuencia normal**

1. Presenta valores vigentes.
2. El actor define tiempos y confirma.
3. Servidor exige 0 a 30 minutos; salida posterior al fin de ventana y apagado posterior a salida.
4. Clasifica entradas y habilita verificación de salida entre salida y apagado; cierra el punto al finalizar.

**Escenarios alternativos**

- Orden temporal inválido: conserva configuración anterior.
- Cambio con eventos históricos: versionar o restringir según autorización y registrar motivo.

**Postcondiciones** Tiempos persistidos, reglas uniformes y sesión cerrada al apagado.

**Criterios de aceptación**

- Entrada a las 06:00 y ventana de 5 minutos: hasta 06:05 inclusive es puntual.
- Después del límite y antes de salida es retardo; desde salida hasta antes de apagado es evento de salida.
- No se acepta salida anterior o igual al límite de puntualidad; una salida sin entrada no acredita puntualidad.

**Relaciones** RF-5.3, RF-6.1; RNF-6.1, RNF-6.2

**Estado observado** Parcial. Tiempos persistidos, entrada/salida y clasificación; orden de ventana incompleto H09.

**Prueba vinculada** CP-RF-6.2 según sección 8

*6 Requisitos funcionales › Consulta e historial*

## RF-7.1 Consulta de asistencia por ficha

**Identificador** RF-7.1 | Prioridad Alta

**Actores** Coordinador e Instructor autorizado

**Requisito** El sistema deberá mostrar tarjetas por programa con inasistencias y retardos del día, y una matriz de aprendices por fecha con datos reales de asistencia.

**Precondiciones** Usuario con alcance sobre ficha; sesiones y vinculaciones académicas disponibles.

**Entradas** Programa, ficha y rango de fechas.

**Secuencia normal**

1. Consulta programas/fichas autorizados y tarjetas con porcentajes de fallas y retardos.
2. Selecciona ficha y rango.
3. Obtiene matriz del servidor con estados y categorías sin clase/sin registro.
4. Abre detalle de cualquier celda y exporta el mismo conjunto filtrado.

**Escenarios alternativos**

- Sin fichas, aprendices o eventos: informar el caso específico.
- Rango inválido o ficha fuera de alcance: rechazar sin exponer datos.

**Postcondiciones** Consulta consistente con eventos persistidos y exportación identificada.

**Criterios de aceptación**

- Verde puntual, amarillo retardo y rojo ausencia, con iconos/texto además del color.
- Cualquier celda muestra hora, día, ambiente y responsable cuando existe evento.
- Archivo identifica programa y ficha e incluye las tres categorías.
- Distingue una ausencia de un día sin clase; no inventa eventos por falta de horario.

**Relaciones** RF-7.2, RF-9.1; RNF-7.1 a RNF-7.5

**Estado observado** Parcial. Matriz y consultas por ficha reales; autorización H01 y aceptación visual/exportación por probar.

**Prueba vinculada** CP-RF-7.1 según sección 8

## RF-7.2 Consulta de asistencia individual

**Identificador** RF-7.2 | Prioridad Alta

**Actores** Aprendiz propio, Instructor asignado y Coordinador

**Requisito** El sistema deberá consultar la asistencia de un aprendiz por documento o nombre según el alcance del usuario, aplicando las mismas reglas de la consulta por ficha.

**Precondiciones** Permiso sobre el aprendiz y rango válido.

**Entradas** Aprendiz y fechas; para aprendiz, identidad tomada de sesión.

**Secuencia normal**

1. Busca aprendices autorizados o selecciona Mi asistencia.
2. Solicita registros del periodo al servidor.
3. Muestra estados, detalle, responsables y evidencia de salida.
4. Permite exportar el conjunto autorizado con filtros y titular identificados.

**Escenarios alternativos**

- Aprendiz ajeno o no asignado: rechazar 403.
- Sin eventos: mostrar vacío; distinguir días sin clase.

**Postcondiciones** Consulta individual sin cambios en registros.

**Criterios de aceptación**

- El aprendiz no obtiene registros de otro titular aunque cambie el UUID.
- Instructor solo consulta asignación o reemplazo autorizado.
- Detalle y estados coinciden con RF-7.1 para los mismos eventos.

**Relaciones** RF-7.1, RF-9.1; RNF-7.1, RNF-7.2, RNF-7.3

**Estado observado** Parcial. Matriz usada en consulta individual; búsqueda/alcance deben verificarse, H01.

**Prueba vinculada** CP-RF-7.2 según sección 8

## RF-7.3 Historial de asistencia

**Identificador** RF-7.3 | Prioridad Alta

**Actores** Todos los usuarios según alcance

**Requisito** El sistema deberá ofrecer un historial de tarjetas agrupadas por ficha y fecha, alimentado por la misma fuente persistente que las consultas y reportes.

**Precondiciones** Sesión válida y permisos de consulta.

**Entradas** Filtros de aprendiz, ficha, periodo y estado.

**Secuencia normal**

1. Solicita historial paginado y ordenado del más reciente al más antiguo.
2. Agrupa por ficha/fecha y muestra estado y tipo de registro.
3. Abre el detalle con hora, ambiente, instructor y entrada/salida.
4. Conserva filtros al navegar y actualiza ante cambios autorizados.

**Escenarios alternativos**

- Sin resultados: mostrar mensaje.
- Fallo de API: informar; caché permitida se identifica con fecha de sincronización, sin datos de demostración.

**Postcondiciones** Historia fiel, filtrada y consultable.

**Criterios de aceptación**

- Un evento real aparece en tabla, historial y reporte con los mismos valores.
- Desactivación o traslado de aprendiz no borra historia ni cambia su ficha histórica.
- La paginación no omite ni duplica eventos.

**Relaciones** RF-7.1, RF-7.2; RNF-3.6, RNF-6.3, RNF-7.2

**Estado observado** Brecha. Historial usa fuente local de asistencia H11.

**Prueba vinculada** CP-RF-7.3 según sección 8

*6 Requisitos funcionales › Notificaciones*

## RF-8.1 Generación automática de notificaciones

**Identificador** RF-8.1 | Prioridad Alta

**Actores** Sistema y destinatarios por evento

**Requisito** El sistema deberá generar notificaciones del catálogo de eventos y determinar destinatarios por relación académica y permiso.

**Precondiciones** Evento válido confirmado y catálogo de tipos/canales.

**Entradas** Tipo de evento, entidad, actor y datos mínimos de contexto.

**Secuencia normal**

1. Detecta evento de acceso, gestión, asistencia, sesión o solicitud.
2. Determina destinatarios y canal permitido.
3. Persiste la notificación con identidad del evento y evita duplicados.
4. Actualiza bandeja y programa entrega de correo/push según reglas.

**Escenarios alternativos**

- Fallo de entrega: conservar notificación y estado para reintento.
- Evento no confirmado: no comunicar como éxito.

**Postcondiciones** Notificación persistida y asociada a evento y destinatario.

**Criterios de aceptación**

- Incluye tipo, mensaje, fecha/hora, prioridad y referencia suficiente.
- Destinatarios no dependen de IDs arbitrarios enviados por otro rol.
- Un reintento del mismo evento no crea notificaciones duplicadas.

**Relaciones** RF-8.2, RF-8.3, RF-8.4; RNF-8.1 a RNF-8.4

**Estado observado** Parcial. Catálogo/eventos persistidos; cobertura completa y deduplicación por probar H13.

**Prueba vinculada** CP-RF-8.1 según sección 8

## RF-8.2 Visualización de notificaciones

**Identificador** RF-8.2 | Prioridad Media

**Actores** Todos los usuarios

**Requisito** El sistema deberá mostrar la bandeja del usuario autenticado, con estado de lectura, filtros y navegación al recurso autorizado.

**Precondiciones** Sesión válida; notificaciones propias o caché protegida propia.

**Entradas** Filtro de categoría/lectura y página.

**Secuencia normal**

1. Sincroniza notificaciones propias.
2. Ordena por fecha descendente y muestra no leídas.
3. Permite abrir detalle, marcar lectura y navegar al recurso con nueva comprobación de permiso.
4. Actualiza contador y conserva caché durable de las últimas 50.

**Escenarios alternativos**

- Offline: muestra caché propia y fecha de sincronización.
- Notificación ajena: rechazar consulta o modificación.

**Postcondiciones** Estado de lectura persistido y contador coherente.

**Criterios de aceptación**

- Solo destinatario modifica lectura.
- Notificaciones de más de 30 días se depuran según RNF-8.2.
- Bandeja carga en menos de 1.5 s y contador se sincroniza en tiempo real.

**Relaciones** RNF-8.2, RF-C4

**Estado observado** Parcial. Bandeja por destinatario/lectura conectadas; caché/retención pendientes H13.

**Prueba vinculada** CP-RF-8.2 según sección 8

## RF-8.3 Envío de notificaciones por correo

**Identificador** RF-8.3 | Prioridad Alta

**Actores** Sistema y destinatario

**Requisito** El sistema deberá enviar notificaciones de canal correo con límite horario, estado de entrega y reintentos, sin incluir contraseñas ni datos biométricos.

**Precondiciones** Notificación persistida, correo del titular y canal permitido.

**Entradas** Notificación, destinatario y estado de envío.

**Secuencia normal**

1. Verifica límite de cinco correos por hora y usuario.
2. Encola o envía después de confirmar el evento.
3. Registra intento y resultado sin duplicar entregas exitosas.
4. Reprograma pendientes o fallidas conservando disponibilidad en bandeja.

**Escenarios alternativos**

- Sexto correo en la hora: encolar para la siguiente ventana.
- SMTP no disponible: marcar fallo/pending y reintentar de forma controlada.

**Postcondiciones** Estado consultable de entrega y mensaje disponible en bandeja.

**Criterios de aceptación**

- Entrega inicial en menos de 5 s en condiciones normales.
- Nunca supera cinco correos por hora por usuario.
- No expone contraseña, vector, imágenes o información ajena.

**Relaciones** RF-8.1; RNF-8.3, RNF-8.4

**Estado observado** Parcial. Correo, estados y reintentos presentes; tiempo y límite horario pendientes H13.

**Prueba vinculada** CP-RF-8.3 según sección 8

## RF-8.4 Notificación de solicitud de registro facial

**Identificador** RF-8.4 | Prioridad Alta

**Actores** Aprendiz y Coordinador

**Requisito** El sistema deberá notificar una solicitud de re-registro y su decisión usando la solicitud persistente RF-5.4.

**Precondiciones** Solicitud creada por su titular y resolutor autorizado.

**Entradas** Solicitud y decisión aceptada/rechazada.

**Secuencia normal**

1. Genera aviso a coordinadores autorizados con referencia a solicitud.
2. Muestra acciones de resolución si sigue pendiente.
3. Guarda decisión mediante RF-5.4.
4. Notifica al aprendiz aceptación, rechazo o vencimiento de autorización.

**Escenarios alternativos**

- Solicitud ya resuelta: no repetir decisión.
- Fallo de envío: mantener solicitud/decisión y reintentar comunicación.

**Postcondiciones** Ambos actores conocen el estado real y la autorización aplicable.

**Criterios de aceptación**

- Aviso creado en servidor y disponible en otro dispositivo.
- Marcar lectura no equivale a aprobar solicitud.
- La autorización solo habilita al titular y se consume una vez.

**Relaciones** RF-5.4; RNF-8.1, RNF-8.2

**Estado observado** Brecha. Solicitud del aprendiz solo local; resolución incompleta H10.

**Prueba vinculada** CP-RF-8.4 según sección 8

*6 Requisitos funcionales › Reportes y consultas*

## RF-9.1 Reportes y consultas por rol

**Identificador** RF-9.1 | Prioridad Alta

**Actores** Aprendiz, Instructor y Coordinador

**Requisito** El sistema deberá generar reportes de asistencia por usuario, ficha, calendario y desempeño desde eventos persistidos, con filtros y exportación coherentes.

**Precondiciones** Permiso de consulta y datos de sesiones/horarios.

**Entradas** Tipo de reporte, sujeto, fechas y formato XLSX/CSV.

**Secuencia normal**

1. Selecciona reporte y filtros permitidos.
2. Servidor calcula estados y métricas con denominadores definidos.
3. Presenta tabla/calendario, detalle y alertas de riesgo.
4. Exporta exactamente los datos filtrados, identificando sujeto, periodo y fecha de generación.

**Escenarios alternativos**

- Sin clases/eventos: informar sin fabricar porcentajes.
- Fuera de alcance o periodo inválido: denegar.

**Postcondiciones** Reporte reproducible consistente con RF-7.

**Criterios de aceptación**

- Aprendiz solo ve sus datos; instructor sus fichas; coordinador el ámbito administrativo.
- No usa eventos mock para reportes operativos.
- XLSX coincide con filtros y permisos; muestra registros manuales/anulados y excusas sin ocultar su trazabilidad.
- Asistencia inferior al 80% se señala con icono/texto y color; umbral configurable por coordinador.

**Relaciones** RF-7.1 a RF-7.3; RNF-7.1 a RNF-7.5

**Estado observado** Brecha. Pantallas y exportación presentes, pero reportes usan fuente local H11.

**Prueba vinculada** CP-RF-9.1 según sección 8

*6 Requisitos funcionales › Requisitos complementarios*

## RF-C1 Horarios y excepciones

**Identificador** RF-C1 | Prioridad Alta

**Actores** Coordinador; Instructor con permiso de consulta o delegación

**Requisito** El sistema deberá gestionar horarios persistentes y excepciones de cancelación, reprogramación y sustitución, y aplicarlos a sesiones, asistencia y reportes.

**Precondiciones** Catálogos activos y permiso de operación.

**Entradas** Ficha, ambiente, instructor, día, franjas, vigencia y excepción con motivo.

**Secuencia normal**

1. Consulta calendario de horarios vigentes.
2. Crea o modifica horario y verifica solapamientos de ambiente/instructor.
3. Registra excepción con original, nuevo valor, actor y motivo.
4. La preparación de sesión y cálculo de asistencia usan la versión aplicable a la fecha.

**Escenarios alternativos**

- Solapamiento o referencias inactivas: rechazar.
- Excepción que altera eventos existentes: preservar hechos y requerir ajuste auditado.

**Postcondiciones** Horarios/excepciones durables sin pérdida histórica.

**Criterios de aceptación**

- Reinicio y otro dispositivo muestran lo guardado.
- Sesión cancelada no produce ausencia automática.
- Conflictos se validan también en servidor.

**Relaciones** RF-5.2, RF-6.2; RNF-6.2

**Estado observado** Parcial. Pantallas/lógica local y mocks; sin API persistente encontrada para horarios/excepciones.

**Prueba vinculada** CP-RF-C1 según sección 8

## RF-C2 Ambientes, dispositivos y sesiones

**Identificador** RF-C2 | Prioridad Media

**Actores** Coordinador e Instructor según operación

**Requisito** El sistema deberá mantener un catálogo de ambientes/dispositivos y su asociación a sesiones, con estado y disponibilidad verificables.

**Precondiciones** Actor autorizado y relaciones académicas existentes.

**Entradas** Nombre/código, capacidad, estado, dispositivo y sesión.

**Secuencia normal**

1. Consulta catálogo autorizado.
2. Registra o edita datos y valida unicidad/capacidad.
3. Asocia dispositivo al ambiente y sesión sin asignación simultánea incompatible.
4. Desactiva cuando corresponda preservando referencias históricas.

**Escenarios alternativos**

- Ambiente ocupado, capacidad inválida o dependencia activa: rechazar operación incompatible.
- Dispositivo no confiable: no aceptar datos como reconocimiento automático.

**Postcondiciones** Catálogo coherente y dispositivo trazable en eventos.

**Criterios de aceptación**

- No usa catálogos mock en operación.
- Eliminar ambiente con historia o sesión activa no se permite.
- Gestión de catálogo y apertura de sesión tienen permisos separados.

**Relaciones** RF-5.2, RF-6.1; RNF-6.1

**Estado observado** Parcial. Sesiones reales y parte del catálogo conectadas; CRUD local restante y validaciones H09.

**Prueba vinculada** CP-RF-C2 según sección 8

## RF-C3 Persistencia de preferencias entre sesiones

**Identificador** RF-C3 | Prioridad Media

**Actores** Todos los usuarios

**Requisito** El sistema deberá restaurar y sincronizar las preferencias RF-4.2 entre inicios y dispositivos sin sobrescribir las de otros titulares.

**Precondiciones** Sesión y configuración del titular.

**Entradas** Preferencias y versión guardada.

**Secuencia normal**

1. Carga configuración al autenticar.
2. Aplica idioma, tema y notificaciones.
3. Guarda cambios del titular con confirmación.
4. En otra sesión recupera la configuración vigente.

**Escenarios alternativos**

- Fallo de sincronización: informar estado pendiente y conservar último valor confirmado.
- Actualización concurrente: resolver conflicto mediante versión o regla explícita.

**Postcondiciones** Preferencias reproducibles y propias.

**Criterios de aceptación**

- ES/EN/DE/FR coinciden en todas las capas.
- Una preferencia informativa no modifica permisos o mensajes obligatorios de seguridad.
- Desactivación de notificaciones se conserva.

**Relaciones** RF-4.2; RNF-4.1

**Estado observado** Brecha. Backend conectado; alemán y activación de notificaciones H14.

**Prueba vinculada** CP-RF-C3 según sección 8

## RF-C4 Sincronización en tiempo real

**Identificador** RF-C4 | Prioridad Media

**Actores** Usuarios autenticados y Sistema

**Requisito** El sistema deberá comunicar cambios relevantes a sesiones autorizadas y permitir recuperación de sincronización después de una desconexión.

**Precondiciones** Token vigente, canal protegido y alcance del destinatario.

**Entradas** Autenticación de canal y eventos de cambio.

**Secuencia normal**

1. Autentica el canal antes de entregar información.
2. Valida identidad/alcance en cada emisión relevante.
3. Notifica cambios y el cliente vuelve a consultar datos autorizados.
4. Reconecta con espera creciente hasta 30 s y recupera cambios pendientes.

**Escenarios alternativos**

- Token inválido, revocado o vencido: cerrar canal.
- Conexión perdida: conservar estado confirmado y sincronizar al recuperar.

**Postcondiciones** Interfaz actualizada sin filtrar datos entre roles o usuarios.

**Criterios de aceptación**

- No emite datos ajenos por compartir conexión o tipo de evento.
- Logout o desactivación invalida también el canal abierto.
- Reconexión no duplica asistencia ni notificaciones.

**Relaciones** RNF-1.11, RNF-1.16, RNF-8.2

**Estado observado** Por probar. WebSocket cliente/servidor presente; alcance, cambios, reconexión y revocación H03 pendientes.

**Prueba vinculada** CP-RF-C4 según sección 8

# 7 Requisitos no funcionales

Los RNF conservan su numeración y objetivos. Los criterios medibles se verifican en un entorno representativo; no se declaran satisfechos por compilar o encontrar una biblioteca. Se distingue el rendimiento de extracción facial del tiempo de persistencia posterior a la identificación.

## 7.1 Accesos y seguridad

### RNF-1.1 Seguridad de autenticación

**Requisito** El sistema debe proteger el proceso de autenticación mediante mecanismos seguros de validación de credenciales.

**Control** - El inicio de sesión debe realizarse mediante número de documento y contraseña. - El número de documento no debe utilizarse como contraseña ni almacenarse como credencial secreta. - Las contraseñas deben almacenarse utilizando algoritmos de hashing seguros. - El sistema nunca debe almacenar ni mostrar contraseñas en texto plano. - Las credenciales no deben enviarse mediante conexiones no seguras. - Las comunicaciones entre frontend y backend deben realizarse mediante HTTPS/TLS en ambientes de producción. - Los mensajes de error no deben revelar información sensible de la cuenta.

**Aceptación** Las credenciales del usuario deben transmitirse y almacenarse de forma segura, sin exponer la contraseña original.

**Estado observado** Parcial. BCrypt/JWT presentes; transporte productivo sin verificar.

**Prueba** CP-RNF-1.1

### RNF-1.2 Política de contraseñas

**Requisito** El sistema debe aplicar una política mínima de seguridad para las contraseñas.

**Control** La contraseña debe: - Tener entre 8 y 15 caracteres. - Contener letras. - Contener números. - Contener al menos un símbolo. - No almacenarse en texto plano. - No mostrarse en registros, logs ni mensajes del sistema. Cuando se realice un restablecimiento de contraseña, la nueva contraseña debe cumplir las mismas reglas de seguridad.

**Aceptación** El sistema debe rechazar cualquier contraseña que no cumpla con las reglas establecidas.

**Estado observado** Parcial. DTO de recuperación/cambio exige 8..15, mayúscula, número y símbolo; inicial aleatoria de 12. Probar todos los flujos.

**Prueba** CP-RNF-1.2

### RNF-1.3 Protección contra intentos de acceso no autorizados

**Requisito** El sistema deberá registrar intentos de autenticación y persistir un contador por cuenta, con bloqueo temporal tras cinco fallos consecutivos durante cinco minutos. El control deberá operar en servidor aunque se recargue o eluda la interfaz.

**Control** Persistir el intento fallido sin perderlo por rollback; limitar intentos automatizados y registrar éxito/fallo sin revelar existencia de cuenta.

**Aceptación** Cinco fallos consecutivos contra la API activan bloqueo de cinco minutos. Reiniciar la interfaz no elimina el bloqueo. Un éxito permitido reinicia el contador y deja auditoría.

**Estado observado** Brecha. Contador/bloqueo se guarda antes de excepción transaccional H02.

**Prueba** CP-RNF-1.3

### RNF-1.4 Control de acceso basado en roles

**Requisito** El sistema debe implementar un mecanismo de control de acceso basado en roles (RBAC).

**Control** Los permisos deben estar asociados a los siguientes roles: - Aprendiz. - Instructor. - Coordinador. El sistema debe validar los permisos tanto en el frontend como en el backend. La interfaz puede ocultar funcionalidades no autorizadas, pero la seguridad no debe depender únicamente de esta restricción visual.

**Aceptación** Un usuario no debe poder ejecutar mediante solicitudes directas al backend una operación que no esté autorizada para su rol.

**Estado observado** Brecha. API facial sin permisos de operación/objeto H01; layouts H14.

**Prueba** CP-RNF-1.4

### RNF-1.5 Restricción de información por rol

**Requisito** El sistema debe garantizar que cada usuario solo pueda consultar la información correspondiente a sus permisos.

**Control** Aprendiz Debe poder consultar: - Sus propios datos. - Sus propias asistencias. - La información académica que le corresponda. No debe poder consultar información privada ni asistencias de otros Aprendices. Instructor Debe poder consultar: - Las fichas que tenga asignadas. - Los aprendices pertenecientes a dichas fichas. - Las asistencias correspondientes a sus fichas asignadas. No debe poder consultar información de fichas que no tenga asignadas. Coordinador Debe poder consultar y gestionar la información administrativa necesaria para sus funciones, incluyendo la gestión de usuarios, roles y datos personales.

**Aceptación** El sistema debe impedir que un usuario acceda a información perteneciente a otro usuario, ficha o rol fuera de su ámbito autorizado.

**Estado observado** Brecha. Matriz de ficha accesible sin filtro de aprendiz H01.

**Prueba** CP-RNF-1.5

### RNF-1.6 Protección de datos personales

**Requisito** El sistema debe proteger los datos personales almacenados y procesados durante el funcionamiento del módulo.

**Control** - El acceso a los datos debe estar limitado según el rol. - Los datos personales no deben exponerse a usuarios no autorizados. - Las modificaciones de información personal deben quedar registradas. - El sistema debe mantener trazabilidad de las operaciones relevantes. - El tratamiento de datos debe realizarse conforme a las políticas de privacidad y protección de datos aplicables al proyecto.

**Aceptación** Un usuario sin permisos suficientes no debe poder consultar ni modificar datos personales de otros usuarios.

**Estado observado** Parcial. Perfil propio y aceptación; API facial y biometría H05/H12.

**Prueba** CP-RNF-1.6

### RNF-1.7 Gestión de actualización de datos personales

**Requisito** Los Aprendices e Instructores no deben modificar directamente sus datos personales desde el sistema. Las modificaciones deben realizarse mediante un usuario autorizado, principalmente el Coordinador.

**Control** El sistema debe: - Restringir técnicamente la modificación directa por parte de Aprendices e Instructores. - Permitir al Coordinador realizar las modificaciones autorizadas. - Registrar quién realizó la modificación. - Registrar la fecha y hora de la modificación. - Mantener trazabilidad de los cambios realizados.

**Aceptación** Una solicitud realizada por un Aprendiz o Instructor para modificar directamente sus datos debe ser rechazada por el backend.

**Estado observado** Parcial. Gestión de datos existe; inmutabilidad/documento H07 y auditoría por verificar.

**Prueba** CP-RNF-1.7

### RNF-1.8 Auditoría y trazabilidad

**Requisito** El sistema debe mantener registros de seguridad de las operaciones relevantes del módulo.

**Control** Como mínimo, deben registrarse: - Inicio de sesión exitoso. - Intentos de inicio de sesión fallidos. - Restablecimientos de contraseña. - Cambios de contraseña. - Cambios de rol. - Modificaciones de datos personales. - Cambios relacionados con permisos. - Eventos relevantes de acceso no autorizado. Los registros deben contener, cuando corresponda: - Usuario involucrado. - Fecha. - Hora. - Tipo de operación. - Resultado de la operación. - Identificador técnico de la operación o sesión. Los registros no deben almacenar contraseñas ni códigos de recuperación en texto plano.

**Aceptación** Las operaciones críticas del módulo deben poder ser rastreadas posteriormente mediante los registros de auditoría.

**Estado observado** Parcial. Historial académico y sesiones; auditLogger cliente en memoria, fallos transaccionales H02.

**Prueba** CP-RNF-1.8

### RNF-1.9 Seguridad del restablecimiento de contraseña

**Requisito** La recuperación deberá usar código aleatorio de seis dígitos, vigente cinco minutos, ligado a una solicitud y cuenta; no podrá reutilizarse ni emplearse para otra cuenta.

**Control** Invalidar códigos anteriores al reenviar, limitar intentos y consumir la autorización de manera atómica; revocar sesiones al cambiar contraseña.

**Aceptación** Código vencido, usado o de otra solicitud no permite cambiar la contraseña. Dos peticiones concurrentes no lo consumen dos veces. Los umbrales de intentos de recuperación se registran en DEC-06 antes de aceptación.

**Estado observado** Parcial. Código numérico, caducidad y consumo; lookup global por token sin vincular solicitud/usuario, intentos y colisiones por probar.

**Prueba** CP-RNF-1.9

### RNF-1.10 Protección del correo electrónico

**Requisito** El correo se usará para recuperación y comunicaciones autorizadas; el identificador de inicio de sesión será el documento. Las vistas ordinarias mostrarán correo enmascarado.

**Control** Rechazar autenticación por email y reducir exposición del correo conforme a RNF-4.2.

**Aceptación** Una solicitud de login identificada solo por correo es rechazada. El documento válido permite el acceso con la credencial correcta. El correo completo no se muestra en perfiles/listados/reportes ordinarios.

**Estado observado** Brecha. API admite correo como identificador. Enmascaramiento se evalúa en RNF-4.2.

**Prueba** CP-RNF-1.10

### RNF-1.11 Gestión segura de sesiones

**Requisito** La sesión deberá usar tokens firmados con expiración y revocación, vinculados a identidad, estado vigente y autorización actual.

**Control** Validar token y estado de sesión/cuenta en API y canal de tiempo real; revocar ante logout, desactivación, recuperación y cambio de rol.

**Aceptación** Token alterado, expirado o revocado es rechazado; no conserva permisos de un rol anterior. Manipular estado local no concede privilegios.

**Estado observado** Brecha. Token sin revocación/validación de sesión actual H03.

**Prueba** CP-RNF-1.11

### RNF-1.12 Rendimiento del inicio de sesión

**Requisito** El proceso de autenticación debe responder de manera eficiente.

**Control** Bajo condiciones normales de operación: - El sistema debería responder a una solicitud de inicio de sesión en un tiempo máximo de 3 segundos. - La consulta del usuario y su rol debe realizarse de manera eficiente. - Las operaciones de autenticación no deben generar consultas innecesarias a la base de datos.

**Aceptación** Al menos el 95 % de los intentos de inicio de sesión realizados bajo condiciones normales deberían recibir una respuesta en un máximo de 3 segundos.

**Estado observado** Por probar. Medir 95% de logins en máximo 3 s.

**Prueba** CP-RNF-1.12

### RNF-1.13 Disponibilidad del servicio de autenticación

**Requisito** El servicio necesario para la autenticación debe encontrarse disponible durante el horario operativo definido para el sistema.

**Control** Cuando el servicio de autenticación no esté disponible: - El sistema debe informar al usuario que temporalmente no es posible iniciar sesión. - No debe mostrar información técnica sensible. - No debe generar sesiones incompletas. - El error debe registrarse para su posterior análisis.

**Aceptación** Una falla del servidor de autenticación no debe permitir el acceso no autorizado al sistema.

**Estado observado** Por probar. Medir disponibilidad según horario y meta aprobados.

**Prueba** CP-RNF-1.13

### RNF-1.14 Usabilidad del acceso

**Requisito** La pantalla de inicio de sesión debe ser clara y comprensible para los tres roles.

**Control** Debe: - Identificar claramente el campo de número de documento. - Identificar claramente el campo de contraseña. - Permitir visualizar u ocultar la contraseña mediante un control seguro. - Mostrar mensajes de validación comprensibles. - Permitir acceder al proceso de recuperación de contraseña. - Evitar solicitar información innecesaria para iniciar sesión.

**Aceptación** Un usuario debe poder identificar fácilmente cómo ingresar al sistema y cómo recuperar su contraseña.

**Estado observado** Por probar. Pruebas de usabilidad y mensajes con usuarios.

**Prueba** CP-RNF-1.14

### RNF-1.15 Separación de responsabilidades

**Requisito** Las funciones de autenticación, autorización y administración deben mantenerse separadas.

**Control** El sistema debe diferenciar entre: - Autenticación: verificar quién es el usuario. - Autorización: determinar qué puede hacer el usuario. - Administración: gestionar usuarios, datos y roles. La modificación de roles y permisos debe estar restringida a usuarios con autorización administrativa.

**Aceptación** La autenticación exitosa de un usuario no debe otorgarle automáticamente permisos administrativos.

**Estado observado** Parcial. Capas separadas; autorización efectiva debe alinearse H01/H14.

**Prueba** CP-RNF-1.15

### RNF-1.16 Integridad de los permisos

**Requisito** Los permisos asociados a cada rol deben mantenerse consistentes entre frontend y backend.

**Control** El sistema debe garantizar que: - Los permisos definidos para Aprendiz sean respetados. - Los permisos definidos para Instructor sean respetados. - Los permisos definidos para Coordinador sean respetados. - Un cambio de rol realizado por el Coordinador sea aplicado correctamente. - Los permisos anteriores no permanezcan activos de manera indebida después de un cambio de rol.

**Aceptación** Después de modificar el rol de un usuario, el sistema debe aplicar únicamente los permisos correspondientes al nuevo rol.

**Estado observado** Brecha. Cambiar rol no cambia permisos de tokens previos H03; guards H14.

**Prueba** CP-RNF-1.16

## 7.2 Gestión académica

### RNF-2.1 Control de acceso

**Requisito** Solo un usuario con rol Coordinador puede cargar archivos CSV, crear, editar, desactivar, reactivar o eliminar Programas, Fichas, Aprendices e Instructores, y generar/consultar códigos de traslado. Esta restricción se valida siempre en el backend, nunca solo ocultando los botones en la pantalla - un Instructor o Aprendiz que intente llamar directamente a estos endpoints debe recibir un rechazo del servidor, no solo no ver el botón.

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** Una solicitud directa al backend desde una cuenta que no sea Coordinador para cualquiera de estas operaciones debe ser rechazada con un código de error de autorización, no procesada parcialmente.

**Estado observado** Parcial. API académica restringida al coordinador; verificar alcance de GET disponibles al instructor.

**Prueba** CP-RNF-2.1

### RNF-2.2 Validación e integridad de datos

**Requisito** Las altas y actualizaciones deberán preservar formato, unicidad, estados y relaciones de programa, ficha, aprendiz e instructor.

**Control** Aplicar reglas comunes a CSV y formulario: ficha con programa; aprendiz activo asignado a una ficha activa; instructor específico con programa. Mantener relaciones históricas al desactivar.

**Aceptación** No quedan fichas sin programa ni vínculos activos inválidos. Una cuenta desactivada puede conservar relaciones históricas sin considerarse una asignación operativa. Datos inválidos no crean registros parciales.

**Estado observado** Parcial. DTO, unicidad y relaciones; inconsistencias adicionales H07/H09.

**Prueba** CP-RNF-2.2

### RNF-2.3 Trazabilidad completa

**Requisito** Toda operación de este módulo - carga de CSV (exitosa o con errores), creación, edición, desactivación, reactivación, eliminación permanente, confirmación o cancelación de un cambio de ficha por CSV, y generación o uso de un código de traslado - debe quedar registrada con: quién la hizo, cuándo (fecha y hora exactas), y qué cambió exactamente (valor anterior y valor nuevo, cuando aplique). Estos registros no pueden editarse ni eliminarse por ningún rol, incluido el propio Coordinador.

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** Para cualquier dato de Programa, Ficha, Aprendiz o Instructor, debe poder reconstruirse su historial completo de cambios sin ambigüedad.

**Estado observado** Parcial. ChangeHistory académico; cobertura completa de operaciones y actores por probar.

**Prueba** CP-RNF-2.3

### RNF-2.4 Protección de datos personales

**Requisito** Los datos personales de Aprendices e Instructores (documento, nombre, apellido, correo) se almacenan y transmiten de forma segura. El archivo CSV cargado se procesa y no se conserva en crudo después de procesarse (no queda un archivo con datos personales sueltos en el servidor más allá de lo necesario para el procesamiento). El correo nunca se muestra completo en ninguna pantalla de este módulo salvo en el propio formulario de edición del registro correspondiente.

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** Ningún archivo CSV cargado queda accesible o descargable después de haberse procesado.

**Estado observado** Parcial. Roles/hash presentes; CSV devuelve secretos H06.

**Prueba** CP-RNF-2.4

### RNF-2.5 Rendimiento de la carga de CSV

**Requisito** El procesamiento de un archivo CSV debe completarse en un tiempo razonable según su tamaño. Como referencia: un archivo de hasta 500 filas debe procesarse en menos de 10 segundos; archivos más grandes deben mostrar una barra o indicador de progreso, nunca dejar la pantalla congelada sin retroalimentación.

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** El Coordinador siempre tiene una señal visual de que el archivo se está procesando mientras dura la carga.

**Estado observado** Por probar. Medir CSV de 500 filas en menos de 10 s e indicador de progreso.

**Prueba** CP-RNF-2.5

### RNF-2.6 Disponibilidad de la información académica

**Requisito** La consulta de Programas, Fichas, Aprendices e Instructores (fuera de la carga de CSV en sí) debe estar disponible con alta confiabilidad, dado que otros módulos (Asistencia, Notificaciones, el propio login para verificar a qué ficha pertenece un aprendiz) dependen de esta información para funcionar.

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** Antes de aprobar este RNF, definir el horario operativo y la meta de disponibilidad (porcentaje y periodo de medición). Después, verificar consultas de Programas, Fichas, Aprendices e Instructores durante el periodo acordado y registrar indisponibilidades. Meta cuantitativa: pendiente de aprobación; no asumir un porcentaje no acordado.

**Estado observado** Por probar. Disponibilidad académica; SRS requiere definir horario/meta antes de aprobar.

**Prueba** CP-RNF-2.6

### RNF-2.7 Usabilidad para un usuario no técnico

**Requisito** Ningún mensaje de error de este módulo (ni en la carga de CSV, ni en los formularios manuales) debe usar terminología técnica de base de datos (ej. "constraint violation", "foreign key", "null pointer"). Todo mensaje debe estar en lenguaje simple, tal como se especifica en la Parte B.

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** Un Coordinador sin conocimientos técnicos debe poder entender y corregir cualquier error mostrado, sin necesidad de soporte técnico, en la mayoría de los casos.

**Estado observado** Por probar. Guía y resumen presentes; prueba con usuario no técnico pendiente.

**Prueba** CP-RNF-2.7

### RNF-2.8 Consistencia entre carga por CSV y edición manual

**Requisito** El resultado final de crear/editar un Programa, Ficha, Aprendiz o Instructor debe ser idéntico sin importar si se hizo por CSV o manualmente - las mismas reglas de validación, el mismo ciclo de vida (activo/inactivo), y la misma trazabilidad aplican por los dos caminos, sin excepciones especiales para uno u otro.

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** Para una misma entidad y datos equivalentes, ejecutar alta/actualización por CSV y formulario manual; los valores y relaciones persistidos deben coincidir. Registrar el resultado de ambas rutas, incluyendo reglas de validación y errores.

**Estado observado** Parcial. Servicios comunes y validaciones; comparar CSV/manual con los mismos datos.

**Prueba** CP-RNF-2.8

### RNF-2.9 Unicidad de identificadores

**Requisito** El sistema debe garantizar que nunca existan dos Programas con el mismo programa_codigo, dos Fichas con el mismo ficha_codigo, ni dos cuentas (Aprendiz o Instructor) con el mismo número de documento - tanto si el conflicto surge por CSV como por formulario manual.

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** Un intento de crear un duplicado, por cualquier vía, siempre se resuelve como actualización del registro existente (si los datos son consistentes) o como error/inconsistencia bloqueada (si no lo son) - nunca se crean dos registros distintos con el mismo identificador.

**Estado observado** Parcial. Restricciones únicas y validación; probar duplicados y carreras concurrentes.

**Prueba** CP-RNF-2.9

### RNF-2.10 Atomicidad del traslado de ficha

**Requisito** El traslado RF-2.3 deberá desactivar origen y activar destino en una única transacción, preservando una asignación activa al confirmar.

**Control** Validar destino, bloquear conflictos concurrentes y registrar el cambio junto con su auditoría.

**Aceptación** Fallo antes o durante el traslado revierte los cambios. Tras confirmar existe una única ficha activa; no se observan relaciones parciales. Dos traslados simultáneos se resuelven sin dos asignaciones activas.

**Estado observado** Por probar. Traslado @Transactional y saveAndFlush; inyección de fallo/concurrencia pendiente.

**Prueba** CP-RNF-2.10

### RNF-2.11 Auditoría de la resolución de inconsistencias

**Requisito** Cuando el Coordinador resuelve una inconsistencia bloqueada del CSV (vía "Ir a corregir"), o confirma/cancela un cambio de ficha propuesto por CSV, esa decisión queda registrada como un evento de auditoría propio - distinto del evento de la carga original - para poder diferenciar después "qué trajo el archivo" de "qué decidió finalmente el Coordinador".

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** Al resolver/cancelar una inconsistencia, comprobar que queda evidencia consultable con actor, fecha/hora, entidad, valores relevantes, decisión y motivo cuando aplique. La operación debe poder rastrearse hasta la carga CSV que la originó.

**Estado observado** Parcial. Decisiones CSV y ChangeHistory presentes; verificar vínculo a carga, motivo y datos anteriores/nuevos.

**Prueba** CP-RNF-2.11

### RNF-2.12 Escalabilidad de la gestión académica

**Requisito** El módulo debe soportar el volumen real esperado de un centro de formación (referencia: cientos de fichas, miles de aprendices) sin degradar el tiempo de respuesta de las pantallas de consulta y búsqueda por debajo de lo aceptable (ver RNF-2.5 para el caso específico de carga de CSV).

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** Ejecutar pruebas con el volumen de referencia del requisito (cientos de fichas y miles de aprendices), medir operaciones de consulta/gestión y registrar tiempos y errores. Umbrales de respuesta: pendientes de aprobación antes de declarar conformidad.

**Estado observado** Por probar. Cientos de fichas/miles de aprendices, umbrales aprobados y carga.

**Prueba** CP-RNF-2.12

### RNF-2.13 Recuperación ante fallos durante la carga de CSV

**Requisito** Un fallo técnico durante una carga CSV no deberá dejar cambios a medio confirmar. Las filas con error de negocio se excluyen del conjunto aplicable y se informan en el resumen.

**Control** Validar y clasificar filas, ejecutar el conjunto válido en una transacción y confirmar resultados solo después del commit.

**Aceptación** Interrumpir la carga antes del commit deja la base en su estado anterior. Reprocesar no duplica registros. Un error de negocio por fila no impide procesar las demás válidas según RF-2.1.

**Estado observado** Por probar. Carga @Transactional; interrupción/reproceso sin entidades parciales pendiente.

**Prueba** CP-RNF-2.13

### RNF-2.14 Internacionalización de nombres y apellidos

**Requisito** El sistema debe aceptar correctamente nombres y apellidos con tildes, diéresis y la letra "ñ", tanto en el CSV como en los formularios manuales, sin corromper los caracteres al guardarlos ni al mostrarlos (el archivo CSV debe leerse en codificación UTF-8).

**Control** Aplicar el control en las capas pertinentes y conservar evidencia de verificación de los criterios indicados.

**Aceptación** Procesar nombres y apellidos con tildes, diéresis y ñ por CSV, formulario, API, almacenamiento, visualización y exportación. Los caracteres deben conservarse sin sustitución ni corrupción en todas las etapas.

**Estado observado** Brecha. UTF-8 CSV presente; regex de edición admite tildes/ñ pero excluye ü/Ü exigidas.

**Prueba** CP-RNF-2.14

## 7.3 Gestión de usuarios

### RNF-3.1 Panel de usuarios registrados

**Requisito** El sistema debe mostrar el listado completo de usuarios de forma paginada y permitir filtrar por rol, estado y ficha. Solo el Coordinador tiene acceso a esta vista.

**Control** Consultar la base de datos de usuarios y aplicar los filtros seleccionados antes de renderizar el listado.

**Aceptación** - El listado carga en menos de 2 segundos con hasta 500 usuarios. - El acceso desde otro rol retorna error 403. - Los filtros responden en menos de 1 segundo.

**Estado observado** Por probar. Panel conectado; medir menos de 2 s con 500 usuarios.

**Prueba** CP-RNF-3.1

### RNF-3.2 Unicidad de número de documento

**Requisito** El sistema no permite registrar dos usuarios con el mismo número de documento.

**Control** Validar en la base de datos si el documento ya está registrado antes de crear el nuevo usuario.

**Aceptación** - El sistema bloquea el registro duplicado. - El error se muestra en tiempo real sin necesidad de enviar el formulario. - No se crea ningún registro parcial en la base de datos.

**Estado observado** Parcial. Documento único; probar todas las altas y concurrencia.

**Prueba** CP-RNF-3.2

### RNF-3.3 Contraseña inicial segura

**Requisito** La credencial inicial deberá ser aleatoria, cumplir RNF-1.2 y almacenarse únicamente como hash. Ningún endpoint ordinario ni exportación la devolverá en texto legible.

**Control** Generar un secreto independiente del documento; emplear activación de un uso o entrega protegida al titular según DEC-02; no conservar el secreto en logs, CSV o resultados administrativos.

**Aceptación** Alta manual y CSV cumplen la misma regla. Password no aparece en panel, Excel, CSV, respuestas o logs. Su longitud es de 8 a 15 e incluye letra, número y símbolo.

**Estado observado** Brecha. Hash/generación presentes, pero retorno y exportación CSV H06.

**Prueba** CP-RNF-3.3

### RNF-3.4 Inmutabilidad del número de documento

**Requisito** El número de documento de un usuario no puede modificarse una vez creado el registro.

**Control** Deshabilitar el campo de documento en el formulario de edición y rechazar cualquier solicitud de actualización de ese campo en el servidor.

**Aceptación** - El campo está visualmente deshabilitado en el formulario. - La API rechaza peticiones de actualización del documento con error 400. - El historial del usuario se mantiene intacto tras cualquier otra edición.

**Estado observado** Brecha. Documento editable en servicios H07.

**Prueba** CP-RNF-3.4

### RNF-3.5 Trazabilidad de cambios en usuarios

**Requisito** El sistema registra en auditoría toda creación, modificación o desactivación de usuarios, incluyendo quién realizó el cambio, qué campo se modificó y los valores anterior y nuevo.

**Control** Interceptar toda operación de escritura sobre usuarios y generar el registro de auditoría antes de confirmar la transacción.

**Aceptación** - Toda modificación genera un registro de auditoría sin excepción. - El registro incluye usuario responsable, fecha/hora, campo y valores. - Los registros de auditoría son de solo lectura; no pueden eliminarse ni modificarse.

**Estado observado** Parcial. Notificaciones de cambio; no equivalen a auditoría íntegra con anterior/nuevo de cada campo.

**Prueba** CP-RNF-3.5

### RNF-3.6 Desactivación sin eliminación de historial

**Requisito** Al desactivar un usuario, el sistema bloquea su acceso de forma inmediata pero conserva todo su historial de asistencia y registros faciales.

**Control** Cambiar el estado del usuario a inactivo, invalidar sesiones activas del usuario e impedir nuevos inicios de sesión, sin eliminar ningún dato asociado.

**Aceptación** - El acceso se bloquea en menos de 5 segundos tras la desactivación. - Los registros de asistencia del usuario desactivado siguen apareciendo en reportes históricos. - No se elimina ningún dato del usuario al desactivarlo. - El sistema siempre mantiene al menos un Coordinador activo.

**Estado observado** Brecha. Historial preservado por desactivación; token sigue funcionando H03.

**Prueba** CP-RNF-3.6

### RNF-3.7 Exportación del listado de usuarios

**Requisito** El sistema permite al Coordinador exportar el listado de usuarios filtrado en formato .xlsx.

**Control** Generar el archivo .xlsx usando la librería xlsx del proyecto con los datos del listado activo y entregarlo mediante expo-sharing.

**Aceptación** - El archivo contiene exactamente los registros del listado filtrado, sin omisiones ni extras. - El archivo se genera en menos de 5 segundos. - Los datos exportados no incluyen contraseñas ni descriptores biométricos.

**Estado observado** Parcial. Exportación presente; filtros, máscara, tiempo y alcance por probar.

**Prueba** CP-RNF-3.7

## 7.4 Perfil y sesión

### RNF-4.1 Visualización de datos propios

**Requisito** Cada usuario puede consultar únicamente su propia información de perfil. Ningún usuario puede acceder al perfil de otro.

**Control** Recuperar los datos del usuario autenticado desde el servidor usando su token de sesión y renderizarlos en la pantalla de perfil.

**Aceptación** - La pantalla carga en menos de 2 segundos. - Un usuario nunca puede visualizar el perfil de otro usuario. - Los datos mostrados están actualizados al momento de la consulta.

**Estado observado** Parcial. Perfil del principal conectado; datos actuales y carga <2 s por probar.

**Prueba** CP-RNF-4.1

### RNF-4.2 Enmascaramiento del correo electrónico

**Requisito** El correo deberá mostrarse parcialmente enmascarado en perfiles, listados, notificaciones y exportaciones ordinarias. El ingreso del correo para recuperación o gestión autorizada es una operación explícita, no una exposición general del perfil.

**Control** Aplicar máscara consistente en presentación y minimizar campos retornados. Para recuperación, el usuario ingresa su correo; la confirmación de envío lo presenta enmascarado.

**Aceptación** Las vistas ordinarias no muestran el correo completo. Ninguna API sin permiso suficiente obtiene correos ajenos. La gestión del contacto requiere autorización explícita y registro de cambios.

**Estado observado** Brecha. Correo sin máscara H12.

**Prueba** CP-RNF-4.2

### RNF-4.3 Cierre de sesión seguro

**Requisito** Al cerrar sesión, el sistema invalida el token en el servidor y elimina todos los datos sensibles almacenados localmente en el dispositivo.

**Control** Llamar al endpoint de cierre de sesión, invalidar el token en el servidor, limpiar expo-secure-store y redirigir al login.

**Aceptación** - El cierre de sesión se completa en menos de 1 segundo. - El botón "atrás" del dispositivo no permite regresar a pantallas autenticadas. - El token invalidado es rechazado en cualquier solicitud posterior. - Los datos locales sensibles son eliminados del dispositivo.

**Estado observado** Brecha. Logout local sin revocación y limpieza integral H03.

**Prueba** CP-RNF-4.3

### RNF-4.4 Cierre de sesión automático por inactividad

**Requisito** El sistema cierra automáticamente la sesión del usuario tras 30 minutos de inactividad para proteger el acceso no autorizado.

**Control** Monitorear el tiempo de inactividad del usuario; al alcanzar 30 minutos sin actividad, ejecutar el proceso de cierre de sesión seguro (RNF 4.3).

**Aceptación** - El cierre automático se ejecuta exactamente a los 30 minutos de inactividad. - Cualquier interacción del usuario reinicia el contador de inactividad. - El mensaje de sesión expirada se muestra al usuario antes de redirigirlo.

**Estado observado** Sin evidencia. No se encontró timeout de 30 min H03.

**Prueba** CP-RNF-4.4

### RNF-4.5 Restricción de modificación de datos propios

**Requisito** Los usuarios con rol Aprendiz e Instructor no pueden modificar directamente sus datos personales desde la app. Solo el Coordinador puede actualizar esos datos.

**Control** Deshabilitar la edición de campos de datos personales para roles Aprendiz e Instructor; rechazar a nivel de API cualquier solicitud de actualización de datos personales de esos roles.

**Aceptación** - Los campos están deshabilitados visualmente para Aprendiz e Instructor. - La API rechaza peticiones de modificación de datos personales de esos roles con error 403. - El Coordinador puede editar datos de cualquier usuario desde el panel de gestión.

**Estado observado** Parcial. Perfil propio de lectura y edición administrativa; probar intentos directos de aprendiz/instructor.

**Prueba** CP-RNF-4.5

## 7.5 Reconocimiento y privacidad biométrica

### RNF-5.1 Detección de un único rostro en el encuadre

**Requisito** El sistema solo permite iniciar la captura facial cuando detecta exactamente un rostro en el encuadre. No acepta capturas con cero o más de un rostro.

**Control** Ejecutar detección facial en tiempo real con @vladmandic/human; validar que el conteo de rostros detectados sea exactamente 1 antes de habilitar la captura.

**Aceptación** - La detección de rostros se ejecuta en tiempo real sin superar 500 ms por frame. - El sistema bloquea la captura si detecta 0 o 2+ rostros. - El mensaje de error indica claramente la causa.

**Estado observado** Parcial. Microservicio rechaza cero/múltiples rostros; probar captura real en ambas plataformas.

**Prueba** CP-RNF-5.1

### RNF-5.2 Calidad mínima de captura facial

**Requisito** El sistema valida que cada captura cumpla condiciones mínimas de iluminación y nitidez antes de extraer los descriptores faciales.

**Control** Evaluar la calidad de la imagen capturada mediante los scores de confianza de @vladmandic/human antes de extraer descriptores. Rechazar capturas con score inferior al umbral definido.

**Aceptación** - Las capturas con score de calidad menor al umbral son rechazadas automáticamente. - El umbral de calidad es configurable. - El mensaje de error indica la causa específica del rechazo.

**Estado observado** Parcial. Captura y chequeos presentes; demostrar calidad mínima real y rechazos.

**Prueba** CP-RNF-5.2

### RNF-5.3 Registro facial con múltiples capturas

**Requisito** El registro facial deberá incluir al menos tres capturas válidas desde centro, izquierda y derecha, con variación suficiente y evidencia de vida de la misma persona.

**Control** Validar cada captura y consolidar una referencia facial compatible; conservar modelo, dimensión y versión; no completar el alta con ángulos equivalentes.

**Aceptación** Menos de tres capturas o ángulos demasiado similares son rechazados. La referencia consolida capturas válidas según el algoritmo documentado. El proceso toma menos de 60 s en condiciones normales.

**Estado observado** Parcial. Secuencias multiframe presentes; el micro consolida el último embedding. Ángulos distintos, <60 s y contrato H04 pendientes.

**Prueba** CP-RNF-5.3

### RNF-5.4 Almacenamiento encriptado de descriptores faciales

**Requisito** Los descriptores biométricos deberán protegerse en reposo y en tránsito. Las imágenes de captura solo se usarán de forma transitoria para extracción y validación; no se conservará la imagen original ni se utilizará como foto de perfil.

**Control** Cifrar el transporte antes de enviar imágenes temporales y el descriptor antes de su primera transmisión cuando la extracción sea local. Cifrar el descriptor persistido con gestión de claves; descartar imágenes y temporales al terminar o fallar. Si se usa búsqueda vectorial en servidor, su diseño debe cumplir DEC-03 sin tratar un vector legible como cifrado.

**Aceptación** No hay imágenes originales en DB, disco, caché durable, respuestas o logs después del procesamiento. Los descriptores no quedan legibles en reposo sin la clave autorizada. Se verifica borrado de temporales, cifrado y acceso por titular/servicio.

**Estado observado** Brecha. Vector sin cifrado de aplicación y flujo Java con foto H12.

**Prueba** CP-RNF-5.4

### RNF-5.5 Umbral configurable de similitud facial

**Requisito** El umbral de similitud mínima para aceptar una identificación facial es configurable por el Coordinador, con un valor por defecto de 0.6.

**Control** Validar que el nuevo valor esté dentro del rango permitido (0.4 - 0.9); actualizar el parámetro en el servidor sin necesidad de reinicio del servicio.

**Aceptación** - El umbral acepta valores entre 0.4 y 0.9 únicamente. - El cambio se aplica inmediatamente a las identificaciones posteriores. - Valores fuera del rango son rechazados con mensaje de error.

**Estado observado** Brecha. SRS: default 0.6, rango 0.4..0.9 y coordinador; servicio: default 0.65, rango 0..1, sin panel/versionado.

**Prueba** CP-RNF-5.5

### RNF-5.6 Transmisión segura de datos de identificación

**Requisito** Los datos de reconocimiento deberán transmitirse exclusivamente por HTTPS/TLS entre cliente, servidor y servicio facial, con integridad y autenticación del origen.

**Control** Rechazar HTTP para endpoints biométricos, validar firma o mecanismo equivalente de integridad aprobado para el mensaje y limitar aceptación a dispositivos/servicios autorizados.

**Aceptación** Una transmisión biométrica por HTTP es rechazada con 403. Firma inválida se descarta y audita. UUID, puntaje o fecha arbitrarios no acreditan reconocimiento; verificar configuración productiva y de estaciones.

**Estado observado** Parcial. HTTPS exclusivo, rechazo HTTP y firma digital no demostrados H12.

**Prueba** CP-RNF-5.6

### RNF-5.7 Sincronización offline de registros faciales

**Requisito** Si no hay conexión al momento de la identificación, los datos se almacenan localmente en la Raspberry Pi de forma encriptada y se sincronizan automáticamente al restablecer la conexión.

**Control** Encolar los datos de identificación localmente con cifrado; monitorear la conectividad; ejecutar sincronización automática al detectar conexión; eliminar la copia local tras confirmación del servidor.

**Aceptación** - Los datos locales están encriptados durante el almacenamiento temporal. - La sincronización se ejecuta automáticamente sin intervención manual. - La cola local no supera 24 horas de registros acumulados sin alerta al Coordinador. - Los datos locales se eliminan tras confirmación de sincronización exitosa.

**Estado observado** Sin evidencia. Sin cola facial cifrada offline/Raspberry H13.

**Prueba** CP-RNF-5.7

## 7.6 Asistencia y validaciones

### RNF-6.1 Registro automático de asistencia

**Requisito** El sistema registra automáticamente la asistencia del usuario al completar una identificación facial exitosa, sin requerir ninguna acción adicional del usuario ni del instructor.

**Control** Al recibir la identificación exitosa, recuperar el horario activo del ambiente, calcular el estado de asistencia y crear el registro en la base de datos en menos de 2 segundos.

**Aceptación** - El registro se crea en menos de 2 segundos tras la identificación. - No puede existir más de un registro de entrada para el mismo usuario en la misma sesión. - El registro incluye todos los campos requeridos sin excepción.

**Estado observado** Parcial. Registro real y unicidad presentes; bypass directo H01 y <2 s por probar.

**Prueba** CP-RNF-6.1

### RNF-6.2 Clasificación automática del estado de asistencia

**Requisito** El servidor deberá clasificar puntualidad, retardo y ausencia según horario efectivo, excepciones y ventana de registro versionada, no según estado declarado por el cliente.

**Control** Permitir tolerancia inclusiva entre 0 y 30 minutos; validar salida posterior al final de ventana; usar hora confiable y calendario efectivo.

**Aceptación** Clasificación por registro en menos de 500 ms. Hasta el límite de puntualidad inclusive es puntual; después y antes de salida es tardío. Ausencia se determina solo para sesión aplicable y no cancelada; excepción activa cambia el cálculo sin alterar silenciosamente hechos.

**Estado observado** Parcial. Clasificación real; rango 0..30, excepciones y <500 ms pendientes H09.

**Prueba** CP-RNF-6.2

### RNF-6.3 Inmutabilidad de registros de asistencia

**Requisito** Los hechos de asistencia serán inmutables. Solo el coordinador autorizado podrá anular con motivo documentado; excusas se registrarán como anotaciones separadas y trazables sin sobrescribir hora o resultado original.

**Control** Denegar UPDATE/DELETE ordinarios del hecho; guardar anulación o anotación con autor, fecha y motivo y mostrar estado original y ajuste.

**Aceptación** Aprendiz o instructor no modifica/elimina el hecho ni anula por API. Anulación sin justificación se rechaza. Auditoría conserva original y decisión; permisos de base y servicio impiden eludir la regla.

**Estado observado** Brecha. Modificación de excusa sin permiso del actor; no se encontró anulación coordinador con motivo H01.

**Prueba** CP-RNF-6.3

### RNF-6.4 Alerta por retrasos repetidos

**Requisito** El sistema genera una alerta automática al instructor cuando un aprendiz acumula más de 3 retrasos graves en el mismo mes.

**Control** Evaluar el acumulado de retrasos graves del aprendiz en el mes al crear cada registro de asistencia; si supera el umbral, generar la notificación automática al instructor.

**Aceptación** - La alerta se genera en menos de 5 segundos tras el registro que supera el umbral. - El umbral de retrasos graves es configurable por el Coordinador. - La alerta se envía al instructor correcto según la ficha del aprendiz. - No se generan alertas duplicadas para el mismo evento.

**Estado observado** Sin evidencia. No se halló acumulado mensual/umbral configurable/alerta al cuarto retraso H13.

**Prueba** CP-RNF-6.4

### RNF-6.5 Registro manual de asistencia como respaldo

**Requisito** Ante falla facial, el instructor autorizado podrá crear un registro manual identificado como tal y pendiente de validación del coordinador.

**Control** Persistir creador, motivo de respaldo, sesión, aprendiz y hora; comunicar pendientes al coordinador; separar registro manual de reconocimiento automático.

**Aceptación** Reportes distinguen manual/automático. Coordinador recibe pendientes y su decisión queda auditada. Registro incluye ID del instructor y no se aprueba cambiando origin o recognitionResult desde cliente.

**Estado observado** Sin evidencia. Ruta directa existe, pero no flujo manual identificado y pendiente de aprobación H13.

**Prueba** CP-RNF-6.5

## 7.7 Reportes y consultas

### RNF-7.1 Control de acceso en reportes por usuario

**Requisito** El sistema garantiza que cada rol solo puede consultar los reportes de asistencia que le corresponden: el Aprendiz solo ve los suyos, el Instructor los de sus fichas asignadas, y el Coordinador los de cualquier usuario.

**Control** Validar en el servidor que el usuario solicitante tiene permisos sobre el usuario consultado según la matriz de roles; rechazar la solicitud si no los tiene.

**Aceptación** - Un Aprendiz nunca puede consultar registros de otro usuario. - Un Instructor solo accede a reportes de aprendices en sus fichas asignadas. - El Coordinador accede a reportes de cualquier usuario. - La API rechaza solicitudes no autorizadas con error 403.

**Estado observado** Brecha. Matriz no restringe aprendiz a sus propios registros H01.

**Prueba** CP-RNF-7.1

### RNF-7.2 Rendimiento en generación de reportes

**Requisito** Los reportes de asistencia deben generarse y mostrarse en pantalla dentro de los tiempos de respuesta aceptables para garantizar una experiencia fluida.

**Control** Optimizar las consultas a la base de datos con índices sobre fecha, usuario y ficha; implementar paginación en el cliente para no cargar todos los registros de una vez.

**Aceptación** - Reporte de hasta 365 días carga en menos de 5 segundos. - Reporte de ficha con 40 aprendices y 90 días carga en menos de 5 segundos. - La paginación muestra máximo 50 registros por página.

**Estado observado** Por probar. Consultas de 365 días y 40 aprendices/90 días <5 s, paginación máxima 50.

**Prueba** CP-RNF-7.2

### RNF-7.3 Exportación de reportes en formato Excel

**Requisito** El sistema permite exportar cualquier reporte de asistencia en formato .xlsx, con exactamente los datos visibles en pantalla según los filtros activos.

**Control** Generar el archivo .xlsx usando la librería xlsx del proyecto con los datos del reporte filtrado y compartirlo mediante expo-sharing.

**Aceptación** - El archivo contiene exactamente los registros del reporte filtrado. - El archivo se genera en menos de 5 segundos. - El archivo no contiene datos de otros usuarios no incluidos en el reporte visible.

**Estado observado** Parcial. XLSX real presente; fuente local en reportes H11, igualdad/filtros y <5 s por probar.

**Prueba** CP-RNF-7.3

### RNF-7.4 Alerta visual de asistencia crítica en reporte de ficha

**Requisito** En el reporte de asistencia por ficha, los aprendices con porcentaje de asistencia inferior al 80% se resaltan visualmente para facilitar la identificación de casos de riesgo.

**Control** Calcular el porcentaje de asistencia de cada aprendiz al generar el reporte; aplicar resaltado visual y/o icono de alerta a los que estén por debajo del umbral configurado.

**Aceptación** - Los aprendices con asistencia < 80% siempre se resaltan en el reporte. - El umbral de alerta es configurable por el Coordinador. - La distinción visual no depende únicamente del color (accesibilidad WCAG 2.1).

**Estado observado** Parcial. Indicadores visuales presentes; umbral configurable y evaluación con datos reales no demostrados.

**Prueba** CP-RNF-7.4

### RNF-7.5 Vista de calendario de asistencia

**Requisito** El historial de asistencia se visualiza en un calendario mensual que permite identificar el estado de cada día de forma inmediata mediante código de color e icono.

**Control** Cargar los registros de asistencia del mes seleccionado; mapear cada fecha a su estado correspondiente; renderizar el calendario con colores e iconos; al seleccionar un día, mostrar el detalle del registro en la misma pantalla.

**Aceptación** - El calendario del mes actual carga en menos de 2 segundos. - La navegación entre meses no recarga la pantalla completa. - Los estados se distinguen por color e icono simultáneamente para accesibilidad. - El detalle del día seleccionado incluye hora, estado, ambiente e instructor.

**Estado observado** Brecha. Calendario usa asistencia local H11; accesibilidad/tiempos pendientes.

**Prueba** CP-RNF-7.5

## 7.8 Notificaciones y entrega

### RNF-8.1 Generación automática de notificaciones por eventos

**Requisito** El sistema genera notificaciones automáticas ante eventos definidos: registro de asistencia, retrasos graves, ausencias, fallos de identificación facial y desincronización de Raspberry Pi.

**Control** Detectar el evento disparador; determinar los destinatarios según el tipo de evento y los roles; crear la notificación en el servidor y entregarla a la app del destinatario.

**Aceptación** - Las notificaciones se generan en menos de 3 segundos tras el evento. - El sistema nunca pierde una notificación generada aunque falle la entrega push. - No se generan notificaciones duplicadas para el mismo evento. - Cada notificación contiene información suficiente para entender el evento sin navegar a otra pantalla.

**Estado observado** Parcial. Algunos eventos/notificaciones persistidos; falta catálogo facial/offline completo, deduplicación y tiempos.

**Prueba** CP-RNF-8.1

### RNF-8.2 Persistencia y disponibilidad de notificaciones

**Requisito** Las notificaciones se almacenan en el servidor y se sincronizan con la app del usuario. Se conservan por un máximo de 30 días y son accesibles en modo offline.

**Control** Mantener caché local de las últimas 50 notificaciones en el dispositivo; sincronizar con el servidor al recuperar conexión; eliminar automáticamente notificaciones con más de 30 días de antigüedad.

**Aceptación** - El centro de notificaciones carga en menos de 1.5 segundos. - En modo offline muestra al menos las últimas 50 notificaciones en caché. - Las notificaciones de más de 30 días se eliminan automáticamente. - El badge de no leídas se actualiza en tiempo real.

**Estado observado** Parcial. Servidor y lectura presentes; retención 30 días/caché durable 50 sin evidencia H13.

**Prueba** CP-RNF-8.2

### RNF-8.3 Límite de envío de correos de notificación

**Requisito** El sistema limita el envío de correos de notificación a un máximo de 5 por hora por usuario para prevenir saturación del correo. Los correos nunca contienen datos biométricos ni contraseñas.

**Control** Llevar un contador de correos enviados por usuario por hora; si se alcanza el límite, encolar el envío para la siguiente hora disponible; registrar el intento y el estado en auditoría.

**Aceptación** - El sistema no supera 5 correos por hora por usuario bajo ninguna circunstancia. - Los correos descartados por límite quedan en cola y se envían en la siguiente ventana. - Ningún correo contiene datos biométricos ni contraseñas. - El estado de cada envío (exitoso/fallido/en cola) queda registrado en auditoría.

**Estado observado** Brecha. Sin máximo 5 correos por usuario/hora H13; revisar política sobre credenciales por correo.

**Prueba** CP-RNF-8.3

### RNF-8.4 Reintentos de entrega de notificaciones fallidas

**Requisito** El sistema reintenta automáticamente la entrega de notificaciones push que hayan fallado, usando backoff exponencial, sin generar duplicados.

**Control** Registrar el fallo de entrega; programar reintentos con backoff exponencial (1s, 2s, 4s); tras 3 fallos consecutivos, marcar la notificación como no entregada vía push pero mantenerla disponible en la bandeja.

**Aceptación** - No se generan notificaciones duplicadas por los reintentos. - Tras 3 fallos de entrega push la notificación sigue disponible en la bandeja. - El backoff exponencial entre reintentos es respetado.

**Estado observado** Brecha. Reintentos SMTP cada 5 min no satisfacen push 1/2/4 s H13.

**Prueba** CP-RNF-8.4

# 8 Verificación y aceptación

## 8.1 Condiciones de ejecución

Las pruebas se realizarán con cuentas de cada rol, fichas propias y ajenas, dispositivos autorizados/no autorizados, datos de horario y casos de falla. La base se crea con migraciones del proyecto; se documentan versiones de aplicación, modelo facial, configuración, volumen, dispositivo y conectividad. Los datos biométricos de prueba deben usarse con autorización y protección, y eliminarse conforme a la política de prueba.

## 8.2 Identificación de pruebas

A cada requisito se asocia CP seguido de su ID, por ejemplo CP-RF-7.1 o CP-RNF-5.5. Un caso puede tener variantes A flujo normal, B entradas inválidas, C permiso/propiedad, D falla/concurrencia y E rendimiento. Esta convención permite ampliar casos sin renumerar los requisitos.

| Familia | Preparación y ejecución | Resultado esperado |
|---|---|---|
| Acceso y sesión | Login válido/inválido repetido; reutilizar token tras logout, rol o desactivación; 30 min inactivo. | Contador durable, bloqueo, permisos vigentes, rechazo del token y cierre por inactividad. |
| Académico y CSV | Archivo válido, tipos mezclados, tildes/ü/ñ, duplicados, referencias faltantes y fallo antes del commit. | Resumen correcto, integridad, relaciones consistentes, ningún secreto y recuperación sin parcialidad. |
| Traslado | Destino inválido, falla entre cambios y dos traslados concurrentes. | Origen intacto al fallar; una ficha activa al confirmar; historial de decisión. |
| Facial | Cero/dos rostros, ángulos similares, fotografía/replay, reto usado/vencido, UUID ajeno. | Rechazo sin registro aprobado; referencia válida y protegida solo para titular autorizado. |
| Sesión y asistencia | Límites E, E+T, S, A; excepción; duplicado entrada/salida; evento directo sin verificación. | Estados correctos, conflictos controlados, tiempo confiable y ausencia de bypass. |
| Consultas y reportes | Mismo evento en matriz/historial/calendario/XLSX; filtros y rol ajeno. | Igualdad de valores, denominadores claros, 403 fuera de alcance y exportación exacta. |
| Notificaciones | Evento repetido, caída SMTP/push, sexto correo, 30 días, offline y solicitud facial. | Persistencia, no duplicados, límite y backoff/caché, decisión durable independiente de lectura. |
| Operación y calidad | Volúmenes establecidos, reconexión, recuperación y base nueva. | Umbrales verificables; versiones/configuración registradas; contratos y migraciones coincidentes. |

## 8.3 Evidencia requerida

- Resultado por caso con fecha, ejecutor, versión, datos de entrada, resultado esperado/obtenido y estado.
- Para seguridad: petición/respuesta y evidencia de que no hubo modificación o exposición indebida.
- Para rendimiento: volumen, condiciones, medición y percentiles cuando el criterio los requiera.
- Para persistencia/rollback: estado de base antes y después y comprobación desde otra sesión/dispositivo.
- Para biometría: condiciones de captura, resultado de calidad/vida y metodología aprobada; ninguna evidencia pública debe contener secretos o rostros sin autorización.

## 8.4 Regla de aceptación

Un requisito se marca Conforme únicamente cuando todas sus variantes aplicables satisfacen los criterios y la evidencia es consultable. Compilación, análisis estático o presencia de endpoint son verificaciones auxiliares. Una decisión pendiente que modifica el criterio se resuelve y versiona antes de la aceptación. La entrega académica del documento no equivale a habilitar un despliegue productivo.

# 9 Decisiones y restricciones de implantación

## DEC-01 Identidad y permisos del Coordinador de Registro

Mantenerlo como rol diferenciado, sin administración implícita. Definir operaciones permitidas y responsables de asignación.

**Responsable** Responsable académico/producto. **Requisitos** RF-3.3, RF-3.5, RNF-1.16. **Estado** Por validar institucionalmente.

## DEC-02 Activación y entrega de credenciales

No retornar contraseña al coordinador ni en CSV. Establecer activación de un uso o entrega protegida al titular compatible con la prohibición de contraseñas en correo ordinario.

**Responsable** Responsable de producto y seguridad. **Requisitos** RF-3.4, RNF-3.3, RNF-8.3. **Estado** Por validar institucionalmente.

## DEC-03 Contrato facial y protección del descriptor

Seleccionar un flujo oficial, modelo/dimensión/consolidación y diseño de búsqueda compatible con cifrado. No conservar imágenes. Definir claves, consentimiento, retención y eliminación de descriptores/auditoría.

**Responsable** Responsable técnico y de datos. **Requisitos** RF-5.1, RNF-5.3, RNF-5.4. **Estado** Por validar institucionalmente.

## DEC-04 Dispositivos y alcance offline

Definir estación fija/móvil, identidad de dispositivo y si Raspberry/offline integra la entrega operativa. Si se difiere, mantener RNF-5.7 en alcance futuro explícito.

**Responsable** Responsable académico y técnico. **Requisitos** RF-C2, RNF-5.6, RNF-5.7. **Estado** Por validar institucionalmente.

## DEC-05 Metas operativas

Aprobar horario, disponibilidad, volúmenes, RPO/RTO, copias y recuperación. No asignar porcentajes o compromisos no acordados.

**Responsable** Responsable de operación/producto. **Requisitos** RNF-1.13, RNF-2.6, RNF-2.12. **Estado** Por validar institucionalmente.

## DEC-06 Parámetros de seguridad y evaluación

Definir límite de códigos de recuperación, expiración/usos de re-registro, criterio de retraso grave y conjunto/métricas de validación biométrica. Registrar política antes de pruebas.

**Responsable** Responsable de seguridad y académico. **Requisitos** RF-1.4, RF-5.4, RNF-6.4. **Estado** Por validar institucionalmente.

## Restricciones de despliegue

La versión implantada deberá utilizar secretos externos al código y cliente público, conexiones protegidas, migraciones controladas y respaldo verificable. Los contratos biométricos antiguos no compatibles no se expondrán como flujo alternativo sin autorización. La aplicación no sustituirá una falla remota con datos o aprobaciones de demostración.

# 10 Glosario y referencias

| Término | Definición |
|---|---|
| SRS o ERS | Especificación de requisitos de software. |
| RF y RNF | Requisito funcional y requisito no funcional. |
| Ficha | Grupo académico vinculado a un programa; Chip en el código. |
| Aprendiz | Persona matriculada; posee UUID propio relacionado con la cuenta. |
| Sesión | Jornada de asistencia con ficha, ambiente, responsables, dispositivo y tiempos. |
| Descriptor o embedding | Representación numérica del rostro; dato biométrico que requiere protección. |
| Validación de vida | Evaluación de evidencia de captura real frente a fotografía/replay/suplantación. |
| Umbral | Similitud mínima para aceptar coincidencia; no es porcentaje de precisión del sistema. |
| Token | Credencial de sesión firmada, temporal y revocable. |
| RBAC y alcance | Permiso por rol más autorización sobre el recurso específico. |
| Commit y rollback | Confirmación o reversión de una transacción de cambios. |
| Idempotencia | Repetir una operación no produce efectos duplicados. |
| RPO y RTO | Objetivos de pérdida de datos y tiempo de recuperación que debe aprobar operación. |
| Baseline | Versión y configuración usadas como referencia de verificación. |

Referencias documentales: SRS_V3_completo_y_trazable (1).pdf, versión 3.0, 92 páginas; VALIDACION_SRS.md, revisión del 13 de octubre de 2026; repositorios locales FaceLit, FaceLit-Backend, FaceLit-DB y micro-facial. El documento previo cita IEEE 830 como orientación de estructura; esta versión no afirma una certificación normativa. Los lineamientos institucionales de datos, retención y operación se incorporan mediante las decisiones registradas. La justificación no conserva cifras estadísticas sin fuente verificable. Los nombres del equipo, instructor, programa y ficha proceden de la portada suministrada. Se omiten correos personales del equipo porque no son necesarios para evaluar la especificación.

# 11 Matriz de trazabilidad y estado actual

Las matrices RF/RNF y los hallazgos H01-H14 de esta sección reflejan la inspección del 13 de octubre de 2026. El documento de trazabilidad del 27 de octubre registra cambios posteriores, pero no contiene una revalidación individual de cada requisito. Por tanto, los estados de esta matriz son un baseline histórico y no deben interpretarse como estado certificado al 27 de octubre. El delta conocido y sus límites se documentan en la sección 12.3. Fecha de referencia 13 de octubre de 2026. La inspección local aporta estados Parcial, Brecha, Por probar, Por verificar o Sin evidencia. No existen estados Conforme certificados por esta revisión. Cada fila conserva el ID y enlaza el requisito con evidencia del componente y su caso CP. Las rutas del anexo son relativas a los repositorios para facilitar la lectura en otro equipo.

## 11.1 Accesos al sistema

Evidencia principal: FaceLit/shared/contexts/AuthContext.tsx; FaceLit-Backend/config/SecurityConfig.java, JwtFilter.java; auth/service/.../LoginServiceImpl.java y JwtServiceImpl.java.

| ID | Estado | Evidencia y pendiente | Prueba |
|---|---|---|---|
| RF-1.1 | Parcial | Documento/contraseña, hash, privacidad y sesión implementados; H02/H03. API también admite email: confirmar alcance aprobado. El contrato también admite correo, contrario a RNF-1.10. | CP-RF-1.1 |
| RF-1.2 | Brecha | Autorización por objeto incompleta y rutas solo protegidas por autenticación; H01/H14. | CP-RF-1.2 |
| RF-1.3 | Parcial | Rol desde servidor y redirección; discrepancias de roles/guards, H08/H14. | CP-RF-1.3 |
| RF-1.4 | Parcial | Recuperación con código, expiración, uso único y política; falta prueba integrada y limitación de intentos de código. | CP-RF-1.4 |

## 11.2 Gestión académica

Evidencia principal: FaceLit/features/academic/academicApi.ts; FaceLit-Backend/academic/service/.../CsvAcademicServiceImpl.java y UserChipServiceImpl.java; FaceLit-DB/01_ddl/03_tables/003_create_academic_tables.sql.

| ID | Estado | Evidencia y pendiente | Prueba |
|---|---|---|---|
| RF-2.1 | Parcial | CSV institucional, resumen y propuestas de traslado; contraseñas expuestas H06 y pruebas de carga/rollback pendientes. | CP-RF-2.1 |
| RF-2.1.1 | Por probar | Endpoint de plantilla y descarga presentes; validar guía, encabezados y mensajes con usuarios. | CP-RF-2.1.1 |
| RF-2.2 | Parcial | CRUD académico y credenciales implementados; H06/H07 y aceptación de ciclo de vida pendiente. | CP-RF-2.2 |
| RF-2.3 | Por probar | Traslado transaccional, destino activo/mismo programa e historial; falta ensayo de fallo y concurrencia. | CP-RF-2.3 |

## 11.3 Gestión de usuarios

Evidencia principal: FaceLit/app/admin/users; FaceLit-Backend/auth/service/.../UserManagementServiceImpl.java, InitialCredentialServiceImpl.java; auth/model/enums/RoleName.java.

| ID | Estado | Evidencia y pendiente | Prueba |
|---|---|---|---|
| RF-3.1 | Parcial | Listado/búsqueda real; validar filtros, estados, tiempos y paginación. | CP-RF-3.1 |
| RF-3.2 | Parcial | Gestión real; modificación de documento H07 y revocación H03. | CP-RF-3.2 |
| RF-3.3 | Brecha | Crea COORDINATOR en vez del rol diferenciado exigido; H08. | CP-RF-3.3 |
| RF-3.4 | Brecha | Generación y hash presentes; CSV expone contraseña H06. | CP-RF-3.4 |
| RF-3.5 | Brecha | No existe Coordinador de Registro en backend; H08. | CP-RF-3.5 |
| RF-3.6 | Parcial | Desactivación preserva entidades; token previo sigue válido H03. | CP-RF-3.6 |

## 11.4 Perfil y preferencias

Evidencia principal: FaceLit/app/profile; features/profile/useUserSettings.ts; FaceLit-Backend/auth/service/.../UserConfigurationServiceImpl.java; auth/model/enums/Language.java.

| ID | Estado | Evidencia y pendiente | Prueba |
|---|---|---|---|
| RF-4.1 | Parcial | Perfil propio conectado; máscara ausente H12 y tiempos por probar. | CP-RF-4.1 |
| RF-4.2 | Brecha | Preferencias conectadas; DE incompatible y notificaciones forzadas H14. | CP-RF-4.2 |

## 11.5 Reconocimiento facial

Evidencia principal: FaceLit/features/auth/hooks/useFacialRegistration.ts; FaceLit-Backend/facial/FacialEnrollmentController.java; micro-facial/app/services/facial_embedding_service.py y repositories/facial_embedding_repository.py.

| ID | Estado | Evidencia y pendiente | Prueba |
|---|---|---|---|
| RF-5.1 | Brecha | Registro por microservicio existe; contrato Java/DB y autorización desalineados H04/H05. | CP-RF-5.1 |
| RF-5.2 | Parcial | Sesión persistida, instructor original/reemplazo; validaciones incompletas H09. | CP-RF-5.2 |
| RF-5.3 | Brecha | No hay configuración institucional versionada del umbral; default efectivo 0.65, rango 0..1. | CP-RF-5.3 |
| RF-5.4 | Brecha | Solicitud local/decisión sin autorización durable H10. | CP-RF-5.4 |

## 11.6 Configuración de asistencia

Evidencia principal: FaceLit/features/environments/environmentSessionApi.ts; FaceLit-Backend/environment/service/.../EnvironmentServiceImpl.java y facial/service/.../FacialEventServiceImpl.java.

| ID | Estado | Evidencia y pendiente | Prueba |
|---|---|---|---|
| RF-6.1 | Parcial | Configuración y captura conectadas; horario/asignación y contrato de reemplazo por completar H09. | CP-RF-6.1 |
| RF-6.2 | Parcial | Tiempos persistidos, entrada/salida y clasificación; orden de ventana incompleto H09. | CP-RF-6.2 |

## 11.7 Consulta e historial

Evidencia principal: FaceLit/app/admin/attendance; app/apprentice/attendance.tsx; features/attendance/useAttendance.ts y useAttendanceRF6.ts; FaceLit-Backend/facial/service/.../FacialEventServiceImpl.java.

| ID | Estado | Evidencia y pendiente | Prueba |
|---|---|---|---|
| RF-7.1 | Parcial | Matriz y consultas por ficha reales; autorización H01 y aceptación visual/exportación por probar. | CP-RF-7.1 |
| RF-7.2 | Parcial | Matriz usada en consulta individual; búsqueda/alcance deben verificarse, H01. | CP-RF-7.2 |
| RF-7.3 | Brecha | Historial usa fuente local de asistencia H11. | CP-RF-7.3 |

## 11.8 Notificaciones

Evidencia principal: FaceLit/features/notifications/notificationsStore.ts; FaceLit-Backend/notification/controller/NotificationController.java y service/.../EmailDispatchServiceImpl.java.

| ID | Estado | Evidencia y pendiente | Prueba |
|---|---|---|---|
| RF-8.1 | Parcial | Catálogo/eventos persistidos; cobertura completa y deduplicación por probar H13. | CP-RF-8.1 |
| RF-8.2 | Parcial | Bandeja por destinatario/lectura conectadas; caché/retención pendientes H13. | CP-RF-8.2 |
| RF-8.3 | Parcial | Correo, estados y reintentos presentes; tiempo y límite horario pendientes H13. | CP-RF-8.3 |
| RF-8.4 | Brecha | Solicitud del aprendiz solo local; resolución incompleta H10. | CP-RF-8.4 |

## 11.9 Reportes y consultas

Evidencia principal: FaceLit/app/admin/reports y app/instructor/reports; features/attendance/types.ts; shared/utils/export.ts.

| ID | Estado | Evidencia y pendiente | Prueba |
|---|---|---|---|
| RF-9.1 | Brecha | Pantallas y exportación presentes, pero reportes usan fuente local H11. | CP-RF-9.1 |

## 11.10 Requisitos complementarios

| ID | Estado | Evidencia y pendiente | Prueba |
|---|---|---|---|
| RF-C1 | Parcial | Pantallas/lógica local y mocks; sin API persistente encontrada para horarios/excepciones. | CP-RF-C1 |
| RF-C2 | Parcial | Sesiones reales y parte del catálogo conectadas; CRUD local restante y validaciones H09. | CP-RF-C2 |
| RF-C3 | Brecha | Backend conectado; alemán y activación de notificaciones H14. | CP-RF-C3 |
| RF-C4 | Por probar | WebSocket cliente/servidor presente; alcance, cambios, reconexión y revocación H03 pendientes. | CP-RF-C4 |

## 11.11.1 RNF Accesos y seguridad

| ID | Estado | Evidencia y pendiente | Prueba |
|---|---|---|---|
| RNF-1.1 | Parcial | BCrypt/JWT presentes; transporte productivo sin verificar. | CP-RNF-1.1 |
| RNF-1.2 | Parcial | DTO de recuperación/cambio exige 8..15, mayúscula, número y símbolo; inicial aleatoria de 12. Probar todos los flujos. | CP-RNF-1.2 |
| RNF-1.3 | Brecha | Contador/bloqueo se guarda antes de excepción transaccional H02. | CP-RNF-1.3 |
| RNF-1.4 | Brecha | API facial sin permisos de operación/objeto H01; layouts H14. | CP-RNF-1.4 |
| RNF-1.5 | Brecha | Matriz de ficha accesible sin filtro de aprendiz H01. | CP-RNF-1.5 |
| RNF-1.6 | Parcial | Perfil propio y aceptación; API facial y biometría H05/H12. | CP-RNF-1.6 |
| RNF-1.7 | Parcial | Gestión de datos existe; inmutabilidad/documento H07 y auditoría por verificar. | CP-RNF-1.7 |
| RNF-1.8 | Parcial | Historial académico y sesiones; auditLogger cliente en memoria, fallos transaccionales H02. | CP-RNF-1.8 |
| RNF-1.9 | Parcial | Código numérico, caducidad y consumo; lookup global por token sin vincular solicitud/usuario, intentos y colisiones por probar. | CP-RNF-1.9 |
| RNF-1.10 | Brecha | La API admite email en LoginRequestDTO/LoginServiceImpl. La protección visual del correo se trata en RNF-4.2. | CP-RNF-1.10 |
| RNF-1.11 | Brecha | Token sin revocación/validación de sesión actual H03. | CP-RNF-1.11 |
| RNF-1.12 | Por probar | Medir 95% de logins en máximo 3 s. | CP-RNF-1.12 |
| RNF-1.13 | Por probar | Medir disponibilidad según horario y meta aprobados. | CP-RNF-1.13 |
| RNF-1.14 | Por probar | Pruebas de usabilidad y mensajes con usuarios. | CP-RNF-1.14 |
| RNF-1.15 | Parcial | Capas separadas; autorización efectiva debe alinearse H01/H14. | CP-RNF-1.15 |
| RNF-1.16 | Brecha | Cambiar rol no cambia permisos de tokens previos H03; guards H14. | CP-RNF-1.16 |

## 11.11.2 RNF Gestión académica

| ID | Estado | Evidencia y pendiente | Prueba |
|---|---|---|---|
| RNF-2.1 | Parcial | API académica restringida al coordinador; verificar alcance de GET disponibles al instructor. | CP-RNF-2.1 |
| RNF-2.2 | Parcial | DTO, unicidad y relaciones; inconsistencias adicionales H07/H09. | CP-RNF-2.2 |
| RNF-2.3 | Parcial | ChangeHistory académico; cobertura completa de operaciones y actores por probar. | CP-RNF-2.3 |
| RNF-2.4 | Parcial | Roles/hash presentes; CSV devuelve secretos H06. | CP-RNF-2.4 |
| RNF-2.5 | Por probar | Medir CSV de 500 filas en menos de 10 s e indicador de progreso. | CP-RNF-2.5 |
| RNF-2.6 | Por probar | Disponibilidad académica; SRS requiere definir horario/meta antes de aprobar. | CP-RNF-2.6 |
| RNF-2.7 | Por probar | Guía y resumen presentes; prueba con usuario no técnico pendiente. | CP-RNF-2.7 |
| RNF-2.8 | Parcial | Servicios comunes y validaciones; comparar CSV/manual con los mismos datos. | CP-RNF-2.8 |
| RNF-2.9 | Parcial | Restricciones únicas y validación; probar duplicados y carreras concurrentes. | CP-RNF-2.9 |
| RNF-2.10 | Por probar | Traslado @Transactional y saveAndFlush; inyección de fallo/concurrencia pendiente. | CP-RNF-2.10 |
| RNF-2.11 | Parcial | Decisiones CSV y ChangeHistory presentes; verificar vínculo a carga, motivo y datos anteriores/nuevos. | CP-RNF-2.11 |
| RNF-2.12 | Por probar | Cientos de fichas/miles de aprendices, umbrales aprobados y carga. | CP-RNF-2.12 |
| RNF-2.13 | Por probar | Carga @Transactional; interrupción/reproceso sin entidades parciales pendiente. | CP-RNF-2.13 |
| RNF-2.14 | Brecha | UTF-8 CSV presente; regex de edición admite tildes/ñ pero excluye ü/Ü exigidas. | CP-RNF-2.14 |

## 11.11.3 RNF Gestión de usuarios

| ID | Estado | Evidencia y pendiente | Prueba |
|---|---|---|---|
| RNF-3.1 | Por probar | Panel conectado; medir menos de 2 s con 500 usuarios. | CP-RNF-3.1 |
| RNF-3.2 | Parcial | Documento único; probar todas las altas y concurrencia. | CP-RNF-3.2 |
| RNF-3.3 | Brecha | Hash/generación presentes, pero retorno y exportación CSV H06. | CP-RNF-3.3 |
| RNF-3.4 | Brecha | Documento editable en servicios H07. | CP-RNF-3.4 |
| RNF-3.5 | Parcial | Notificaciones de cambio; no equivalen a auditoría íntegra con anterior/nuevo de cada campo. | CP-RNF-3.5 |
| RNF-3.6 | Brecha | Historial preservado por desactivación; token sigue funcionando H03. | CP-RNF-3.6 |
| RNF-3.7 | Parcial | Exportación presente; filtros, máscara, tiempo y alcance por probar. | CP-RNF-3.7 |

## 11.11.4 RNF Perfil y sesión

| ID | Estado | Evidencia y pendiente | Prueba |
|---|---|---|---|
| RNF-4.1 | Parcial | Perfil del principal conectado; datos actuales y carga <2 s por probar. | CP-RNF-4.1 |
| RNF-4.2 | Brecha | Correo sin máscara H12. | CP-RNF-4.2 |
| RNF-4.3 | Brecha | Logout local sin revocación y limpieza integral H03. | CP-RNF-4.3 |
| RNF-4.4 | Sin evidencia | No se encontró timeout de 30 min H03. | CP-RNF-4.4 |
| RNF-4.5 | Parcial | Perfil propio de lectura y edición administrativa; probar intentos directos de aprendiz/instructor. | CP-RNF-4.5 |

## 11.11.5 RNF Reconocimiento y privacidad biométrica

| ID | Estado | Evidencia y pendiente | Prueba |
|---|---|---|---|
| RNF-5.1 | Parcial | Microservicio rechaza cero/múltiples rostros; probar captura real en ambas plataformas. | CP-RNF-5.1 |
| RNF-5.2 | Parcial | Captura y chequeos presentes; demostrar calidad mínima real y rechazos. | CP-RNF-5.2 |
| RNF-5.3 | Parcial | Secuencias multiframe presentes; el micro consolida el último embedding. Ángulos distintos, <60 s y contrato H04 pendientes. | CP-RNF-5.3 |
| RNF-5.4 | Brecha | Vector sin cifrado de aplicación y flujo Java con foto H12. | CP-RNF-5.4 |
| RNF-5.5 | Brecha | SRS: default 0.6, rango 0.4..0.9 y coordinador; servicio: default 0.65, rango 0..1, sin panel/versionado. | CP-RNF-5.5 |
| RNF-5.6 | Parcial | HTTPS exclusivo, rechazo HTTP y firma digital no demostrados H12. | CP-RNF-5.6 |
| RNF-5.7 | Sin evidencia | Sin cola facial cifrada offline/Raspberry H13. | CP-RNF-5.7 |

## 11.11.6 RNF Asistencia y validaciones

| ID | Estado | Evidencia y pendiente | Prueba |
|---|---|---|---|
| RNF-6.1 | Parcial | Registro real y unicidad presentes; bypass directo H01 y <2 s por probar. | CP-RNF-6.1 |
| RNF-6.2 | Parcial | Clasificación real; rango 0..30, excepciones y <500 ms pendientes H09. | CP-RNF-6.2 |
| RNF-6.3 | Brecha | Modificación de excusa sin permiso del actor; no se encontró anulación coordinador con motivo H01. | CP-RNF-6.3 |
| RNF-6.4 | Sin evidencia | No se halló acumulado mensual/umbral configurable/alerta al cuarto retraso H13. | CP-RNF-6.4 |
| RNF-6.5 | Sin evidencia | Ruta directa existe, pero no flujo manual identificado y pendiente de aprobación H13. | CP-RNF-6.5 |

## 11.11.7 RNF Reportes y consultas

| ID | Estado | Evidencia y pendiente | Prueba |
|---|---|---|---|
| RNF-7.1 | Brecha | Matriz no restringe aprendiz a sus propios registros H01. | CP-RNF-7.1 |
| RNF-7.2 | Por probar | Consultas de 365 días y 40 aprendices/90 días <5 s, paginación máxima 50. | CP-RNF-7.2 |
| RNF-7.3 | Parcial | XLSX real presente; fuente local en reportes H11, igualdad/filtros y <5 s por probar. | CP-RNF-7.3 |
| RNF-7.4 | Parcial | Indicadores visuales presentes; umbral configurable y evaluación con datos reales no demostrados. | CP-RNF-7.4 |
| RNF-7.5 | Brecha | Calendario usa asistencia local H11; accesibilidad/tiempos pendientes. | CP-RNF-7.5 |

## 11.11.8 RNF Notificaciones y entrega

| ID | Estado | Evidencia y pendiente | Prueba |
|---|---|---|---|
| RNF-8.1 | Parcial | Algunos eventos/notificaciones persistidos; falta catálogo facial/offline completo, deduplicación y tiempos. | CP-RNF-8.1 |
| RNF-8.2 | Parcial | Servidor y lectura presentes; retención 30 días/caché durable 50 sin evidencia H13. | CP-RNF-8.2 |
| RNF-8.3 | Brecha | Sin máximo 5 correos por usuario/hora H13; revisar política sobre credenciales por correo. | CP-RNF-8.3 |
| RNF-8.4 | Brecha | Reintentos SMTP cada 5 min no satisfacen push 1/2/4 s H13. | CP-RNF-8.4 |

## 11.12 Registro de hallazgos de implementación

Las referencias H de las fichas y matrices corresponden a los hallazgos siguientes. Su detalle técnico se conserva en VALIDACION_SRS.md. Esta tabla permite interpretar la trazabilidad sin depender de ese archivo externo.

| ID | Diferencia observada | Acción necesaria |
|---|---|---|
| H01 | Rutas faciales exigen autenticación pero omiten alcance por aprendiz/ficha. Registro directo permite omitir verificación facial. | Proteger operación y objeto; separar automático/manual; verificar solicitudes directas. |
| H02 | Login guarda intentos fallidos dentro de transacción y después lanza RuntimeException; el rollback puede perder contador/bloqueo. | Persistir fallos de forma independiente y reproducir contra DB. |
| H03 | Logout elimina token local; firma/expiración no consultan revocación, estado actual ni rol vigente. Sin timeout de 30 min. | Revocar API y canal, verificar estado y limpiar datos locales. |
| H04 | Cliente usa micro facial; enrolamiento Java usa otro modelo/muestras y columnas ausentes de migraciones. | Unificar flujo, modelo, DTO y esquema desde una base nueva. |
| H05 | Micro facial usa clave común distribuida al cliente y acepta UUID sin vincularlo al usuario autenticado. | Autenticación y autorización por titular o acceso exclusivo del backend. |
| H06 | CSV devuelve contrasenasGeneradas y la interfaz contempla exportar el secreto. | Retirar de respuestas, panel, archivos y logs; entrega segura al titular. |
| H07 | Servicios de edición de usuario/aprendiz cambian documentNumber. | Rechazar cambio ordinario en interfaz y servidor. |
| H08 | Backend solo tiene APPRENTICE, INSTRUCTOR y COORDINATOR; falta el rol de registro exigido. | Resolver DEC-01 y alinear permisos en todas las capas. |
| H09 | Validación de salida no compara final de ventana; tolerancia no admite 0 ni limita 30; no demuestra horario/excepción. | Aplicar regla temporal completa, elegibilidad y calendario efectivo. |
| H10 | Solicitud facial se crea localmente; resolución remota solo marca lectura y devuelve decisión. | Solicitud/decisión durable y autorización temporal consumible. |
| H11 | Reportes, calendario e historial consultan eventos/horarios locales mientras matriz usa API real. | Fuente común persistente y prueba de igualdad entre vistas/XLSX. |
| H12 | Correo completo visible y vector legible; flujo Java contempla foto. Transporte/firma productivos sin certificar. | Máscara, protección de descriptor y eliminación de imagen; verificar TLS/integridad. |
| H13 | Sin cola facial offline ni alertas mensuales/manual aprobable; caché/retención/límite de correo/push incompletos. | Completar ciclo de asistencia, entrega, retención y operación offline. |
| H14 | Layouts usan guard de autenticación sin rol; DE no existe en enum/DB y notificationsActive se fuerza a true. | Conectar guard de rol; alinear catálogo y guardar preferencias reales. |

Ubicación Java: las familias config, auth, academic, facial, environment y notification se encuentran bajo FaceLit-Backend/src/main/java/com/FaceLit/backend. Las abreviaturas de las matrices identifican familias y clases dentro de esa raíz. Todos los estados requieren volver a verificarse después de cambiar código o configuración.

# 12 Cambios documentales y resultados de revisión

## 12.1 Correcciones respecto a la versión anterior

- Se conservan los 97 IDs y se corrigen referencias de numeraciones anteriores; RF-7.2 comparte reglas con RF-7.1, y traslado corresponde a RF-2.3.
- Se desarrolla RF-5.1 dentro del SRS maestro, sin depender de un documento de aprendiz no integrado.
- Se actualiza el baseline: existe captura multiframe y asistencia persistente; reportes e historial aún mantienen fuentes locales.
- Se separa el umbral del enrolamiento Java 0.45 del default de sesión del microservicio 0.65 y del requisito institucional 0.6.
- Se corrige RNF-1.10: trata el correo como identificador de login; el enmascaramiento corresponde principalmente a RNF-4.2.
- Se distingue alta administrativa sin contraseña en DTO del CSV que todavía devuelve/exporta secretos.
- Se resuelve la contradicción entre CSV con errores por fila y atomicidad técnica mediante clasificación de errores y commit conjunto.
- Se declara el rol de registro como diferente del rol administrativo y se registra su perfil pendiente; se evita atribuirle permisos inexistentes.
- Se armoniza la ventana de puntualidad y salida con tolerancia 0 a 30; horarios y excepciones son fuente requerida.
- Se mantiene la prohibición de almacenar imágenes y se explicita extracción transitoria; cifrado/búsqueda y entrega de credenciales requieren decisiones registradas.
- Se precisa que excusa es anotación y anulación es decisión auditada, sin sobrescribir el hecho.
- Se separan funciones requeridas, inventario actual, estados de prueba y compromisos institucionales.

## 12.2 Comprobaciones realizadas

| Comprobación | Resultado | Interpretación |
|---|---|---|
| Lectura documental | 92 páginas y página biométrica inspeccionada visualmente. | Fuente revisada, sin afirmar aceptación del producto. |
| Tipos de interfaz | tsc --noEmit completado con salida 0. | Tipos consistentes en la ejecución realizada. |
| ESLint | 9 errores y 90 advertencias. | Errores de react-hooks/use-memo en tres hooks; no son nueve fallos funcionales demostrados. |
| Tests Java | No ejecutados por dependencia local faltante de Surefire. | No consta resultado de aceptación ni fallo funcional de tests. |
| Tests Python | No ejecutados: pytest ausente y referencia de Python local problemática. | No consta resultado de las pruebas del microservicio. |
| Infraestructura | Motor Docker local no respondió. | No se certificó base desplegada ni flujo integrado. |

No se modificó código del producto como parte de esta consolidación documental. El cambio de especificación no elimina las brechas del baseline. La próxima validación deberá registrar los resultados de CP por requisito después de corregir implementación y configuración.

## 12.3 Actualización de estado al 27 de octubre de 2026

Esta actualización conserva intactos los requisitos V4.0 y añade el avance que consta en la trazabilidad del equipo. La inspección de código detallada de las matrices de la sección 11 tiene fecha 13 de octubre; los cambios siguientes no sustituyen una revisión requisito por requisito.

| Tema | Avance documentado al 27 de octubre | Alcance de la evidencia y siguiente validación |
|---|---|---|
| Retos de registro facial (HU-45) | Catálogo limitado a MOVE_UP, MOVE_DOWN, MOVE_CLOSER y MOVE_AWAY; se retiraron siete códigos. Los flujos descritos usan dos retos distintos y siete imágenes por reto. Se actualizaron pruebas y se reportó rechazo de códigos retirados. | Revalidar el comportamiento en los repositorios y relacionarlo con RF-5.1 y RNF-5.3. Dos retos de movimiento no demuestran por sí solos que se capturaron ángulos distintos ni que se cumplen los criterios de calidad, vida, privacidad y aceptación biométrica. |
| Alineación de esquema (H-50) | Se reporta coordinación de nombres de columnas y categorías con backend, cambios de expansión/contracción y rollback. El despliegue del 27 de octubre reporta 45 changesets. | Confirmar el esquema resultante desde una base limpia, la aplicación del rollback, integridad de datos y compatibilidad de todos los servicios. La cantidad de changesets no certifica recuperación ni aceptación funcional. |
| Despliegue | Se documentó la topología de Hostinger y sus controles técnicos. | Permanecen pendientes, según la trazabilidad, la aceptación manual del coordinador, CSV, SMTP y la comprobación física de cámara/asistencia. Desplegar un componente no demuestra el flujo integral ni disponibilidad medida. |
| Revisión de código asociada al corte | La trazabilidad identifica FaceLit 5f7d6fe, FaceLit-Backend 2ab0bcd, micro-facial 1e12c6c y FaceLit-DB 41a063f. | Son referencias de revisión reportadas; volver a verificar que cada SHA corresponda al artefacto evaluado antes de asignar estados actuales a RF/RNF. |

**Regla de actualización de estados**

- Mantener los 97 identificadores V4.0: 30 requisitos funcionales principales, 4 complementarios y 63 no funcionales.
- Para cada RF/RNF registrar el estado en el SHA inspeccionado, rutas/clases/esquema pertinentes, caso de prueba, resultado, ambiente, limitaciones, fecha y revisor.
- Conservar como parcial, brecha, por probar o por verificar todo requisito que no tenga evidencia de aceptación adecuada. La presencia de una pantalla, endpoint, migración o prueba aislada no equivale a aceptación integral.
- Mantener DEC-01 a DEC-06 pendientes hasta contar con la decisión responsable documentada. Los cambios de interfaz facial, esquema y despliegue no resuelven esas decisiones por sí mismos.

La fuente de este delta es el documento interno “Trazabilidad del SRS y backlog vigente”, corte 27 de octubre de 2026. Su detalle y las limitaciones señaladas deben conservarse al derivar manuales, anexos o presentaciones.

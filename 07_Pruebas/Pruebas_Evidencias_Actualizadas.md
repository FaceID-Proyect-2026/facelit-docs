# FaceLit — plan de pruebas y evidencia disponible

**Corte:** 27 de octubre de 2026.  
**Criterio:** cada resultado se asocia a la suite, rama/SHA, entorno y tipo de dependencia utilizado. Los conteos no se suman entre ejecuciones diferentes.

## Resultados de prueba reportados para los retos HU-45

| Área | Resultado reportado | Qué comprueba | Límite |
|---|---|---|---|
| micro-facial | 123 aprobadas; 1 prueba PostgreSQL optativa omitida | Retos activos, reglas de secuencia, señales sintéticas y rechazos | No implica que la prueba optativa omitida haya sido ejecutada |
| FaceLit frontend | 120 aprobadas en 13 suites; 6 scripts de regresión aprobados | Flujos de cliente seleccionados, tipos y lint de módulos afectados | Dependencias controladas; no certifica cámara física, SMTP ni todo el lint global |
| HTTP integrado | 19 comprobaciones específicas de retos: señales correctas, quietud, gesto incorrecto y rechazo de siete códigos retirados; además registro, confirmación, autorización, asistencia, matriz y CSV | Comunicación HTTP, JWT, reglas y persistencia contra base desechable con 45 migraciones | Inferencia facial determinista/controlada; correo simulado; no es prueba biométrica física |
| Despliegue Hostinger | HTTPS, salud de servicios, API, 401 sin autenticación y WebSocket 101 comprobados | Arranque, proxy, conectividad y configuración técnica | No equivale a aceptación con cuentas/CSV/cámara/correo reales |

Los resultados de 123 y 120 se reportan en RETOS_ACTIVOS_HU45_2026-10-27.md y la guía de sustentación. Son propios de la validación de los cuatro retos. Otros informes de ramas/fases anteriores presentan conteos distintos; no mezclarlos con esta tabla ni llamarlos una sola corrida.

## Alcance de la batería de retos

Se probaron los cuatro códigos activos: MOVE_UP, MOVE_DOWN, MOVE_CLOSER y MOVE_AWAY. Los flujos requieren dos retos distintos con siete capturas por reto. La batería rechaza los siete códigos retirados. Las señales usadas para pruebas lógicas son sintéticas; prueban reglas de aceptación/rechazo, no la tasa de acierto en personas/cámaras diversas.

## Escenario integrado

El escenario registrado usa rutas HTTP reales del frontend/backend/microservicio, autenticación JWT, SQL y PostgreSQL desechable. La inferencia es un fixture determinista y el correo se sustituye por un envío controlado/simulado. Entre los comportamientos reportados están registro facial, confirmación idempotente, control de autorización, asistencia, rechazo de duplicados, matriz e importación CSV. La navegación web se incluye en la verificación documentada.

Este escenario comprueba contratos y coordinación de componentes; no demuestra precisión del modelo con cámara real, entrega SMTP, uso móvil instalado ni rendimiento bajo carga.

## Despliegue y aceptación manual pendiente

El despliegue reportó respuesta 200 para la web y login, salud facial 200, rechazo 401 a endpoint administrativo sin autenticar y handshake WebSocket 101. Además, el backend inició con validación JPA y la migración dejó 45 changesets sin pendientes.

Pendiente de aceptación manual con evidencia nueva:

1. Login real del coordinador retenido en producción.
2. Carga CSV de datos autorizados de demostración y comprobación de relaciones creadas.
3. Entrega de correo SMTP, si se incluye en la sustentación.
4. Registro facial y asistencia con cámara física y usuario participante autorizado.
5. Confirmación de persistencia tras recargar la consulta.
6. Recorrido con el APK instalado en dispositivo, si se va a afirmar esa plataforma.
7. Restauración de un respaldo en entorno separado.
8. Resultado de CI/checks remotos para los SHA exactos publicados.

## Formato mínimo para registrar una nueva ejecución

Por cada corrida conservar:

- Identificador/fecha y responsable.
- Repositorio, rama y SHA de frontend, backend, servicio facial y DB.
- Comando o procedimiento y versiones de runtime.
- Entorno: unitario, base aislada, despliegue o físico.
- Datos de prueba no identificables.
- Resultado por caso: aprobado/fallido/omitido/bloqueado.
- Logs/artefactos con secretos y datos personales eliminados.
- Limitaciones: inferencia real/controlada, SMTP real/simulado, cámara física/sintética.
- Incidentes y decisión de aceptación.

## Redacción permitida para resultados

Decir: “Se aprobaron estas suites y este escenario en el entorno indicado; quedaron pendientes cámara física, correo real y aceptación manual.” No decir “todo el sistema está probado”, “100 % preciso”, “cero errores” ni asignar porcentaje de cobertura de producto a partir del número de pruebas.

## Fuentes de evidencia

- RETOS_ACTIVOS_HU45_2026-10-27.md y carpeta de evidencias four-challenges-hu45.
- GUIA_SUSTENTACION_FACELIT_ADSO_28_OCTUBRE_2026.md.
- DESPLIEGUE_HOSTINGER_2026-10-27.md y evidencia técnica del VPS.
- Informes de CI/PR asociados al SHA de cada repositorio.

La carpeta de esta actualización no duplica artefactos sensibles ni contiene respaldos, tokens, correos reales o fotografías faciales. Adjuntar reportes de pruebas redactados antes de la distribución final.

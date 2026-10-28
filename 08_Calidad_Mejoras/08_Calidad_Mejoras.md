# FaceLit

## Calidad, seguridad y mejoras

**Evidencia disponible y trabajo pendiente**

| Corte documental | Referencias de código |
|---|---|
| 27 de octubre de 2026 | FaceLit `5f7d6fe` (dev) · Backend `2ab0bcd` (dev) · micro-facial `1e12c6c` (dev) · FaceLit-DB `41a063f` (main) |

**Autores:** María José Rodríguez Oyola · Valery Sinaí Trujillo Quintero · Mariana Valenzuela Penagos
**Programa:** SENA · Análisis y Desarrollo de Software
**Instructor:** José de Jesús Motta

> Este informe separa controles observados, resultados automatizados reportados y aceptación manual pendiente. Las incidencias de cámara, persistencia y traducción fueron reportadas como corregidas por el equipo; su cierre formal exige repetir escenarios en la versión y dispositivos de sustentación.

---

## 1. Alcance de calidad y evidencia

FaceLit combina cliente Expo, backend Spring Boot, servicio facial FastAPI y PostgreSQL con pgvector. La calidad del recorrido depende de la interfaz de captura, la autorización del backend, la persistencia y la consulta posterior.

| Tipo de evidencia | Qué permite afirmar | Qué no demuestra |
|---|---|---|
| Inspección estática de código | Existen rutas, validaciones, estados, servicios y mecanismos de persistencia citados. Se contrastaron con el árbol actual de los cuatro repositorios. | No certifica ejecución en producción ni aceptación con usuarios. |
| Pruebas automatizadas reportadas | Las suites indicadas aprobaron sus casos en su entorno/control de dependencias descrito. | No miden precisión biométrica con cámaras/personas reales, SMTP o experiencia móvil completa. |
| Chequeos del despliegue | Servicios, rutas y protocolo responden en las comprobaciones técnicas reportadas. | No equivalen a aceptación manual del proceso de negocio. |
| Reporte del equipo | El equipo comunicó que cámara, registros incompletos y traducciones fueron corregidos. | Sin evidencia antes/después no permite establecer causa histórica, porcentaje de mejora o aprobación de regresión. |

> **Criterios:** funcionalidad y autorización; usabilidad de cámara; integridad y persistencia; confiabilidad ante fallos/reintentos; internacionalización; rendimiento medido; privacidad biométrica; mantenibilidad y trazabilidad.

---

## 2. Incidencias y mecanismos actuales

### Cámara y captura

**Reporte:** el equipo informó que resolvió dificultades para visualizar y utilizar la cámara.

**Mecanismos observados:** en web, `WebCamera.tsx` solicita cámara frontal (640 × 480), gestiona permiso/error, muestra guía y advertencias, analiza muestras de imagen periódicamente y libera pistas al cerrar. En móvil, el hook usa `CameraView` y `takePictureAsync`. Las heurísticas de luz/estabilidad no prueban que exista un rostro ni certifican detección antifraude. La lógica web y móvil no es idéntica.

### Registro y persistencia

El hook de registro comprueba captura/estado y espera `registerFacialEmbeddingFromImage` antes de presentar éxito remoto. El servicio cliente envía a `POST /api/facial/embeddings/from-image` de Spring; Java coordina FastAPI. El fallback local es opcional y está desactivado por defecto. FastAPI confirma transacción o ejecuta rollback ante error. Esto respalda el flujo implementado, pero no demuestra que todo dato histórico esté completo.

### Traducciones

El cliente configura i18next/react-i18next y recursos para español, inglés, alemán y francés. Los componentes citados usan claves traducibles. La existencia de recursos y fallback español no garantiza que cada clave esté completa o lingüísticamente revisada en las cuatro lenguas. El reporte del equipo indica que corrigió las pantallas afectadas; falta evidenciar regresión por idioma y pantalla.

### Antes/después

| Área | Mecanismo o mejora reportada | Verificación necesaria |
|---|---|---|
| Cámara | Permisos, estados, guía visual y limpieza del stream. | Web y Android: permiso denegado, baja luz, rotación, reintento y cierre. |
| Registro | Espera respuesta del backend, estado de envío, manejo de error y persistencia en servicio. | Confirmar consulta tras recarga; probar fallo de red/servidor y duplicación. |
| Idioma | Recursos centralizados y cambio de idioma mediante i18n. | Revisar cobertura, interpolaciones, textos largos y cortes en cuatro idiomas. |

---

## 3. Pruebas y resultados reportados

Los siguientes resultados corresponden a ejecuciones separadas; no se suman como una única corrida.

| Ejecución | Resultado | Alcance y límite |
|---|---|---|
| micro-facial | 123 aprobadas; 1 prueba PostgreSQL optativa omitida. | Retos activos, secuencia, señales sintéticas y rechazos. No valida la prueba omitida ni precisión en personas reales. |
| Frontend FaceLit | 120 aprobadas en 13 suites; 6 scripts de regresión aprobados. | Flujos seleccionados, tipos y lint en módulos afectados. No certifica cámara física, SMTP ni lint global. |
| Integración HTTP | 19 comprobaciones de retos más registro, confirmación, autorización, asistencia, matriz y CSV. | Rutas HTTP y PostgreSQL desechable con 45 migraciones; inferencia determinista y correo simulado. |
| Producción Hostinger | HTTPS/web 200; health facial 200; API admin sin auth 401; WebSocket 101. | Salud y configuración técnica; no aceptación de login/CSV/cámara/correo reales. |

> HU-45 mantiene cuatro retos: `MOVE_UP`, `MOVE_DOWN`, `MOVE_CLOSER` y `MOVE_AWAY`. La secuencia requiere dos retos distintos con siete capturas por reto. Las señales de pruebas son sintéticas; prueban reglas de aceptación/rechazo, no FAR/FRR. El umbral 0.65 es similitud, no 65 % de precisión.

### Incidencia de integridad en asistencia

El índice único parcial `uq_facial_event_attendance_once` en FaceLit-DB evita eventos activos duplicados para la combinación contemplada por la migración. La migración documenta limpieza de duplicados existentes antes de crear el índice. Su presencia en el repositorio no demuestra aplicación en toda instancia; verificar versión de Liquibase y probar inserción duplicada en QA.

---

## 4. Seguridad, privacidad y riesgos

| Riesgo / límite | Estado y tratamiento |
|---|---|
| Evaluación biométrica | No se presentó estudio representativo de falsas aceptaciones/rechazos ni bajo diversidad de cámaras, luz o participantes. Los retos no certifican resistencia a suplantación. |
| Datos faciales | Confirmar aviso, consentimiento/base de autorización, finalidad, accesos, retención, eliminación y respuesta a incidentes. Un embedding no debe describirse como anónimo. |
| Configuración del frontend | README conserva `EXPO_PUBLIC_EMBEDDING_API_URL` y `API_KEY` como referencias heredadas. El código revisado usa API de Spring; retirar referencias y verificar bundle antes de afirmar que no hay exposición. |
| Secretos | Revisar configuración de producción y rotar credenciales si se expusieron. No incluir valores, tokens o capturas con datos personales en documentación. |
| Backups | Restauración en entorno separado pendiente. Crear un respaldo no prueba que sea recuperable. |
| Producción y dispositivos | Aceptar login real, carga CSV, correo SMTP real, cámara/asistencia físicas y APK en el dispositivo exacto si se declara esa plataforma. |
| Rendimiento y disponibilidad | No hay medición formal de latencia/carga ni evidencia que sustente tiempos máximos o disponibilidad. |
| SRS y CI | Revisar requisito por requisito y checks remotos para SHA exactos; una ejecución antigua o un workflow presente no prueba aprobación de la versión final. |

> **Controles reportados:** JWT, hash BCrypt, autorización por rol/alcance, secreto facial en configuración privada del VPS, Caddy/HTTPS y servicios internos en red Docker; migraciones Liquibase coordinadas y respaldo previo. Son controles observados/reportados, no una certificación de ausencia de vulnerabilidades.

---

## 5. Mejoras priorizadas y cierre

| Prioridad | Trabajo | Criterio de cierre |
|---|---|---|
| Alta | Evaluación de biometría y retos con datos autorizados y condiciones diversas. | Protocolo, muestra, criterios y métricas FAR/FRR/errores documentados. |
| Alta | Medir latencia por captura, transporte, inferencia y persistencia. | Medición repetible con equipo/carga definidos; no prometer antes de medir. |
| Alta | Completar aceptación manual en producción. | Login, CSV, SMTP, cámara, evento persistido y consulta con evidencia. |
| Alta | Probar restauración y revisar credenciales/endpoints. | Restauración verificada en entorno separado; bundle, permisos, límites y rotación revisados. |
| Media | Actualizar trazabilidad SRS y validar APK/dispositivos. | Estado por requisito con criterio/evidencia/responsable; artefacto exacto instalado y probado. |
| Continua | Refactorizar por responsabilidad preservando contratos. | Cambios revisados y pruebas del flujo afectado; no usar reducción de líneas como métrica de calidad. |

### Registro de cada nueva validación

Guardar fecha/responsable, repositorios y SHA, comando/procedimiento, entorno, datos de prueba no identificables, resultado por caso, logs redactados, tipo de cámara/inferencia/correo y limitaciones. No mezclar conteos de ramas o fases distintas.

---

**Conclusión.** El código actual proporciona mecanismos para guiar captura, esperar confirmación remota, manejar errores y centralizar traducciones. El equipo reporta las tres incidencias corregidas y hay suites automatizadas aprobadas en los alcances descritos. El cierre requiere regresión manual, persistencia confirmada y evidencias del SHA que se presentará; no se afirma precisión biométrica, rendimiento ni aceptación completa.

**Referencias internas:** `Calidad_Seguridad_Mejoras_Actualizadas_2026-10-27.md`; `Pruebas_Evidencias_Actualizadas.md`; `Implementacion_Realizada_2026-10-27.md`; código de FaceLit, FaceLit-Backend, micro-facial y FaceLit-DB en los SHAs de portada.

# FaceLit — Orden de trabajo de las observaciones de Valery

**Alcance:** observaciones 1, 2, 3, 13, 16, 18 y 19.  
**Orden propuesto:** 1 → 2 → 3 → 18 → 19 → 16 → 13.  
**Estado:** planificación para revisión del equipo.

## 1. Observación 1 — Términos y tratamiento de datos

Empezar por identificar qué datos recoge FaceLit, para qué los utiliza, quién puede consultarlos, cuánto tiempo se conservan y cómo solicitar su corrección o eliminación. Separar términos de uso, aviso general y autorización biométrica.

**Entregables:** inventario de datos, matriz de accesos por rol, propuesta de conservación, documentos con versión y diseño del registro de decisiones.

**Repositorios:** `facelit-docs`, `FaceLit`, `FaceLit-Backend`, `FaceLit-DB`; revisar `micro-facial` para conocer el tratamiento real de imágenes y plantillas.

## 2. Observación 2 — Información previa y fecha de nacimiento en CSV

Definir cómo coordinación informa a las personas antes de crear sus cuentas. Incorporar la fecha de nacimiento al CSV como dato de referencia, validando formato y valores por fila. La importación no autoriza biometría ni clasifica previamente al aprendiz por edad.

Si el dato institucional está equivocado, el aprendiz solicita su corrección a coordinación mediante el procedimiento administrativo correspondiente.

**Entregables:** comunicación previa, CSV actualizado, validación y vista previa de importación, persistencia de fecha de nacimiento e instructivo de corrección.

**Repositorios:** `FaceLit`, `FaceLit-Backend`, `FaceLit-DB`, `facelit-docs`.

## 3. Observación 3 — Registro biométrico voluntario

Antes de abrir la cámara, solicitar la fecha de nacimiento al aprendiz y compararla en el servidor con la fecha importada desde el CSV.

1. Si no coincide o falta el dato de referencia, detener el enrolamiento y orientar al aprendiz a coordinación.
2. Si coincide, calcular la edad actual.
3. Si es adulto, solicitar su autorización biométrica personal.
4. Si es menor, completar el procedimiento institucional verificable de autorización de su representante legal y registrar que se escuchó la opinión del aprendiz. La vinculación de un adulto por sí sola no autoriza el tratamiento.
5. Si rechaza, deja la decisión pendiente o falta la autorización requerida, no abrir la cámara. La asistencia sin biometría se registra por el instructor mediante el procedimiento institucional, como el checklist.
6. Registrar quién decidió, qué decidió, fecha y hora, y versión del documento. Validar las condiciones también en backend antes del enrolamiento y del uso facial.

La coincidencia entre fechas confirma consistencia con la ficha institucional; no verifica por sí sola identidad ni representación legal. Definir con la institución cómo se acredita la representación.

Al cumplir 18 años, solicitar la decisión propia del aprendiz conforme al procedimiento de transición aprobado, sin asumir que la autorización anterior habilita automáticamente el uso facial. Conservar trazabilidad de las decisiones previas.

**Entregables:** flujo previo a cámara, cotejo de fechas, cálculo de edad, decisiones diferenciadas, procedimiento para menores, controles de servidor y revocación.

**Repositorios:** `FaceLit`, `FaceLit-Backend`, `FaceLit-DB`, `micro-facial`, `facelit-docs`.

**Dependencia del equipo:** Valery implementa el consentimiento y la orientación; el checklist y su registro por el instructor corresponden al trabajo de la compañera.

## 4. Observación 18 — Confirmación antes de desactivar o eliminar

Mostrar un modal que identifique al usuario y explique la acción real sobre su acceso, sesiones, relaciones e historial. Si el endpoint desactiva, el mensaje debe decir desactivar. Cancelar no modifica datos.

**Entregables:** modal, mensajes coherentes, manejo de errores y resumen de impacto cuando corresponda.

**Repositorios:** `FaceLit`; `FaceLit-Backend` para calcular impacto o reforzar reglas. `FaceLit-DB` solo si hace falta nueva auditoría o cambios de relaciones.

## 5. Observación 19 — Resolver asignaciones de instructores

Consultar fichas, programas y sesiones futuras de instructores específicos y transversales. Permitir a coordinación resolver las asignaciones antes de desactivar la cuenta. Mantener la atribución de sesiones y asistencias pasadas al instructor original.

**Entregables:** consulta de dependencias, pantalla de impacto, reasignación o cierre autorizado, validación transaccional y auditoría.

**Repositorios:** `FaceLit`, `FaceLit-Backend`, `FaceLit-DB`, `facelit-docs`.

**Dependencia:** integrar el resultado con el modal del punto 18.

## 6. Observación 16 — Avisos y conservación

Mostrar advertencia sobre el vencimiento de notificaciones a coordinación, instructores y aprendices. Implementar eliminación de notificaciones a los 30 días y asistencia a los seis meses una vez definidos y aprobados los datos incluidos y el inicio del cómputo.

Antes de borrar, revisar relaciones, reportes, logs de correo, historial y políticas institucionales. Definir qué ocurre con respaldos y copias locales. Mantener reglas de vencimiento centralizadas entre API, tarea periódica e interfaz.

**Entregables:** advertencia para los tres roles, reglas de conservación documentadas, tarea periódica de purga, tratamiento de dependencias y actualización de cachés.

**Repositorios:** `FaceLit`, `FaceLit-Backend`, `FaceLit-DB`, `facelit-docs`.

**Dependencia:** coordinar con quienes desarrollen las observaciones 15 y 17 para evitar reglas contradictorias de conservación.

## 7. Observación 13 — Descarga Android

Confirmar la versión oficial del APK, publicarla en un alojamiento institucional estable y añadir el acceso de descarga en FaceLit. Mostrar versión y fecha y definir quién actualiza el archivo.

**Entregables:** APK oficial publicado, enlace accesible e instructivo de instalación.

**Repositorios:** `FaceLit`, configuración de compilación/publicación Android y `facelit-docs`; alojamiento institucional para el archivo.

Este punto puede adelantarse de manera independiente si el APK oficial ya está disponible.

## Distribución orientativa en cuatro días

| Día | Trabajo principal | Resultado esperado |
|---|---|---|
| 1 | Puntos 1 y 2 | Documentos para revisión, acuerdos de datos y CSV con fecha de referencia |
| 2 | Punto 3 | Flujo de autorización y cotejo conectado con backend y base de datos |
| 3 | Puntos 18 y 19 | Confirmación y resolución de asignaciones de instructores |
| 4 | Puntos 16 y 13; integración | Avisos, conservación aprobada, descarga e integración de entregables |

La distribución es una estimación de trabajo, no una garantía de producción en cuatro días. La autorización de menores, los plazos de eliminación y el APK requieren decisiones o recursos institucionales. Confirmarlos desde el primer día para evitar bloqueos.

## Primera tarea concreta

Revisar el punto 1 contra el código y la base de datos: inventariar los datos reales, identificar los textos actuales y preparar la propuesta de documentos y conservación para revisión institucional.

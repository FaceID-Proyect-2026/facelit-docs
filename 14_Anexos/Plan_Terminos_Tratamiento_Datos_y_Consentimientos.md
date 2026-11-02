# FaceLit — Plan para términos, privacidad y consentimientos

**Estado:** propuesta de análisis y planificación; pendiente de decisiones institucionales y validación jurídica.  
**Fecha:** 29 de octubre de 2026  
**Responsable de elaboración:** Valery (según asignación del equipo)

## 1. Propósito

Definir cómo diseñar, presentar, registrar y mantener los textos y decisiones de autorización para el uso de FaceLit, incluyendo personas adultas y menores de edad. El proyecto trata información personal y contempla reconocimiento facial, por lo que no basta con redactar un texto: también deben definirse el flujo de consentimiento, las alternativas, la evidencia que se conserva y las reglas de tratamiento de los datos.

Este documento es un plan funcional y académico. No constituye asesoría ni aprobación jurídica. Los textos destinados a usuarios deben revisarse con la institución responsable y con asesoría jurídica antes de publicarse.

## 2. Situación identificada en el proyecto

- La aplicación presenta una pantalla llamada **“Aviso de privacidad”** durante el acceso. El contenido menciona identificación, control de asistencia con datos biométricos, reportes y notificaciones.
- En el código y en la base de datos la decisión se denomina **aceptación de términos**. El modelo actual guarda principalmente un indicador booleano `accepted` ligado al usuario y fechas de auditoría.
- El registro actual no identifica de forma suficiente qué documento y versión aceptó la persona, ni separa la autorización general de tratamiento de datos de una autorización biométrica específica.
- El aviso menciona biometría, pero aún deben confirmarse aspectos operativos como datos faciales almacenados, finalidad detallada, accesos, conservación, eliminación y alternativa no biométrica.
- La frase del mensaje posterior a la aceptación que traslada al usuario la responsabilidad de no haber leído el aviso debe revisarse. La aceptación no sustituye el deber de informar ni las responsabilidades del responsable del tratamiento.

Referencias internas: `FaceLit/shared/i18n/locales/es.ts`, `FaceLit/features/auth/components/PrivacyNoticeModal.tsx`, `FaceLit-Backend/.../LoginServiceImpl.java` y `FaceLit-DB/01_ddl/03_tables/006_create_legal_tables.sql`.

## 3. Objetivo de diseño

Mantener separados los siguientes elementos:

1. **Términos de uso:** reglas de uso de la plataforma, alcance del servicio, responsabilidades, soporte y manejo de cuentas.
2. **Aviso y autorización general de tratamiento:** datos personales tratados, finalidades, responsable, derechos y canales para ejercerlos.
3. **Autorización específica y opcional para biometría facial:** datos biométricos concretos, finalidad, funcionamiento, riesgos relevantes, conservación y alternativa disponible.

La aceptación de los términos de uso no debe interpretarse automáticamente como autorización para el tratamiento de datos biométricos. La decisión sobre biometría debe ser independiente, expresa, informada y verificable. Rechazarla no debe impedir el acceso a funciones esenciales si existe una alternativa funcional aprobada.

## 4. Estrategia para personas adultas

En el primer acceso o cuando cambie sustancialmente un documento:

1. Presentar el aviso general en lenguaje claro, con acceso al texto completo.
2. Solicitar por separado la aceptación de los términos de uso y la autorización general de tratamiento, según lo que determine la institución.
3. Presentar una decisión independiente para el uso de reconocimiento facial. Explicar que es opcional y describir el método alternativo disponible.
4. Permitir consultar los documentos antes de decidir. No preseleccionar las casillas ni interpretar el silencio como aceptación.
5. Confirmar cada decisión y registrar la versión exacta del texto mostrada.
6. Proporcionar una ruta para consultar, actualizar, rectificar o solicitar supresión de datos, así como para retirar una autorización cuando corresponda.

## 5. Estrategia para menores de edad

El flujo de menores requiere garantías reforzadas y no debe tratarse como una simple variante de la pantalla para adultos:

1. Definir cómo se identifica que la persona es menor y cómo se deriva al proceso de autorización del representante legal, evitando recolectar datos excesivos para esa verificación.
2. Explicar el tratamiento al menor con lenguaje adecuado a su edad y permitir que exprese su opinión antes de solicitar la autorización del representante.
3. Obtener del representante legal la autorización para el tratamiento general que corresponda y documentar la verificación de su representación.
4. Solicitar por separado la autorización biométrica opcional. Si no se concede, ofrecer la alternativa institucional aprobada.
5. Registrar que se escuchó al menor y cómo se valoró su opinión, con acceso restringido a esa evidencia.
6. Definir quién puede ejercer los derechos del menor, cómo se verifica esa identidad y cómo se tramita la actualización, supresión o revocación.
7. Revisar qué ocurre al cumplir 18 años: informar al titular y definir si se requiere una nueva autorización directa, especialmente para el tratamiento biométrico.

La autorización del representante no elimina la necesidad de justificar el tratamiento ni convierte el reconocimiento facial en obligatorio o automáticamente apropiado.

## 6. Decisiones que el equipo debe cerrar antes de redactar

| Tema | Decisión requerida |
|---|---|
| Responsable | Nombre legal de la entidad responsable, datos de contacto y canal de consultas/reclamos. |
| Datos | Inventario real: identificación, contacto, imágenes, plantillas/embeddings faciales, registros de asistencia, dispositivo y metadatos. Diferenciar imagen de plantilla biométrica. |
| Finalidades | Justificar cada finalidad concreta y asociarla solo a los datos necesarios. Confirmar si estadísticas se hacen con datos identificables o anonimizados. |
| Biometría | Confirmar si se conserva imagen facial, plantilla biométrica o ambas; dónde se procesan y almacenan; quién accede; proveedores o encargados involucrados. |
| Alternativa | Definir y probar el método no biométrico para registro/control de asistencia y sus responsables. Debe estar disponible para adultos y menores que no autoricen biometría. |
| Retención | Plazo por categoría de dato, criterio que lo determina, eliminación o anonimización y tratamiento de copias de respaldo. |
| Derechos | Canal, responsable y procedimiento para consultas, actualización, rectificación, prueba de autorización, supresión y revocación. |
| Menores | Método proporcional para verificar representante legal, constancia de autorización y mecanismo para escuchar al menor. Evitar pedir documentos o datos no indispensables. |
| Cambios | Determinar qué cambios requieren nueva información o autorización y cómo se bloquean usos no cubiertos por la versión aceptada. |
| Operación | Procedimiento para incidentes, acceso interno, trazabilidad y atención de solicitudes relacionadas con datos faciales. |

No completar los documentos con supuestos. Las respuestas deben corresponder al comportamiento real del backend, el servicio biométrico, la base de datos y la operación institucional.

## 7. Registro técnico propuesto

Reemplazar la aceptación booleana aislada por un registro auditable y versionado. Como mínimo, evaluar estos campos:

- usuario titular al que se refiere el registro;
- tipo de documento/decisión: términos de uso, tratamiento general o biometría;
- identificador y versión del documento, fecha de vigencia y, preferiblemente, huella del contenido publicado;
- decisión (aceptó/rechazó) y fecha/hora;
- canal o mecanismo mediante el que se obtuvo;
- para menores, identidad del representante, relación declarada/verificada y referencia a la evidencia de representación;
- constancia de que se explicó el tratamiento al menor y se escuchó su opinión;
- fecha, motivo y actor de una revocación o actualización posterior.

Aplicar controles de acceso y retención a los datos de autorización. Evitar conservar copias de documentos de identidad del representante si no existe necesidad justificada, una base de tratamiento y medidas de seguridad aprobadas.

## 8. Documentos que se producirán

1. **Términos de uso de FaceLit para adultos.**
2. **Términos de uso explicados para menores**, junto con la información necesaria para sus representantes.
3. **Aviso y autorización general de tratamiento**, con lenguaje claro y sección específica para menores/representantes.
4. **Autorización expresa para datos biométricos**, separada, opcional y con alternativa no biométrica descrita.
5. **Procedimiento interno** para verificar autorizaciones, atender derechos, revocaciones, cambios de versión y eliminación de datos.

Los textos para menores deben ser comprensibles para ellos, pero la autorización legal del tratamiento debe seguir el mecanismo aprobado para el representante legal. Un texto simplificado no sustituye esa autorización.

## 9. Fases de implementación

### Fase A — Levantamiento

Mapear los datos desde la captura hasta la eliminación. Revisar cliente, backend, servicio de reconocimiento facial, base de datos, logs, proveedores y roles con acceso.

### Fase B — Decisiones institucionales

Completar la tabla de decisiones de la sección 6. Definir responsable, finalidades, alternativa no facial, conservación, derechos y proceso de menores.

### Fase C — Redacción y validación

Preparar los documentos de la sección 8 en español claro. Validarlos con la entidad responsable, el equipo técnico y asesoría jurídica colombiana. No presentar el borrador académico como texto legal aprobado.

### Fase D — Diseño funcional y técnico

Diseñar pantallas separadas, control de versiones, registro granular de decisiones y manejo de menores/representantes. Asegurar que rechazar biometría permita el flujo alternativo acordado.

### Fase E — Implementación y verificación

Actualizar cliente, API y persistencia. Verificar los recorridos de primera aceptación, aceptación previa, rechazo biométrico, uso de alternativa, cambio de versión, autorización por representante, mayoría de edad y revocación.

## 10. Criterios de aceptación del trabajo

- Los términos de uso, el aviso general y la autorización biométrica son piezas identificables y separadas.
- La decisión biométrica es opcional, explícita y no se obtiene por silencio ni por casilla premarcada.
- Existe una alternativa no biométrica definida y usable antes de afirmar que la biometría es opcional.
- El proceso de menores incluye autorización verificable del representante y constancia de que se escuchó al menor.
- El sistema puede demostrar qué versión se presentó, quién decidió, qué decidió y cuándo.
- Los textos describen el tratamiento real y especifican contacto, derechos, finalidades, conservación y eliminación aprobados.
- Los cambios sustanciales de documentos no quedan invisibles para quienes ya aceptaron versiones anteriores.
- La institución y asesoría jurídica han revisado los textos antes de su publicación.

## 11. Referencias normativas para validación

- [Ley 1581 de 2012 — Gestor Normativo de Función Pública](https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?africa=1&i=49981): datos sensibles, autorización, deber de información y derechos del titular.
- [Decreto 1377 de 2013 — Gestor Normativo de Función Pública](https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=53646): mecanismos de autorización, datos sensibles y reglas especiales para niñas, niños y adolescentes.
- [Política de tratamiento de datos personales de la SIC](https://sedeelectronica.sic.gov.co/politica-de-tratamiento-de-datos-personales): orientación de la autoridad sobre derechos y tratamiento de datos de menores.
- [Concepto de la SIC sobre tratamiento excepcional y autorización del representante legal](https://sedeelectronica.sic.gov.co/publicaciones/boletin-juridico/concepto/tratamiento-excepcional-y-autorizacion-del-representante-legal-con-interes-superior): orientación sobre interés superior, derechos fundamentales y escucha del menor.

Las referencias sirven para orientar la revisión. La institución debe verificar vigencia, aplicabilidad y normativa complementaria antes de aprobar los textos y el flujo.

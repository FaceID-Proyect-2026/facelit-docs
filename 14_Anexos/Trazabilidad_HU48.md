# Trazabilidad de la revisión HU-48

Los puntajes corresponden a la evaluación del 30 de octubre de 2026. La evidencia de esta tabla registra avances de revisión. Los puntajes se actualizan al aplicar nuevamente los criterios de evaluación.

| Dimensión y puntaje original | Repositorio y rama | Cambio para revisar | Evidencia y pendiente |
| --- | --- | --- | --- |
| D3 · Arquitectura y congruencia · 58 | micro-facial · `hu-48-dev` | `GeneratedEmbedding` pasa al dominio y el puerto de aplicación usa ese tipo. | 148 pruebas aprobadas en un contenedor aislado. Queda la integración opcional con PostgreSQL. |
| D9 · API y contratos · 55 | FaceLit-Backend · `hu-48-dev` | OpenAPI describe las respuestas de registro facial y comprobación de vida. | 2 pruebas aprobadas en `OpenApiContractIntegrationTest`. |
| D4 · Calidad de código · 67 | FaceLit · `hu-48-dev` | La ruta de inicio de sesión delega en la pantalla. Los estilos y la animación quedan separados. | TypeScript aprobado y 131 pruebas Jest aprobadas para esta refactorización. |
| D10 · Frontend y móvil · 50 | FaceLit · `hu-48-dev` | Roles accesibles, estado de carga y alertas en el inicio de sesión. | TypeScript aprobado. Pendiente validar con lectores de pantalla en web y móvil. |
| D7 · DevOps y despliegue · 49 | FaceLit-Backend · `hu-48-dev` | El workflow manual de publicación exige la CI y registra el digest de la imagen. | YAML y dependencia entre trabajos comprobados localmente. Pendiente ejecución en GitHub. |
| D12 · Documentación y trazabilidad · 44 | FaceLit-DB · `hu-48-main` | El README vincula decisiones, identificadores de migración y procedimientos de verificación. | Enlaces locales comprobados. |
| D13 · Proceso y colaboración · 68 | facelit-docs · `codex/hu-48-docs` | Esta matriz consolida alcance, evidencia y pendientes por dimensión. | Pendiente revisión del equipo. |
| D14 · Extremo a extremo · 50 | Transversal | Revisión de evidencia disponible. | 30 de 30 casos marcados en el checklist de una revisión local anterior. Las ramas actuales cuentan con verificaciones por componente. |

Los cambios de esta revisión están en los árboles locales. Al abrir cada PR, vincular la fila correspondiente, el commit revisado y la ejecución de CI o el resultado local. Registrar la decisión del equipo y cualquier comprobación pendiente en el mismo PR.

## D14 · Alcance de la evidencia

La usuaria reportó haber completado los 30 casos del checklist manual de CSV, cámara y asistencia en una revisión local anterior. Ese resultado se conserva como antecedente, sin una referencia confirmada a los commits de las ramas recreadas.

Las verificaciones de Python, OpenAPI, Jest y TypeScript respaldan cambios concretos de la revisión actual. La prueba `ArchitectureFlowPostgresIT` pasó con los cambios locales actuales del backend y de micro-facial. Usó HTTP entre ambos servicios, PostgreSQL temporal con 44 migraciones e inferencia con datos controlados. Comprobó registro facial y asistencia. La cámara física queda fuera de esta ejecución. La evidencia local corresponde a la ejecución `facelit-arch-e2e-4145f465`.

Se conserva el puntaje original de 50. Los flujos del informe original quedan fuera del alcance de la revisión.

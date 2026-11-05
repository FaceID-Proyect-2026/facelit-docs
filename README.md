# FaceLit — documentación del proyecto

Repositorio documental del sistema FaceLit para la gestión académica y el control de asistencia con reconocimiento facial. La entrega se organiza en las 17 secciones numeradas del proyecto.

**Despliegue actual:** [FaceLit](https://facelit.tech/) está publicado íntegramente en un VPS de **Hostinger**. Docker Compose coordina la web, el backend Spring Boot, el servicio facial FastAPI y PostgreSQL con pgvector; Caddy publica el dominio por HTTPS y conecta API y WebSocket. El [informe de despliegue](17_Despliegue/Despliegue_Hostinger.md) documenta el paquete preparado desde `main` local de los cuatro repositorios y sus ajustes.

## Índice de la documentación

| Sección | Contenido principal |
|---|---|
| [01 — Documento general](01_Documento_General_Proyecto/01_Documento_General_Proyecto.md) | Alcance, estado general y contexto del proyecto. |
| [02 — Especificación y requerimientos](02_Especificacion_Requisitos/SRS_FaceLit_V4.md) | SRS vigente, requerimientos funcionales (RF) y requerimientos no funcionales (RNF), estados y trazabilidad. |
| [03 — Análisis de software](03_Analisis_Software/Arquitectura_Implementada.md) | Arquitectura y componentes implementados. |
| [04 — Propuesta técnica](04_Propuesta_Tecnica/04_Propuesta_Tecnica.md) | Stack, decisiones y propuesta técnica. |
| [05 — Diseño de software](05_Diseno_Software/05_Diseno_Software.md) | Diseño, flujos funcionales, priorización MoSCoW y patrones verificados. |
| [06 — Base de datos](06_Base_Datos/Base_Datos_Migraciones.md) | Esquema y migraciones de base de datos. |
| [07 — Pruebas](07_Pruebas/Pruebas_Evidencias_Actualizadas.md) | Planes, resultados y catálogo de evidencias; incluye [capturas por rol](07_Pruebas/Evidencias_Visuales_por_Rol.md). |
| [08 — Calidad y mejoras](08_Calidad_Mejoras/08_Calidad_Mejoras.md) | Calidad, seguridad, mejoras y criterios de verificación. |
| [09 — Implementación](09_Implementacion/09_Implementacion.md) | Componentes y comportamiento implementado. |
| [10 — Manual técnico](10_Manual_Tecnico/10_Manual_Tecnico.md) | Referencia técnica del sistema. |
| [11 — Manual de instalación](11_Manual_Instalacion/11_Manual_Instalacion.md) | Preparación e instalación de los componentes. |
| [12 — Manual de usuario](12_Manual_Usuario/12_Manual_Usuario.md) | Instrucciones de uso para los roles del sistema. |
| [13 — Artículo del proyecto](13_Articulo_Proyecto/) | Artículo y material académico. |
| [14 — Anexos](14_Anexos/README.md) | Anexos A, B y C del SRS, trazabilidad complementaria y propuesta de licencias. |
| [15 — Repositorios](15_Link_Repositorios/Repositorios_del_proyecto.md) | Enlaces a los cuatro repositorios del proyecto. |
| [16 — Diseño visual](16_Diseño_Visual/README.md) | Arquitectura de información, identidad visual, sistema UI y recursos gráficos. |
| [17 — Despliegue](17_Despliegue/Despliegue_Hostinger.md) | Procedimiento, infraestructura y versiones declaradas para el despliegue. |

## Anexos y entregables

- Los anexos en Markdown tienen su PDF correspondiente dentro de [14_Anexos](14_Anexos/README.md).
- La documentación de diseño visual incluye una versión Markdown, un documento DOCX y un PDF en [16_Diseño_Visual](16_Diseño_Visual/README.md).
- Las capturas de los roles están organizadas en `07_Pruebas/Capturas_Roles/` y se referencian desde el catálogo de evidencias visuales.
- Los PDF y documentos editables acompañan a sus fuentes cuando forman parte de la entrega. Consulta cada índice de carpeta para localizar sus versiones.

## Criterios para leer la documentación

- **Requerimientos funcionales (RF)** y **requerimientos no funcionales (RNF)** son las denominaciones usadas en el SRS y sus anexos.
- La documentación distingue el comportamiento confirmado, la implementación encontrada, la evidencia disponible y los criterios aún por verificar. Una prueba automatizada o una captura aislada no demuestra por sí sola la aceptación completa de un flujo.
- El documento de despliegue identifica las ramas y versiones fuente declaradas y explica las diferencias entre el estado local, el remoto y el desplegado cuando aplica. Consulta ese documento antes de inferir que un cambio local ya está publicado.
- Las fechas que aparecen en nombres de archivos pueden corresponder a cortes anteriores; cada documento indica su propio alcance y fecha de actualización.

## Repositorios del sistema

La solución está distribuida en los repositorios FaceLit (frontend), FaceLit-Backend, micro-facial (servicio facial) y FaceLit-DB (esquema y migraciones). Los enlaces y detalles están en [15_Link_Repositorios](15_Link_Repositorios/Repositorios_del_proyecto.md); las referencias de despliegue están en [17_Despliegue](17_Despliegue/Despliegue_Hostinger.md).

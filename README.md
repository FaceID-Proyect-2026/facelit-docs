# FaceLit — Documentación del proyecto

Documentación del sistema de control de asistencia mediante reconocimiento facial.
Organizada según las 17 secciones de la carpeta de referencia `FaceLit_Docs`.

## Patrones de diseño verificados

La [revisión de patrones de diseño](05_Diseno_Software/Patrones_Diseno_Verificados.md)
contrasta la documentación con el código local de los cuatro repositorios, con
fecha del 26 de octubre de 2026. Incluye evidencia por archivo, rectificaciones
de terminología y una redacción corregida para el proyecto. Los PDF y anexos
conservan su contenido anterior; consultar esta revisión para la clasificación
actualizada de patrones.

## Estructura

```text
facelit-docs/
├── 01_Documento_General_Proyecto/
│   └── Gantt/
├── 02_Especificacion_Requisitos/
├── 03_Analisis_Software/
├── 04_Propuesta_Tecnica/
├── 05_Diseno_Software/
├── 06_Base_Datos/
├── 07_Pruebas/
├── 08_Calidad_Mejoras/
├── 09_Implementacion/
├── 10_Manual_Tecnico/
├── 11_Manual_Instalacion/
├── 12_Manual_Usuario/
├── 13_Articulo_Proyecto/
├── 14_Anexos/
│   ├── Presentacion-diapositiva/
│   └── trabajo de Motta 2026/
├── 15_Link_Repositorios/
├── 16_Diseño_Visual/
│   ├── Diseño web/
│   └── Manual de marca/
└── 17_Despliegue/
```

## Ubicación de los documentos anteriores

| Carpeta anterior | Ubicación actual |
| --- | --- |
| Anexo | 14_Anexos |
| Diagramas | 03_Analisis_Software |
| Diseño web | 16_Diseño_Visual/Diseño web |
| Gantt | 01_Documento_General_Proyecto/Gantt |
| Informe técnico | 10_Manual_Tecnico |
| Manual de marca | 16_Diseño_Visual/Manual de marca |
| Modelo entidad relación (BD) | 06_Base_Datos |
| Presentacion-diapositiva | 14_Anexos/Presentacion-diapositiva |
| Prototipado | 05_Diseno_Software |
| SRS | 02_Especificacion_Requisitos |
| trabajo de Motta 2026 | 14_Anexos/trabajo de Motta 2026 |

Se incorporaron los 37 archivos de referencia y se conservaron los documentos
anteriores, incluidos los enlaces de diseño. El diagrama anterior cuyo nombre
coincidía con uno de los archivos importados se conserva como
`03_Analisis_Software/Diagrama de Transición de estado__anterior`.

## Documentación Markdown actualizada — orden oficial 01–17

Los documentos actualizados están organizados dentro de las carpetas numeradas originales, en el mismo orden de la carpeta de entrega. La fecha de corte es 27 de octubre de 2026.

| Orden | Carpeta | Documento de referencia |
|---:|---|---|
| 01 | 01_Documento_General_Proyecto | [Estado general y alcance](01_Documento_General_Proyecto/Estado_General_Actualizado_2026-10-27.md) |
| 02 | 02_Especificacion_Requisitos | [SRS V4 y trazabilidad](02_Especificacion_Requisitos/SRS_FaceLit_V4.md) |
| 03 | 03_Analisis_Software | [Arquitectura HU-48](03_Analisis_Software/Arquitectura_HU48.md) (vigente) / [corte anterior](03_Analisis_Software/Arquitectura_Implementada_2026-10-27.md) · [Evaluación arquitectónica y brechas HU-48](03_Analisis_Software/Evaluacion_Arquitectura_y_Brechas_HU48.md) |
| 04 | 04_Propuesta_Tecnica | [Propuesta técnica actualizada](04_Propuesta_Tecnica/04_Propuesta_Tecnica.md) |
| 05 | 05_Diseno_Software | [Diseño funcional y flujos](05_Diseno_Software/Flujos_Funcionales.md) |
| 06 | 06_Base_Datos | [Base de datos y migraciones](06_Base_Datos/Base_Datos_Migraciones.md) |
| 07 | 07_Pruebas | [Pruebas y evidencias](07_Pruebas/Pruebas_Evidencias_Actualizadas.md) |
| 08 | 08_Calidad_Mejoras | [Calidad, seguridad y mejoras](08_Calidad_Mejoras/08_Calidad_Mejoras.md) |
| 09 | 09_Implementacion | [Implementación realizada](09_Implementacion/09_Implementacion.md) |
| 10 | 10_Manual_Tecnico | [Manual técnico](10_Manual_Tecnico/10_Manual_Tecnico.md) |
| 11 | 11_Manual_Instalacion | [Manual de instalación](11_Manual_Instalacion/11_Manual_Instalacion.md) |
| 12 | 12_Manual_Usuario | [Manual de usuario](12_Manual_Usuario/12_Manual_Usuario.md) |
| 13 | 13_Articulo_Proyecto | [Artículo: resultados y límites](13_Articulo_Proyecto/13_Articulo_Proyecto.pdf) |
| 14 | 14_Anexos | [Licencias, costos y dependencias](14_Anexos/Licencia_de_Software_Propuesta.md) |
| 15 | 15_Link_Repositorios | [Repositorios y versiones](15_Link_Repositorios/Repositorios_del_proyecto.md) |
| 16 | 16_Diseño_Visual | [Sistema visual e interfaz](16_Diseño_Visual/Sistema_Visual_UI_2026-10-27.md) |
| 17 | 17_Despliegue | [Despliegue Hostinger](17_Despliegue/Despliegue_Hostinger.md) |

Los documentos describen el corte reportado, diferencian lo implementado de lo pendiente y conservan el SRS V4 como baseline de requisitos. Los PDF/Word originales permanecen intactos; cuando su contenido describa una plataforma o estado anterior, debe marcarse como histórico antes de distribuir la carpeta. La matriz SRS V4 tiene fecha 13 de octubre y requiere revisión requisito por requisito contra el corte actual. La actualización documental no equivale a aceptación oficial ni a una nueva prueba del sistema.

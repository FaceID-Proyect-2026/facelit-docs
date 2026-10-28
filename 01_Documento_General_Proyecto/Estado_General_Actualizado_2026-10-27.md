# FaceLit — estado general y alcance vigente

**Corte:** 27 de octubre de 2026.  
**Naturaleza:** actualización de contenido basada en los cuatro repositorios de referencia, los informes de despliegue y pruebas del equipo y la guía de sustentación actual.

## Resumen ejecutivo

FaceLit es una aplicación para organizar información académica y registrar/consultar asistencia. El sistema relaciona usuarios, programas, fichas, instructores, ambientes y sesiones. El reconocimiento facial apoya la identificación: el aprendiz registra una referencia facial; durante una sesión, el flujo de asistencia captura imágenes, valida retos de movimiento y aplica reglas del backend antes de guardar el evento.

La solución contiene cuatro repositorios: interfaz Expo/React Native, backend Java/Spring Boot, servicio facial Python/FastAPI y repositorio de esquema/migraciones PostgreSQL. Los cuatro no equivalen a cuatro microservicios: FaceLit-Backend es una aplicación modular; FaceLit-DB contiene migraciones y no expone una API de negocio. Backend y servicio facial usan actualmente la misma base PostgreSQL.

## Problema y objetivo

El problema abordado es mantener la asistencia relacionada con la identidad, ficha, actividad y tiempo, en vez de depender de listas dispersas difíciles de consolidar. El objetivo es facilitar la administración de los datos académicos, la preparación de sesiones y el registro y consulta de asistencia según el rol.

No existe en la documentación revisada una medición institucional antes/después que permita afirmar porcentajes de reducción de errores, ahorro de tiempo o productividad. No presentar esos valores como resultados medidos.

## Roles y responsabilidades

| Rol | Alcance funcional descrito |
|---|---|
| Coordinador | Mantiene usuarios y datos académicos, usa carga CSV y consulta funciones administrativas permitidas. |
| Instructor | Consulta fichas asignadas, prepara sesiones autorizadas y registra/consulta asistencia dentro de ese alcance. |
| Aprendiz | Usa su cuenta, registra su referencia facial y consulta información personal disponible. |

La visibilidad de una opción en la interfaz no sustituye la autorización del backend. Cada afirmación sobre permisos debe apoyarse en el control de rol y propiedad del recurso correspondiente.

## Alcance actual

- Aplicación web publicada en el VPS de Hostinger tras la actualización documentada el 27 de octubre.
- Backend Spring Boot, servicio facial FastAPI y PostgreSQL/pgvector desplegados como servicios internos de Docker Compose, detrás de Caddy.
- Carga CSV para preparar la información académica, de acuerdo con la plantilla y validaciones de la versión desplegada.
- Registro de referencia facial y flujo de asistencia con dos retos distintos elegidos entre cuatro retos habilitados.
- Esquema PostgreSQL versionado con Liquibase; al corte de despliegue se reportan 45 changesets aplicados.
- Interfaz web y código React Native/Expo. La web pública no demuestra que una aplicación móvil esté publicada en una tienda ni validada en un dispositivo.

## Estado de despliegue reportado

El 27 de octubre se documentó actualización de producción en Hostinger: se generaron respaldos antes de migrar y activar; se aplicaron migraciones compatibles; se conservó la cuenta del coordinador y se limpiaron datos operativos para preparar una demostración; se comprobaron arranque, HTTPS, estado de servicios, API pública, autorización sin login y WebSocket. El informe deja para aceptación manual el inicio de sesión, la carga CSV, la entrega SMTP y el recorrido real de cámara/asistencia.

El corte de código citado es FaceLit 5f7d6fe (dev), FaceLit-Backend 2ab0bcd (dev), micro-facial 1e12c6c (dev) y FaceLit-DB 41a063f (main). Las ramas y SHA se deben repetir en la evidencia asociada a cada entrega; no son garantía permanente de lo que ejecuta el servidor.

## Fuera de alcance o no demostrado

- No hay certificación de 100 % de precisión ni de resistencia antifraude.
- No hay evaluación biométrica representativa que permita estimar falsos positivos/falsos negativos.
- No se presenta como completado todo el SRS. Horarios y otras funciones históricas requieren una decisión de alcance y evidencia propia.
- No se afirma funcionamiento sin internet, integración IoT/Raspberry Pi, nómina, pagos o sanciones académicas automáticas.
- No se afirma aceptación integral de instalación móvil, correo real, cámara física, restauración de backups ni seguridad completa.

## Evolución frente a los documentos anteriores

Los documentos anteriores que describen Render/Vercel y dejan pendiente el servicio facial reflejan un corte anterior. Para el corte del 27 de octubre, la fuente actual describe Hostinger y el servicio facial activo. Mantener los documentos antiguos solo si quedan marcados como históricos; no combinar instrucciones de despliegue de plataformas distintas.

## Fuentes de esta actualización

- Guía de sustentación FaceLit ADSO, actualizada el 27 de octubre de 2026.
- Informe de despliegue Hostinger del 27 de octubre de 2026.
- Repositorios en los SHA listados en el índice del paquete.
- SRS V4.0 como baseline de requisitos, no como evidencia de implementación.


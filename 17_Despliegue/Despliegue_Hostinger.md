# FaceLit — implementación y despliegue en Hostinger

**Corte:** 27 de octubre de 2026.  
**Estado del informe:** actualización activada y comprobaciones técnicas aprobadas; aceptación manual incompleta.

## Topología desplegada reportada

- Dominio web: https://facelit.tech/
- VPS de Hostinger con Docker Compose.
- Caddy sirve la exportación web y hace proxy HTTPS/WebSocket al backend.
- PostgreSQL 16 con pgvector, backend Spring Boot, y microservicio FastAPI están en red privada Docker.
- Solo el servicio web publica 80/443; PostgreSQL, backend y servicio facial no publican sus puertos al exterior.
- Servicio facial privado; backend y facial comparten la base. Liquibase actualiza el esquema antes de arrancar la nueva API.

## Versiones de fuente declaradas para la publicación

| Repositorio | Rama | SHA completo |
|---|---|---|
| FaceLit | dev | 5f7d6fe4c071b13d5a437f0d3fffd57e3640d594 |
| FaceLit-Backend | dev | 2ab0bcd6b46d6ce9620570bd09a2ca7521461286 |
| micro-facial | dev | 1e12c6c422d3c96ccea4d6103d422e8f2a9c3a3a |
| FaceLit-DB | main | 41a063fe00a1caf197580b65b5c45496df716c0b |

El frontend local tiene cambios sin commit en app.json y eas.json al momento de preparar esta documentación. No asumir que esos cambios locales están incluidos en los SHA de la tabla ni en las imágenes desplegadas. Para una nueva publicación, registrar el SHA del árbol exacto usado para construir cada imagen.

## Cómo se hizo la actualización del 27 de octubre

1. Se verificaron los componentes requeridos y el acceso SSH del operador.
2. Se preparó un paquete de despliegue excluyendo secretos y archivos locales privados.
3. Se creó y verificó un respaldo PostgreSQL previo al cambio y se conservaron imágenes anteriores para recuperación.
4. Se integraron en FaceLit-DB/main las migraciones de nomenclatura inglesa existentes mediante PR #63 tras revisar el CI de PostgreSQL/Liquibase.
5. Se validó el changelog de producción y se detuvieron web, backend y servicio facial.
6. Se generó otro respaldo consistente antes de la activación.
7. Liquibase aplicó cambios pendientes de 39 a 45 changesets.
8. Se ejecutó una limpieza transaccional autorizada de datos operativos, preservando la cuenta del coordinador, su credencial, permisos, configuración y aceptación legal. No se importaron datos de la base local.
9. Se construyeron las imágenes Docker en el VPS y se activaron los contenedores de la versión nueva.
10. Se comprobó el estado de servicios, el proxy HTTPS, API, autorización sin login y WebSocket.

Los respaldos contienen datos privados y permanecen en el VPS con acceso restringido. No incluir rutas de acceso, credenciales ni respaldos en el paquete público de documentación.

## Resultado de preparación de datos

Después de la limpieza transaccional reportada: 1 usuario coordinador, 1 credencial, 3 roles y 12 permisos; cero instructores, aprendices, programas, fichas, referencias faciales y eventos. La demostración requiere cargar antes el CSV de prueba y preparar instructor/aprendiz y sesión.

## Comprobaciones técnicas registradas

- Sitio y ruta de login responden HTTPS 200; archivos JavaScript accesibles.
- Backend inicia con validación JPA del esquema.
- PostgreSQL y servicio facial saludables; endpoint de salud facial 200.
- API administrativa sin autenticación responde 401.
- API de aceptación legal se consultó directa y a través del proxy.
- Clave y URL interna entre backend y facial coinciden, sin imprimir sus valores.
- WebSocket HTTPS devuelve handshake 101 para el origen permitido.
- Base en 45 changesets, sin pendientes.
- DNS no se modificó durante esta activación.

Las comprobaciones de estado no sustituyen el inicio de sesión real, la carga CSV, el correo SMTP, cámara física ni prueba de asistencia de un usuario de demostración.

## Procedimiento operativo para actualización futura

1. Confirmar SHA de los cuatro repositorios y revisar cambios/migraciones.
2. Crear backup y verificar su integridad antes de cambios.
3. Crear una carpeta de release nueva; conservar el release anterior.
4. Validar Docker Compose y construir las imágenes identificadas por los SHA aprobados.
5. Detener temporalmente los consumidores si la migración lo exige.
6. Validar Liquibase, inspeccionar SQL previsto y aplicar migraciones compatibles.
7. Activar servicios, revisar healthchecks y logs, comprobar HTTPS/API/WebSocket.
8. Ejecutar aceptación manual con coordinador de prueba, CSV controlado, cámara y SMTP.
9. Documentar SHA, resultados, evidencia, limitaciones y decisión de aceptación.
10. Si falla una migración, mantener la web detenida y seguir el plan de recuperación; volver a una imagen anterior no revierte automáticamente PostgreSQL.

No ejecutar una eliminación de volúmenes de Docker como operación de actualización. La reversión debe considerar compatibilidad de código y esquema, no solo contenedores.

## Diferencia con el despliegue histórico

Los manuales previos describían Render/Vercel y un microservicio facial no desplegado. Esa secuencia ya no describe esta topología. Conservarla solo como antecedente y reemplazar los pasos de operación vigentes por esta versión después de la aceptación editorial del equipo.

## Referencias

Informe DESPLIEGUE_HOSTINGER_2026-10-27.md, deploy/compose.yaml, deploy/Caddyfile, deploy/package.ps1 y cambios de FaceLit-DB en 06_migrations/. El informe documenta el proceso; esta actualización no repite despliegue ni toca producción.

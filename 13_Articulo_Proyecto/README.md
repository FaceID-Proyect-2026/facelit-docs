# Artículo del proyecto FaceLit

El [artículo del proyecto](13_Articulo_Proyecto.pdf) presenta el problema, la metodología, la arquitectura y los resultados documentados de FaceLit.

**Actualización del despliegue: 5 de noviembre de 2026.** El apartado de resultados y su referencia de despliegue se corrigieron para reflejar la publicación integral en el VPS Hostinger. Caddy sirve `https://facelit.tech/` y conecta API y WebSocket; Docker Compose ejecuta PostgreSQL con pgvector, Spring Boot y el servicio facial FastAPI en la red privada del VPS.

El [informe de la carpeta 17](../17_Despliegue/Despliegue_Hostinger.md) registra el procedimiento aplicado, los cuatro repositorios en `main` local y los ajustes incluidos en el paquete instalado. Las [evidencias por rol](../07_Pruebas/Evidencias_Visuales_por_Rol.md) complementan el artículo.

# FaceLit — sistema visual e interfaz

**Corte de referencia:** frontend 5f7d6fe, rama dev, 27 de octubre de 2026.  
**Fuente central:** FaceLit/shared/constants/colors.ts, typography.ts y ThemeContext.tsx.

## Principios de uso

Los colores y la tipografía se centralizan en constantes compartidas y el tema se resuelve desde ThemeContext. Las pantallas deben consumir tokens y componentes compartidos en vez de introducir hexadecimales y estilos incoherentes. La interfaz tiene tema claro y oscuro, y textos traducidos en español, inglés, alemán y francés según las claves disponibles.

La existencia de una traducción en el frontend no demuestra que el idioma/catálogo esté soportado y persistido en backend. El SRS V4 identifica diferencias de idioma/preferencias que deben revalidarse antes de afirmar soporte completo en los cuatro idiomas.

## Tokens observados

### Marca y acentos

| Token | Valor |
|---|---|
| primary | #65B361 |
| primaryLight | #72C96D |
| primaryDark | #4A9146 |
| secondary | #F59E0B |
| secondaryLight | #FFB74D |
| secondaryDark | #D97706 |

### Estados semánticos

| Estado | Valor |
|---|---|
| success | #27AE60 |
| info | #4A90D9 |
| warning | #E89B2C |
| danger/error | #D92027 |

### Tema claro

| Token | Valor |
|---|---|
| background | #F4F1EA |
| surface/card | #FBF8F1 |
| surfaceSecondary | #EDE7DC |
| border | #DED7CC |
| text | #0F172A |
| textSecondary | #475569 |
| textMuted | #64748B |

### Tema oscuro

| Token | Valor |
|---|---|
| background | #000000 |
| surface/card | #06100A |
| surfaceSecondary | #0A1710 |
| border | #173522 |
| text | #FFFFFF |
| textSecondary | #B7C5BC |
| textMuted | #7F9587 |

## Tipografía

La escala observada define tamaños de 11, 12, 13, 14, 16, 18, 22, 26, 32 y 38 px; pesos 400, 500, 600, 700, 800 y 900. No se especifica aquí una familia tipográfica universal: confirmar fuentes y licencias del bundle antes de añadir una fuente externa.

## Comprobaciones para pantallas y diapositivas

- Mantener contraste legible en los temas claro y oscuro.
- Usar tokens de color y estados semánticos, sin duplicar hexadecimales locales.
- Validar carga, error, deshabilitado, seleccionado y foco.
- Revisar tablas y diálogos en el ancho de pantalla de la demostración.
- Confirmar que las etiquetas de los cuatro retos coinciden con el catálogo vigente.
- Revisar traducciones en contexto y no considerar idioma completo si faltan claves o persistencia.
- Si se cambia el color de la portada/landing, actualizar el test visual y capturar evidencia del SHA nuevo.

## Límite

Esta ficha documenta tokens observados en el frontend; no es una auditoría de accesibilidad ni certifica contraste WCAG en todas las pantallas. La guía visual PDF anterior debe marcarse con su fecha y compararse con estos tokens al preparar una edición nueva.

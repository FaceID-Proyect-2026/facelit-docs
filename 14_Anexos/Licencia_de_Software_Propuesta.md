# FaceLit — Propuesta de licenciamiento

**FaceLit | Documentación del proyecto | Corte 27 oct 2026**
Documento académico referencial | Versión actualizada al 27 de octubre de 2026

## Equipo de proyecto

- Mariana Valenzuela Penagos
- Valery Sinaí Trujillo Quintero
- María José Rodríguez Oyola

Ficha 3145555 | SENA - ADSO | Neiva, Huila

## Naturaleza y alcance

Este documento presenta una propuesta para evaluar opciones de uso y sostenimiento del proyecto FaceLit. No constituye un contrato, una licencia vigente, una cesión de derechos ni una declaración verificada de titularidad. Los nombres del equipo son los que aparecen en el documento base; la titularidad y los derechos de cada aporte deben confirmarse con los acuerdos aplicables antes de ofrecer o distribuir el software.

---

## 1. Descripción actual del software

FaceLit es una aplicación académica de asistencia para aprendices, instructores y coordinadores. El sistema combina una interfaz web/móvil, una API de negocio, un servicio de procesamiento facial y una base de datos PostgreSQL administrada con migraciones. En el código actual se localizan gestión académica, sesiones de ambiente, captura de asistencia facial, consultas y notificaciones; las funciones y límites se describen en el inventario funcional actualizado.

| Componente | Tecnología identificada |
|---|---|
| Interfaz | Expo Router, React Native, TypeScript; web y Android |
| Backend | Java 17, Spring Boot, API REST/JWT |
| Servicio facial | Python 3.11, FastAPI, InsightFace/MediaPipe/ONNX |
| Datos | PostgreSQL 16, pgvector, Liquibase |

---

## 2. Modelo propuesto en el documento base

La idea de doble modalidad se conserva como propuesta por decidir: uso educativo sin cobro bajo condiciones acordadas; y modalidad empresarial con precio, soporte y mantenimiento definidos mediante acuerdo separado. No existe evidencia en los cuatro repositorios inspeccionados de un archivo `LICENSE`, contrato, convenio SENA o acuerdo comercial que haga vigente esta propuesta.

Antes de ofrecer licencias, el equipo debe acordar el alcance permitido (instalación, copias, modificación, redistribución, soporte, actualizaciones, datos biométricos y terminación), identificar quién puede autorizarlo y documentar la aprobación.

---

## 3. Costos y supuestos

Las cifras del documento anterior (incluidos valores mensuales/anuales, hardware, personal y escenarios comerciales) no se presentan como cotizaciones vigentes: no se encontraron fuentes, fecha de cotización, alcance de servicio ni validación aritmética suficientes. Se retiran del resumen actual para evitar tratarlas como precios aprobados.

| Rubro a estimar | Dato necesario para actualizar |
|---|---|
| Infraestructura | Proveedor, especificación, período, impuestos y moneda. |
| Implementación | Horas por perfil, tarifa, alcance y entregables. |
| Operación | Dominio, alojamiento, base de datos, respaldo, correo y monitoreo. |
| Mantenimiento/soporte | Horario, tiempos de respuesta, actualizaciones y límites. |
| Licenciamiento | Tipo de usuario/entidad, vigencia, instalaciones, precio y renovación. |

---

## 4. Decisiones pendientes del equipo

- Confirmar autoría, participación y titularidad de derechos patrimoniales para código, diseños, textos, marca y materiales de terceros.
- Revisar dependencias de terceros y sus licencias; los repositorios no incluyen una licencia general del proyecto.
- Definir si FaceLit sera software académico, propietario, de código abierto o un esquema dual, y aprobar términos consistentes entre repositorios y entregas.
- Acordar el uso y protección de datos personales y biométricos, responsables, finalidades, retención y controles antes de cualquier piloto real.
- Preparar cotizaciones y recalcular escenarios de costo con alcance y fecha verificables.

No se incorporan términos de licencia para dependencias (Expo, Spring, FastAPI, InsightFace u otras). Cada componente conserva las condiciones de sus respectivos titulares.

---

## 5. Fuentes informativas oficiales

- Dirección Nacional de Derecho de Autor — Registro de software: <https://www.derechodeautor.gov.co/es/registro-de-software>
- Ley 23 de 1982, Gestor Normativo de Función Pública: <https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=3431>

La revisión de titularidad, cesiones y términos debe realizarla el equipo con la orientación institucional correspondiente. Esta ficha no sustituye asesoría jurídica.

### Corte técnico del proyecto

FaceLit `5f7d6fe`; FaceLit-Backend `2ab0bcd`; micro-facial `1e12c6c`; FaceLit-DB `41a063f`. Se inspeccionaron repositorios; el estado del código no acredita despliegue comercial, costo real ni autorización de uso.

---
---

# PROPUESTA HISTORICA — NO VIGENTE

> Estas paginas reproducen, sin modificacion, la propuesta anterior. El modelo de licencia, titularidad y cifras economicas alli consignadas no se han verificado ni aprobado y no se presentan como condiciones vigentes. Consulta las paginas iniciales de este PDF para el estado actual de la propuesta academica.
>
> Fin de la actualizacion; comienza la copia historica sin cambios.

## Licencia del proyecto — FACELIT (MMV)

**Informe técnico de licenciamiento y costos**

### Integrantes

- Mariana Valenzuela
- Valery Sinaí Trujillo
- María José Rodríguez

Ficha: 3145555
Neiva, Huila
2026

---

### 1. Introducción

El presente informe técnico tiene como finalidad realizar un análisis de proveedores de software y hardware para el proyecto "FaceLit". Se incluyen los requerimientos de software y hardware, propuestas de soluciones, recurso humano involucrado, análisis de proveedores y diagrama de Gantt.

### 2. Objetivo

Desarrollar un sistema que registre la entrada y salida de aprendices e instructores mediante reconocimiento facial, almacenando la información en una base de datos y mostrando reportes en una interfaz web.

### 3. Inicio del proyecto

La idea de este proyecto es apoyar el funcionamiento de los registros de usuario, implementando un registro rápido y automatizado que permita llevar el control y la gestión de la puntualidad, la asistencia y el cumplimiento en el entorno laboral.

### 4. Planteamiento del problema: la licencia del software

El software FACELit (MMV) fue desarrollado como una solución de reconocimiento facial para control de accesos y gestión de seguridad. Sin embargo, al implementarlo en distintos entornos surge el problema de definir el tipo de licencia de uso que se debe aplicar, ya que el contexto cambia entre instituciones educativas y empresas privadas.

- **Ámbito académico (SENA):** se busca que estudiantes y docentes tengan acceso gratuito con fines de aprendizaje, sin generar costos para la institución.
- **Ámbito empresarial:** el software representa una herramienta de valor comercial y de seguridad, lo cual justifica un modelo de licencia que genere ingresos y garantice soporte técnico a las organizaciones que lo utilicen.

Este planteamiento lleva a definir una estrategia de licenciamiento mixta, adaptada a cada caso de uso: gratuita para instituciones educativas y comercial para empresas, bajo esquemas de suscripción o pago único.

### 5. Informe de licencia

#### 5.1 Datos generales

| Concepto | Detalle |
|---|---|
| Nombre del software | FACELIT – MMV |
| Tipo de licencia | Licencia dual: gratuita para instituciones educativas (uso académico) y comercial para empresas (suscripción o pago único con mantenimiento) |
| Titular de la licencia | MMV – Creadores y propietarios del software: María José Rodríguez, Valery Sinaí Trujillo y Mariana Valenzuela |

#### 5.2 Modalidades de licencia

| | Gratuita – instituciones educativas | Comercial – empresas |
|---|---|---|
| **Uso** | Académico | Control de accesos y gestión de seguridad |
| **Razón principal** | Facilita la adopción del software en entornos de aprendizaje; permite a estudiantes y docentes practicar y conocer la herramienta sin costo; genera difusión y confianza en el producto. | El software es una herramienta crítica de seguridad; permite a los creadores sostener el desarrollo, ofrecer soporte y actualizaciones. |
| **Beneficios** | Expansión de la base de usuarios; posible adopción futura en el mercado laboral, ya que los alumnos lo recomendarán en sus trabajos. | Flexibilidad: la empresa elige entre suscripción (con soporte incluido) o pago único (licencia perpetua, con mantenimiento aparte). |

#### 5.3 Vigencia

- **Modo académico:** uso gratuito mientras dure el convenio con la institución educativa.
- **Modo empresarial, suscripción:** anual o mensual, con soporte y gestión incluidos.
- **Modo empresarial, pago único:** la empresa compra el derecho de uso y paga adicionalmente si desea soporte.

#### 5.4 Alcance de uso

- Uso autorizado solo en la institución o empresa que adquiera la licencia.
- En instituciones educativas: solo para fines de formación.
- En empresas: para control de accesos y gestión de seguridad.

#### 5.5 Condiciones legales

- El software es propiedad de MMV.
- Está prohibida su copia, distribución o modificación sin autorización.

### 6. Costos de la licencia

#### 6.1 Costo mensual y anual

| Concepto | Valor (COP) |
|---|---|
| Costo para el SENA | Gratuito |
| Actualizaciones | $2.000.000 |
| Ganancias | $5.000.000 |
| Cambios técnicos requeridos | $1.000.000 |
| Soporte incluido o no | $1.000.000 |
| Acuerdo previo (mantenimiento, SLA, etc.) | $1.000.000 |
| **Costo mensual total** | **$8.000.000** |
| **Costo anual** | **$96.000.000** |

Factores que influyen en el costo: complejidad del software y cantidad de usuarios.

Las ganancias ascienden a $5.000.000, reflejando los gastos generados por la máquina en la empresa.

#### 6.2 Opciones de licenciamiento para la empresa

| Modalidad | Costo (COP) | Descripción |
|---|---|---|
| Software propietario (uso exclusivo de la empresa) | $2.592.000.000 | La licencia es solo para la empresa |
| Trabajado por los titulares (los desarrolladores trabajan para la empresa) | $96.000.000 | Costo anual de la licencia |

### 7. Costo total del proyecto

| Elemento | Cantidad | Costo unitario | Total (COP) |
|---|---|---|---|
| Elementos externos | 4 | Varía | $2.610.000 |
| Implementación de hardware | 6 | Varía | $22.468.000 |
| Implementación de software | 10 | Varía | $15.686.000 |
| Servidor local | 1 | $6.000.000 | $6.000.000 |
| Recurso humano | 3 | $150.000.000 | $150.000.000 |
| Licencia de software | 2 | Depende | $96.000.000 / $2.592.000.000 |

| Escenario | Costo total (COP) |
|---|---|
| Licencia propietaria | $2.797.751.000 |
| Licencia trabajada por el titular | $301.751.000 |

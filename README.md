# Scripts de Administración de Servidores y Ciberseguridad

Colección de scripts utilizados para la administración de servidores y tareas relacionadas con ciberseguridad.  
Estos scripts son desarrollados como parte de trabajos académicos y práctica personal para el desarrollo personal.
## Propósito

El objetivo de este repositorio es mantener una colección de pequeñas utilidades que permitan automatizar tareas administrativas comunes en sistemas Linux utilizando la línea de comandos.

## Tecnologías

- Bash
- Herramientas de línea de comandos en Linux
- Utilidades de red
- Herramientas de auditoría de seguridad

----

# Scripts de Administración de Servidores y Ciberseguridad

Colección de scripts utilizados para la administración de servidores y tareas relacionadas con ciberseguridad.  
Estos scripts son desarrollados como parte de trabajos académicos y práctica personal para el desarrollo profesional.

## Propósito

El objetivo de este repositorio es mantener una colección de pequeñas utilidades que permitan automatizar tareas administrativas comunes en sistemas Linux utilizando la línea de comandos.

## Tecnologías

- Bash
- Herramientas de línea de comandos en Linux
- Utilidades de red
- Herramientas de auditoría de seguridad

---

## Índice de Scripts

1. [Administrador de Red](#1-administrador-de-red)
---

## Documentación de Scripts

### 1. Administrador de Red

**Archivo:** `conexion-red.sh`

**Descripción**
Script interactivo desarrollado en Bash para la administración y configuración básica de redes en sistemas GNU/Linux. Permite gestionar el estado de las interfaces, establecer conexiones inalámbricas y configurar el direccionamiento IP de manera dinámica o estática desde la línea de comandos.

**Requisitos**
- Privilegios de superusuario (`root`).
- Utilidades de red estándar: `iproute2`, `iw`, `wpasupplicant`, `isc-dhcp-client`.

**Instalación y Uso**
1. Otorgar permisos de ejecución al archivo:
   ```bash
   chmod +x conexion-red.sh

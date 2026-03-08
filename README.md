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

## Scripts

1. [Administrador de Red](#1-administrador-de-red)
---

## Documentación de Scripts

### 1. Administrador de Red

**Archivo:** `administrador-de-red_07-03-2026.sh`

**Descripción**
Script interactivo desarrollado en Bash para la administración y configuración básica de redes en sistemas GNU/Linux. Permite gestionar el estado de las interfaces, establecer conexiones inalámbricas y configurar el direccionamiento IP de manera dinámica o estática desde la línea de comandos.

**Funcionalidades**
El script se maneja a través de un menú interactivo con las siguientes opciones:
- ***Mostrar interfaces de red:*** Ejecuta un escaneo rápido (ip -br link show) para enlistar las interfaces físicas y lógicas disponibles en el sistema y su estado actual.
- ***Cambiar estado de una interfaz:*** Solicita el nombre de una interfaz válida y permite alternar su estado administrativo entre activo (UP) e inactivo (DOWN).
- ***Conectarse a una red WiFi:*** Activa la interfaz inalámbrica especificada, escanea los SSID disponibles y establece una conexión autenticada mediante wpa_supplicant tras solicitar las credenciales al usuario.
- ***Configurar dirección IP:*** Permite asignar direccionamiento de capa 3 a una interfaz. Ofrece dos modalidades:
      - **Dinámica (DHCP):** Solicita una concesión IP automáticamente utilizando dhclient.
      - **Estática:** Asignación manual de Dirección IP, Máscara de subred (prefijo), Puerta de enlace predeterminada (Gateway) y Servidor de resolución de nombres (DNS).

**Mecanismo de Persistencia**
Al configurar una conexión de red (ya sea IP dinámica o estática, por cable o WiFi), el script pregunta al usuario si desea hacer la configuración persistente.

Si se acepta, el script inyecta las rutinas de configuración necesarias (levantamiento de interfaz, enrutamiento, DNS y conexión WPA) al final del archivo ~/.bashrc del usuario que ejecuta el script (típicamente /root/.bashrc al ejecutarse con sudo). Adicionalmente, el archivo temporal de credenciales WiFi generado en /tmp/wifi se reubica en ~/.wifi para permitir la autenticación automática en futuros inicios de sesión.

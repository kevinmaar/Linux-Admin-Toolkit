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
2. Papelera en CLI  
   2.1 [Enviar archivo a papelera](#21-enviar-archivo-a-papelera)  
   2.2 [Recuperar archivo de papelera](#22-recuperar-archivo-de-papelera)
---

## Documentación de Scripts

### 1. Administrador de Red

**Archivo:** [administrador-de-red_07-03-2026.sh](https://github.com/kevinmaar/Linux-Admin-Toolkit/blob/main/administrador-de-red_07-03-2026.sh)

#### **Descripción**
Script interactivo desarrollado en Bash para la administración y configuración básica de redes en sistemas GNU/Linux. Permite gestionar el estado de las interfaces, establecer conexiones inalámbricas y configurar el direccionamiento IP de manera dinámica o estática desde la línea de comandos.

**Funcionalidades**
El script se maneja a través de un menú interactivo con las siguientes opciones:

* **Mostrar interfaces de red:** Ejecuta un escaneo rápido (`ip -br link show`) para enlistar las interfaces físicas y lógicas disponibles en el sistema y su estado actual.
* **Cambiar estado de una interfaz:** Solicita el nombre de una interfaz válida y permite alternar su estado administrativo entre activo (`UP`) e inactivo (`DOWN`).
* **Conectarse a una red WiFi:** Activa la interfaz inalámbrica especificada, escanea los SSID disponibles y establece una conexión autenticada mediante `wpa_supplicant` tras solicitar las credenciales al usuario.
* **Configurar dirección IP:** Ofrece dos modalidades:
    * **Dinámica (DHCP):** Solicita una dirección IP automáticamente utilizando `dhclient`.
    * **Estática:** Asignación manual de Dirección IP, Máscara de subred o prefijo, Gateway y Servidor DNS.

**Mecanismo de Persistencia**
Al configurar una conexión de red ya sea IP dinámica o estática, por cable o WiFi, el script pregunta al usuario si desea hacer la configuración persistente.

Si se acepta, el script guarda los comandos de configuración necesarios (levantamiento de interfaz, DNS, conexión WPA, etc.) al final del archivo `~/.bashrc` del usuario que ejecuta el script `/root/.bashrc` ya que el script es ejecutado como `sudo`. Adicionalmente, el archivo temporal de credenciales WiFi generado en `/tmp/wifi` se reubica en `~/.wifi` para permitir la autenticación automática en futuros inicios de sesión.

---

### 2. Papelera en CLI

#### **Descripción**
Conjunto de scripts desarrollados en Bash que implementan un mecanismo sencillo de **papelera de reciclaje en la línea de comandos** para sistemas GNU/Linux.

En lugar de eliminar archivos permanentemente, los archivos son movidos a un directorio especial (`~/.papelera`) desde donde pueden ser restaurados posteriormente.

El sistema está compuesto por dos scripts:

* Un script para enviar archivos a la papelera.
* Un script para recuperar archivos eliminados.

---

#### 2.1 Enviar archivo a papelera

**Archivo:** [enviar_a_papelera_15-03-2026.sh](https://github.com/kevinmaar/Linux-Admin-Toolkit/blob/main/enviar_a_papelera_15-03-2026.sh)

##### **Descripción**

Script que permite eliminar archivos de forma recuperable moviéndolos al directorio `~/.papelera`.

**Funcionamiento**

* Verifica que se proporcione un archivo como argumento.
* Comprueba que el archivo exista.
* Crea el directorio `~/.papelera` si no existe.
* Guarda la ruta original del archivo en un archivo auxiliar `.ruta`.
* Mueve el archivo a la papelera en lugar de eliminarlo definitivamente.

---

#### 2.2 Recuperar archivo de papelera

**Archivo:** [recuperar_de_papelera_15-03-2026.sh](https://github.com/kevinmaar/Linux-Admin-Toolkit/blob/main/recuperar_de_papelera_15-03-2026.sh)

##### **Descripción**

Script que permite restaurar archivos previamente enviados a la papelera, regresándolos a su ubicación original.

**Funcionamiento**

* Verifica que el archivo solicitado exista dentro de `~/.papelera`.
* Lee la ruta original almacenada en el archivo `.ruta`.
* Mueve el archivo de regreso a su ubicación original.
* Elimina el archivo auxiliar utilizado para almacenar la ruta.

---

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
3. Creación de Usuarios  
   3.1 [Creación de Usuarios V0 (Básico)](#31-creación-de-usuarios-v0-básico)  
   3.2 [Creación de Usuarios V1 (Cuotas)](#32-creación-de-usuarios-v1-cuotas)  
   3.3 [Creación de Usuarios V2 (Sudoers)](#33-creación-de-usuarios-v2-sudoers)
4. Auditoría y Reconocimiento  
   4.1 [Scraper Web](#41-scraper-web)  
   4.2 [Barrido de Directorios Web](#42-barrido-de-directorios-web)  
   4.3 [Barrido de Red](#43-barrido-de-red)
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

Script desarrollado en Bash que implementa un mecanismo simple de eliminación segura de archivos. En lugar de borrar el archivo de manera permanente, el script lo mueve a un directorio especial denominado **papelera**, permitiendo su recuperación posterior.

Este comportamiento simula el funcionamiento de una papelera de reciclaje en sistemas gráficos, pero utilizando únicamente herramientas de línea de comandos en sistemas GNU/Linux.

**Funcionamiento**

* Verifica que el usuario proporcione exactamente un argumento al ejecutarlo.
* Comprueba que el archivo especificado exista en el sistema.
* Crea el directorio `~/.papelera` en caso de que no exista.
* Guarda la **ruta original del archivo** en un archivo auxiliar con extensión `.ruta`.
* Mueve el archivo a la carpeta de papelera para evitar su eliminación permanente.

---

#### 2.2 Recuperar archivo de papelera

**Archivo:** [recuperar_de_papelera_15-03-2026.sh](https://github.com/kevinmaar/Linux-Admin-Toolkit/blob/main/recuperar_de_papelera_15-03-2026.sh)

##### **Descripción**

Script desarrollado en Bash que permite restaurar archivos previamente enviados a la papelera mediante el script de eliminación segura. El proceso de recuperación utiliza la información de la **ruta original** almacenada durante la eliminación del archivo.

**Funcionamiento**

* Verifica que el usuario proporcione el nombre del archivo a recuperar.
* Comprueba que el archivo exista dentro del directorio `~/.papelera`.
* Lee el archivo auxiliar `.ruta` para obtener la ubicación original del archivo.
* Restaura el archivo moviéndolo nuevamente a su directorio original.
* Elimina el archivo auxiliar utilizado para almacenar la ruta.

---

### 3. Creación de Usuarios

#### **Descripción**
Serie de scripts evolutivos diseñados para automatizar el aprovisionamiento de usuarios en sistemas GNU/Linux. Estos scripts aseguran que cada cuenta creada cumpla con estándares mínimos de seguridad y permiten una administración avanzada de recursos y privilegios desde el despliegue inicial.

Todos los scripts de esta categoría requieren privilegios de **root** y validan la complejidad de la contraseña (mínimo 8 caracteres, una mayúscula y un número).

---

#### 3.1 Creación de Usuarios V0 (Básico)

**Archivo:** [creacion_de_usuariosV0_24-03-2026.sh](https://github.com/kevinmaar/Linux-Admin-Toolkit/blob/main/creacion_de_usuariosV0_24-03-2026.sh)

##### **Descripción**
Script fundamental para el alta de usuarios. Se encarga de la validación de identidad, creación del directorio personal y asignación del shell por defecto.

**Funcionamiento**
* Verifica la existencia previa del usuario para evitar duplicados.
* Implementa un bucle de validación para la contraseña, obligando al cumplimiento de la política de seguridad establecida.
* Crea el usuario con el flag `-m` para generar su `/home` y asigna `/bin/bash` como shell predeterminado.

---

#### 3.2 Creación de Usuarios V1 (Cuotas)

**Archivo:** [creacion_de_usuariosV1_24-03-2026.sh](https://github.com/kevinmaar/Linux-Admin-Toolkit/blob/main/creacion_de_usuariosV1_24-03-2026.sh)

##### **Descripción**
Extensión de la versión base que añade la gestión de límites de almacenamiento por usuario, ideal para entornos de servidores compartidos o laboratorios académicos.

**Funcionamiento**
* Integra todas las funciones de validación de la V0.
* Permite definir límites de disco **Soft** y **Hard** (en bloques de KB) utilizando la herramienta `setquota`.
* Ofrece la posibilidad de configurar el periodo de gracia global para las cuotas de disco en el sistema.

---

#### 3.3 Creación de Usuarios V2 (Sudoers)

**Archivo:** [creacion_de_usuariosV2_24-03-2026.sh](https://github.com/kevinmaar/Linux-Admin-Toolkit/blob/main/creacion_de_usuariosV2_24-03-2026.sh)

##### **Descripción**
La versión más avanzada orientada a la administración de sistemas y Red Teaming. Permite configurar la escalada de privilegios de forma granular y segura.

**Funcionamiento**
* Incluye las funcionalidades de creación (V0) y cuotas (V1).
* Gestiona la inclusión del usuario en el archivo de sudoers de forma segura:
    * Permite especificar comandos exactos (ej. `/usr/bin/apt`) o acceso total (`ALL`).
    * Crea un archivo independiente en `/etc/sudoers.d/` para mantener la integridad del archivo `sudoers` principal.
    * Aplica automáticamente el permiso `440` al archivo generado para cumplir con los requisitos de seguridad de sudo.

---

### 4. Auditoría y Reconocimiento

#### **Descripción**
Colección de herramientas orientadas a las fases de reconocimiento (Information Gathering) y auditoría de seguridad. Incluye scripts para el mapeo de redes locales, descubrimiento de recursos web ocultos y extracción de información sensible mediante técnicas de scraping.

---

#### 4.1 Scraper Web

**Archivo:** [scrapper_20-04-2026.py](https://github.com/kevinmaar/Linux-Admin-Toolkit/blob/main/scrapper_20-04-2026.py)

##### **Descripción**
Script desarrollado en Python diseñado para automatizar la extracción de información (Information Gathering) en páginas web. Utiliza bibliotecas estándar para analizar el código fuente e identificar posibles fugas de información.

**Funcionamiento**
* Realiza una petición HTTP GET a la URL objetivo mediante la librería `requests`.
* Analiza y parsea el código fuente HTML de la respuesta utilizando `BeautifulSoup`.
* Identifica y extrae todos los comentarios ocultos en el código fuente (``).
* Utiliza expresiones regulares (`re`) para buscar y extraer cualquier dirección de correo electrónico expuesta en la página.
* Consolida y almacena los resultados clasificados (Comentarios y Correos) en un archivo de texto local llamado `resultado`.

---

#### 4.2 Barrido de Directorios Web

**Archivo:** [barridoWEB_19-04-2026.sh](https://github.com/kevinmaar/Linux-Admin-Toolkit/blob/main/barridoWEB_19-04-2026.sh)

##### **Descripción**
Herramienta de línea de comandos en Bash para realizar *Fuzzing* o descubrimiento de rutas y archivos en servidores web. Utiliza un ataque basado en diccionario para mapear la estructura de directorios no enlazados públicamente.

**Funcionamiento**
* Valida que el usuario proporcione obligatoriamente dos parámetros: la URL objetivo y la ruta a un archivo de diccionario válido.
* Lee el diccionario de forma iterativa, concatenando cada palabra a la dirección web base.
* Envía una petición HTTP HEAD (`curl -I`) a cada URL generada. Esto evalúa la existencia del recurso obteniendo solo las cabeceras de respuesta, optimizando la velocidad del escaneo.
* Filtra la salida para imprimir en pantalla únicamente las rutas que devuelven un código de estado HTTP `200` (OK), indicando que el recurso existe y es accesible.

---

#### 4.3 Barrido de Red

**Archivo:** [barridoRED_19-04-2026.sh](https://github.com/kevinmaar/Linux-Admin-Toolkit/blob/main/barridoRED_19-04-2026.sh)

##### **Descripción**
Script de Bash diseñado para ejecutar la fase de descubrimiento de hosts (Ping Sweep) dentro de una o múltiples redes locales. Identifica de manera automatizada qué dispositivos se encuentran activos en los segmentos de red a los que el equipo está conectado.

**Funcionamiento**
* Inspecciona la configuración de red del sistema utilizando el comando `ip a`.
* Filtra la salida para omitir la interfaz de loopback (`127.0.0.1`) y extrae dinámicamente los primeros tres octetos para identificar los segmentos de red actuales.
* Elimina posibles segmentos duplicados (`sort -u`).
* Itera sobre cada segmento de red descubierto, generando las 254 direcciones IP posibles (del 1 al 254).
* Envía un único paquete ICMP Echo Request (`ping -c 1`) a cada IP generada, configurando un tiempo de espera máximo de 1 segundo (`-W 1`).
* Reporta en la terminal las direcciones IP que responden exitosamente al ping, marcándolas como `DISPOSITIVO DETECTADO`.

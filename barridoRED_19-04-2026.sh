#!/usr/bin/env bash

#Inicio
#
#Obtener las direcciones IP del equipo.
#Filtrar las direcciones:
#Quitar la dirección 127.0.0.1.
#Obtener solo los primeros 3 octetos (segmento de red).
#Eliminar duplicados.
#Para cada segmento de red obtenido hacer:
#Para cada número del 1 al 254 hacer:
#Construir una IP: segmento + "." + número
#Enviar un ping a esa IP.
#Si responde:
#Mostrar: "DISPOSITIVO DETECTADO → IP"
#Fin de los ciclos.
#Mostrar lista final de dispositivos detectados.
#
#Fin

DIRECCIONES="$(ip a | grep -E -o "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v "127.0.0.1" | cut -d "." -f 1,2,3 | sort -u)"

for ip in $DIRECCIONES; do
    for host in $(seq 1 254); do
        ping -c 1 -W 1 "$ip.$host" &>/dev/null && echo "DISPOSITIVO DETECTADO --> $ip.$host" 
    done
done



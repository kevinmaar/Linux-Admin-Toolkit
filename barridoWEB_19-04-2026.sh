#!/usr/bin/env bash

#Inicio
#
#Verificar que se reciban al menos 2 parámetros:
#Dirección del servidor web.
#Archivo diccionario.
#Si faltan parámetros:
#Mostrar "Parámetros insuficientes".
#Terminar programa.
#Verificar que el archivo diccionario exista.
#Si no existe:
#Mostrar "Diccionario no válido".
#Terminar programa.
#Leer cada línea del archivo diccionario.
#Para cada palabra (recurso) hacer:
#Construir la URL: direccion + "/" + recurso
#Enviar una petición HTTP al servidor.
#Obtener el código de estado de la respuesta.
#Si el código es 200:
#Mostrar la URL y el código.
#Terminar cuando se acaben las palabras.
#
#Fin

[ $# -lt 2 ] && { echo "Parametros insuficientes" >&2; exit 1; }
[ ! -f "$2" ] && { echo "DICCIONARIO NO VALIDO" >&2; exit 1; } 

diccionario="$2"
direccion="$1"

while read sitio; do
    status="$(curl -s -I "$direccion/$sitio" | head -n 1 | cut -d " " -f 2)"
    [ "$status" == "200" ] && echo "$direccion/$sitio" -- [$status]
done < "$diccionario"


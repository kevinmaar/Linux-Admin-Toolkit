#!/usr/bin/env bash

[ $# -eq 1 ] || { echo "Falta el nombre del archivo"; exit 1; }

archivo="$1"
papelera="$HOME/.papelera"

[ -f "$papelera/$archivo" ] || { echo "Archivo no encontrado en papelera"; exit 1; }

ruta=$(cat "$papelera/$archivo.ruta")

mkdir -p "$(dirname "$ruta")"
mv "$papelera/$archivo" "$ruta"

echo "Archivo restaurado en -- $ruta"

rm "$papelera/$archivo.ruta"

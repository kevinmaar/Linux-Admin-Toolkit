#!/usr/bin/env bash

[ $# -eq 1 ] || { echo "Falta el archivo"; exit 1; }

archivo="$1"
papelera="$HOME/.papelera"

[ -e "$archivo" ] || { echo "El archivo no existe"; exit 1; }

mkdir -p "$papelera"

ruta=$(realpath "$archivo")

mv "$archivo" "$papelera"

echo "$ruta" > "$papelera/$(basename "$archivo").ruta"

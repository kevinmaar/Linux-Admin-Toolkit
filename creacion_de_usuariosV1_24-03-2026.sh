#!/usr/bin/env bash

[ "$UID" != "0" ] && { echo "El script debe ser ejecutado como root" >&2; exit 1; }

user=""
passwd=""
passwdCONF=""
band="true"

echo -n "Introduce el nombre del nuevo usuario: "
read user
id "$user" &>/dev/null  && { echo "El usuario '$user' ya existe." >&2; exit 1; }

while [ "$band" = "true" ]; do
    echo "Reglas de la contraseña:"
    echo ""
    echo "- Mínimo 8 caracteres"
    echo "- Al menos una letra mayúscula"
    echo "- Al menos un número"
    echo ""
    echo -n "Introduce la contraseña: "
    read passwd
    echo -n "Confirma la contraseña: "
    read passwdCONF

    [ "$passwd" != "$passwdCONF" ] && { echo "Las contraseñas no coinciden." >&2; continue; }
    [ ${#passwd} -lt 8 ] && { echo "La contraseña es demasiado corta (mínimo 8)" >&2; continue; }
    
    if ! echo "$passwd" | grep -q [A-Z]; then
        echo "La contraseña debe tener al menos una mayuscula" >&2
        continue
    fi

    if ! echo "$passwd" | grep -q [0-9]; then
        echo "La contraseña debe tener al menos un numero" >&2
        continue
    fi
    band="false"
done

if [ "$band" = "false" ]; then
    useradd -m -s /bin/bash "$user" && echo "$user:$passwd" | chpasswd || { echo "Error creando usuario" >&2; exit 1; } 
fi

echo -n "¿Deseas asignar cuota al usuario? (s/n): "
read cuota_opcion

if [ "$cuota_opcion" = "s" ]; then
    echo -n "Introduce el límite SOFT (en bloques KB): "
    read soft

    echo -n "Introduce el límite HARD (en bloques KB): "
    read hard

    setquota -u "$user" "$soft" "$hard" 0 0 /

    echo -n "¿Deseas cambiar el periodo de gracia? (s/n): "
    read opcion_gracia

    if [ "$opcion_gracia" = "s" ]; then
        echo -n "Introduce el periodo de gracia en segundos: "
        read gracia

        setquota -t "$gracia" "$gracia" /
    fi

    echo "Cuotas asignadas correctamente."
fi

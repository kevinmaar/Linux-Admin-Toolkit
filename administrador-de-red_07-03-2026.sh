#!/usr/bin/env bash

[ "$EUID" -ne 0 ] && { echo "Ejecuta este script como root"; exit 1; }

ver_interfaces(){
    ip -br link show
}

modificar_interfaz(){
    clear
    echo "--------------------------"
    echo "Cambiar estado de interfaz"
    echo "--------------------------"
    echo ""
    ver_interfaces
    echo ""
    echo -n "Nombre de la interfaz: "
    read interfaz
    ver_interfaces | grep -w "$interfaz" > /dev/null || { echo "Interfaz desconocida, saliendo..."; return 1; }
    echo
    echo "1 - UP"
    echo "2 - DOWN"
    echo "3 - Cancelar"
    echo -n "Selecciona una opcion: "
    read opc
    [ "$opc" == "1" ] && { ip link set dev "$interfaz" up; return 0; }
    [ "$opc" == "2" ] && { ip link set dev "$interfaz" down; return 0; }
    return 0;
}

conexion_WIFI(){
    echo "--------------------------------"
    echo "Conectarse a una red inalambrica"
    echo "--------------------------------"
    echo ""
    ver_interfaces
    echo ""
    echo -n "Nombre de la interfaz: "
    read interfaz
    ip link set dev "$interfaz" up
    iw dev "$interfaz" scan | grep SSID
    echo -n "Nombre de la red: "
    read red
    echo -n "Password: "
    read password
    wpa_passphrase "$red" "$password" > /tmp/wifi
    wpa_supplicant -B -i "$interfaz" -c /tmp/wifi
    conexion_estatica_dinamica "$interfaz"
}

conexion_estatica_dinamica(){
    echo "Seleccionar configuración"
    echo ""
    echo "1. Dinamica (DHCP)"
    echo "2. Estatica"
    echo -n "Selecciona una opcion: "
    read opc
    if [ "$opc" == "1" ]; then
        dhclient -v "$1"
        echo ""
        echo "Guardar configuracion de manera persistente?"
        echo "1 - Si"
        echo "2 - No"
        echo ""
        echo -n "Selecciona una opcion: "
        read opc_guardar
        if [ "$opc_guardar" == "1" ]; then
            echo 'echo "Configurando red dinámica ..."' >> ~/.bashrc
            if [ -f /tmp/wifi ]; then
                mv /tmp/wifi ~/.wifi
                echo "sudo wpa_supplicant -B -i $1 -c ~/.wifi" >> ~/.bashrc
            fi
            echo "sudo dhclient -v $1" >> ~/.bashrc
            echo "Configuración guardada en ~/.bashrc"
        elif [ "$opc_guardar" == "2" ]; then
            return 0
        fi
    elif [ "$opc" == "2" ]; then 
        echo ""
        echo -n "Dirección IP: "
        read ip
        echo -n "Máscara de red o prefijo: "
        read mascara
        echo -n "Gateway: "
        read gateway
        echo -n "DNS: "
        read dns
        ip addr flush dev "$1"
        ip addr add "$ip/$mascara" dev "$1"
        ip route del default 2>/dev/null
        ip route add default via "$gateway"
        echo "nameserver $dns" > /etc/resolv.conf
        echo ""
        echo "Guardar configuracion de manera persistente?"
        echo "1 - Si"
        echo "2 - No"
        echo ""
        echo -n "Selecciona una opcion: "
        read opc_guardar
        if [ "$opc_guardar" == "1" ]; then
            echo 'echo "Configurando red estática ..."' >> ~/.bashrc
            echo "sudo ip link set dev $1 up" >> ~/.bashrc
            if [ -f /tmp/wifi ]; then
                mv /tmp/wifi ~/.wifi
                echo "sudo wpa_supplicant -B -i $1 -c ~/.wifi" >> ~/.bashrc
            fi
            echo "sudo ip addr flush dev $1" >> ~/.bashrc
            echo "sudo ip addr add $ip/$mascara dev $1" >> ~/.bashrc
            echo "sudo ip route del default 2>/dev/null"  >> ~/.bashrc
            echo "sudo ip route add default via $gateway" >> ~/.bashrc
            echo "sudo sh -c 'echo \"nameserver $dns\" > /etc/resolv.conf'" >> ~/.bashrc
            echo "Configuración guardada en ~/.bashrc"
        elif [ "$opc_guardar" == "2" ]; then
            return 0
        fi
    else
        echo ""
        echo "Opcion invalida"
        echo ""
    fi
}

configuracion_IP(){
    echo "-----------------------"
    echo "Configurar direccion IP"
    echo "-----------------------"
    echo ""
    ver_interfaces
    echo ""
    echo -n "Nombre de la interfaz: "
    read interfaz
    conexion_estatica_dinamica "$interfaz"
}

menu(){
    clear
    echo "====================================="
    echo "       ADMINISTRADOR DE RED"
    echo "====================================="
    echo ""
    echo "1) Mostrar interfaces de red"
    echo "2) Cambiar estado de una interfaz (UP / DOWN)"
    echo "3) Conectarse a una red WiFi"
    echo "4) Configurar dirección IP"
    echo "5) Salir"
    echo ""
    echo -n "Seleccione una opción: "
    read opc
    echo ""
    if [ "$opc" == "1" ]; then
        ver_interfaces
    elif [ "$opc" == "2" ]; then
        modificar_interfaz
    elif [ "$opc" == "3" ]; then
        conexion_WIFI
    elif  [ "$opc" == "4" ]; then
        configuracion_IP
    elif [ "$opc" == "5" ]; then
        exit 0
    else 
        echo "OPCION INVALIDA"
    fi
    read -p "Presiona Enter para continuar..."
}

while true; do
    menu
done

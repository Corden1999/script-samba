#!/bin/bash

# Colores pa mi (brillantes para mejor visibilidad)
ROJO_BRILLANTE='\033[1;31m'     
VERDE_BRILLANTE='\033[1;32m'     
AMARILLO_BRILLANTE='\033[1;33m' 
AZUL_BRILLANTE='\033[1;34m'      
MAGENTA_BRILLANTE='\033[1;35m'   
CIAN_BRILLANTE='\033[1;36m'     
BLANCO_BRILLANTE='\033[1;37m'  

# Sin formato
SIN_FORMATO='\033[0m'     #alonsismo

while true; do
    # info red
    echo -e "${AZUL_BRILLANTE}=== Datos de red de tu equipo  ==="
    echo -e "IP Local: $(hostname -I | xargs)"
    echo -e "Hostname: $(hostname)"
    echo -e "Interfaces de red:"
    ip -o -4 addr show | awk '{printf "   %-7s %s\n", $2":", $4}'
    echo -e "${SIN_FORMATO}"

    # status
    if systemctl is-active smbd &> /dev/null; then
        echo -e "${VERDE_BRILLANTE}El servicio Samba está en ejecución.${SIN_FORMATO}"
    else
        echo -e "${ROJO_BRILLANTE}El servicio Samba no está en ejecución.${SIN_FORMATO}"
    fi

    # happy meal
    echo -e "${VERDE_BRILLANTE}=== Menú script ==="
    echo "Seleccione el número de la acción que quiere realizar:"
    echo "1. Instalar Samba"
    echo "2. Eliminar Samba"
    echo "3. Iniciar servicio"
    echo "4. Detener servicio"
    echo "5. Consultar logs"
    echo "6. Editar configuración"
    echo "7. Reiniciar servicio"
    echo "8. Salir"
    echo -e "${SIN_FORMATO}"

    # absolute
    read -p "Ingrese su opción (1-8): " option

    # cinema
    case $option in
        1)
            echo -e "${VERDE_BRILLANTE}=== Menú instalación ==="
            echo "Seleccione el número de la acción que quiere realizar:"
            echo "1. Instalar Con comandos"
            echo "2. Instalar Con Ansible"
            echo "3. Instalar Con Docker"
            read -p "Ingrese su opción (1-3): " instalacion_del_servicio
            case $instalacion_del_servicio in
                1)
                    echo -e "${AMARILLO_BRILLANTE}Instalando Samba Con comandos...${SIN_FORMATO}"
                    echo "Manito."
                    echo -e "${VERDE_BRILLANTE}Samba instalado correctamente.${SIN_FORMATO}"
                    ;;
                2)
                    echo -e "${AMARILLO_BRILLANTE}Instalando Samba Con Ansible...${SIN_FORMATO}"
                    echo "Pablito."
                    echo -e "${VERDE_BRILLANTE}Samba instalado correctamente.${SIN_FORMATO}"
                    ;;
                3)
                    echo -e "${AMARILLO_BRILLANTE}Instalando Samba Con Docker...${SIN_FORMATO}"
                    echo "Manito."
                    echo -e "${VERDE_BRILLANTE}Samba instalado correctamente.${SIN_FORMATO}"
                    ;;
                *)
                    echo -e "${ROJO_BRILLANTE}Opción no válida.${SIN_FORMATO}"
                    ;;
            esac
            ;;
        2)
            echo -e "${ROJO_BRILLANTE}Eliminación del servicio...${SIN_FORMATO}"
            sudo apt remove --purge samba -y
            echo -e "${VERDE_BRILLANTE}Samba eliminado correctamente.${SIN_FORMATO}"
            ;;
        3)
            echo -e "${AMARILLO_BRILLANTE}Puesta en marcha...${SIN_FORMATO}"
            sudo systemctl start smbd
            echo -e "${VERDE_BRILLANTE}Servicio Samba iniciado.${SIN_FORMATO}"
            ;;
        4)
            echo -e "${ROJO_BRILLANTE}Parada...${SIN_FORMATO}"
            sudo systemctl stop smbd
            echo -e "${VERDE_BRILLANTE}Servicio Samba detenido.${SIN_FORMATO}"
            ;;
        5)
            echo -e "${AMARILLO_BRILLANTE}Consultar logs:...${SIN_FORMATO}"
            echo "1. Por fecha"
            echo "2. Por tipo"
            echo "3. Etc"
            read -p "Ingrese su opción (1-3): " Consultar_logs
            case $Consultar_logs in
                1)
                    echo -e "${AMARILLO_BRILLANTE}Mostrando logs por fecha...${SIN_FORMATO}"
                    sudo journalctl -u smbd --since yesterday
                    ;;
                2)
                    echo -e "${AMARILLO_BRILLANTE}Mostrando logs por tipo...${SIN_FORMATO}"
                    sudo journalctl -u smbd -p err
                    ;;
                3)
                    echo -e "${AMARILLO_BRILLANTE}Mostrando todos los logs...${SIN_FORMATO}"
                    sudo journalctl -u smbd
                    ;;
                *)
                    echo -e "${ROJO_BRILLANTE}Opción no válida.${SIN_FORMATO}"
                    ;;
            esac
            ;;
        6)
            echo -e "${AMARILLO_BRILLANTE}Editando la configuración de Samba...${SIN_FORMATO}"
            sudo nano /etc/samba/smb.conf
            ;;
        7)
            echo -e "${AZUL_BRILLANTE}Reiniciando el servicio Samba...${SIN_FORMATO}"
            sudo systemctl restart smbd
            echo -e "${VERDE_BRILLANTE}Servicio Samba reiniciado.${SIN_FORMATO}"
            ;;
        8)
            echo -e "${AZUL_BRILLANTE}Saliendo del menú...${SIN_FORMATO}"
            break
            ;;
        *)
            echo -e "${ROJO_BRILLANTE}Opción no válida. Intente de nuevo.${SIN_FORMATO}"
            ;;
    esac

    # let him/her cook
    read -p "Presione Enter para continuar..."
done

#!/bin/bash

# Symbols for visual differentiation
CHECK_MARK='✔️'
CROSS_MARK='❌'
INFO='ℹ️'
MENU='📋'
EDIT='✏️'
RESTART='🔄'
EXIT='🚪'
INSTALL='⬇️'
REMOVE='🗑️'
START='▶️'
STOP='⏹️'
LOGS='📝'

while true; do
    # info red
    echo -e "${INFO} === Datos de red de tu equipo  ==="
    echo -e "IP Local: $(hostname -I | xargs)"
    echo -e "Hostname: $(hostname)"
    echo -e "Interfaces de red:"
    ip -o -4 addr show | awk '{printf "   %-7s %s\n", $2":", $4}'

    # status
    if systemctl is-active smbd &> /dev/null; then
        echo -e "${CHECK_MARK} El servicio Samba está en ejecución."
    else
        echo -e "${CROSS_MARK} El servicio Samba no está en ejecución."
    fi

    # happy meal
    echo -e "${MENU} === Menú script ==="
    echo "Seleccione el número de la acción que quiere realizar:"
    echo "1. Instalar Samba ${INSTALL}"
    echo "2. Eliminar Samba ${REMOVE}"
    echo "3. Iniciar servicio ${START}"
    echo "4. Detener servicio ${STOP}"
    echo "5. Consultar logs ${LOGS}"
    echo "6. Editar configuración ${EDIT}"
    echo "7. Reiniciar servicio ${RESTART}"
    echo "8. Salir ${EXIT}"

    # absolute cinema
    read -p "Ingrese su opción (1-8): " option

   
    case $option in
        1)
            echo -e "${INSTALL} === Menú instalación ==="
            echo "Seleccione el número de la acción que quiere realizar:"
            echo "1. Instalar Con comandos"
            echo "2. Instalar Con Ansible"
            echo "3. Instalar Con Docker"
            read -p "Ingrese su opción (1-3): " instalacion_del_servicio
            case $instalacion_del_servicio in
                1)
                    echo "Instalando Samba Con comandos..."
                    echo "Manito."
                    echo -e "${CHECK_MARK} Samba instalado correctamente."
                    ;;
                2)
                    echo "Instalando Samba Con Ansible..."
                    echo "Pablito."
                    echo -e "${CHECK_MARK} Samba instalado correctamente."
                    ;;
                3)
                    echo "Instalando Samba Con Docker..."
                    echo "Manito."
                    echo -e "${CHECK_MARK} Samba instalado correctamente."
                    ;;
                *)
                    echo -e "${CROSS_MARK} Opción no válida."
                    ;;
            esac
            ;;
        2)
            echo "Eliminación del servicio..."
            sudo apt remove --purge samba -y
            echo -e "${CHECK_MARK} Samba eliminado correctamente."
            ;;
        3)
            echo "Puesta en marcha..."
            sudo systemctl start smbd
            echo -e "${CHECK_MARK} Servicio Samba iniciado."
            ;;
        4)
            echo "Parada..."
            sudo systemctl stop smbd
            echo -e "${CHECK_MARK} Servicio Samba detenido."
            ;;
        5)
            echo "Consultar logs:..."
            echo "1. Por fecha"
            echo "2. Por tipo"
            echo "3. Etc"
            read -p "Ingrese su opción (1-3): " Consultar_logs
            case $Consultar_logs in
                1)
                    echo "Mostrando logs por fecha..."
                    sudo journalctl -u smbd --since yesterday
                    ;;
                2)
                    echo "Mostrando logs por tipo..."
                    sudo journalctl -u smbd -p err
                    ;;
                3)
                    echo "Mostrando todos los logs..."
                    sudo journalctl -u smbd
                    ;;
                *)
                    echo -e "${CROSS_MARK} Opción no válida."
                    ;;
            esac
            ;;
        6)
            echo "Editando la configuración de Samba..."
            sudo nano /etc/samba/smb.conf
            ;;
        7)
            echo "Reiniciando el servicio Samba..."
            sudo systemctl restart smbd
            echo -e "${CHECK_MARK} Servicio Samba reiniciado."
            ;;
        8)
            echo "Saliendo del menú..."
            break
            ;;
        *)
            echo -e "${CROSS_MARK} Opción no válida. Intente de nuevo."
            ;;
    esac

    
    read -p "Presione Enter para continuar..."
done

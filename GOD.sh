#!/bin/bash

# Definir colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

while true; do
    # info red
    echo -e "${BLUE}=== Datos de red ==="
    echo -e "IP Local: $(hostname -I | xargs)"
    echo -e "Hostname: $(hostname)"
    echo -e "Interfaces de red:"
    ip -o -4 addr show | awk '{printf "   %-7s %s\n", $2":", $4}'
    echo -e "${NC}"

    # status
    if systemctl is-active smbd &> /dev/null; then
        echo -e "${GREEN}El servicio Samba está en ejecución.${NC}"
    else
        echo -e "${RED}El servicio Samba no está en ejecución.${NC}"
    fi

    # happy meal
    echo -e "${GREEN}=== Menú Samba ==="
    echo "Seleccione el número de la acción que quiere realizar:"
    echo "1. Instalar Samba"
    echo "2. Eliminar Samba"
    echo "3. Iniciar servicio"
    echo "4. Detener servicio"
    echo "5. Consultar logs"
    echo "6. Editar configuración"
    echo "7. Reiniciar servicio"
    echo "8. Salir"
    echo -e "${NC}"

    # absolute
    read -p "Ingrese su opción (1-8): " option

    # cinema
    case $option in
        1)
            echo -e "${GREEN}=== Menú instalación del servicio ==="
            echo "Seleccione el número de la acción que quiere realizar:"
            echo "1. Instalar Con comandos"
            echo "2. Instalar Con Ansible"
            echo "3. Instalar Con Docker"
            read -p "Ingrese su opción (1-3): " instalacion_del_servicio
            case $instalacion_del_servicio in
                1)
                    echo -e "${YELLOW}Instalando Samba con comandos...${NC}"
                    echo "Manito."
                    echo -e "${GREEN}Samba instalado correctamente.${NC}"
                    ;;
                2)
                    echo -e "${YELLOW}Instalando Samba con Ansible...${NC}"
                    echo "Pablito."
                    ;;
                3)
                    echo -e "${YELLOW}Instalando Samba con Docker...${NC}"
                    echo "Manito."
                    ;;
                *)
                    echo -e "${RED}Opción no válida.${NC}"
                    ;;
            esac
            ;;
        2)
            echo -e "${RED}Eliminación del servicio...${NC}"
            sudo apt remove --purge samba -y
            echo -e "${GREEN}Samba eliminado correctamente.${NC}"
            ;;
        3)
            echo -e "${YELLOW}Puesta en marcha...${NC}"
            sudo systemctl start smbd
            echo -e "${GREEN}Servicio Samba iniciado.${NC}"
            ;;
        4)
            echo -e "${RED}Parada...${NC}"
            sudo systemctl stop smbd
            echo -e "${GREEN}Servicio Samba detenido.${NC}"
            ;;
        5)
            echo -e "${YELLOW}Consultar logs:...${NC}"
            echo "1. Por fecha"
            echo "2. Por tipo"
            echo "3. Etc"
            read -p "Ingrese su opción (1-3): " Consultar_logs
            case $Consultar_logs in
                1)
                    echo -e "${YELLOW}Mostrando logs por fecha...${NC}"
                    sudo journalctl -u smbd --since today
                    ;;
                2)
                    echo -e "${YELLOW}Mostrando logs por tipo...${NC}"
                    sudo journalctl -u smbd -p err
                    ;;
                3)
                    echo -e "${YELLOW}Mostrando todos los logs...${NC}"
                    sudo journalctl -u smbd
                    ;;
                *)
                    echo -e "${RED}Opción no válida.${NC}"
                    ;;
            esac
            ;;
        6)
            echo -e "${YELLOW}Editando la configuración de Samba...${NC}"
            sudo nano /etc/samba/smb.conf
            ;;
        7)
            echo -e "${BLUE}Reiniciando el servicio Samba...${NC}"
            sudo systemctl restart smbd
            echo -e "${GREEN}Servicio Samba reiniciado.${NC}"
            ;;
        8)
            echo -e "${BLUE}Saliendo del menú...${NC}"
            break
            ;;
        *)
            echo -e "${RED}Opción no válida. Intente de nuevo.${NC}"
            ;;
    esac

    # let him/her cook
    read -p "Presione Enter para continuar..."
done

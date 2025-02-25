#!/bin/bash

# emojis
CHECK_MARK='✔️'
CROSS_MARK='❌'
INFO='ℹ️'
MENU='📋'
EDIT='✏️'
REINICIAR='🔄'
SALIR='🚪'
INSTALAR='⬇️'
ELIMINAR='🗑️'
INICIAR='▶️'
DETENER='⏹️'
LOGS='📝'

# 33 escape 1 negrita 90 a 97 brillante
BLANCO='\033[1;97m'      
AMARILLO='\033[1;93m'    
CIAN='\033[1;96m'       
VERDE='\033[1;92m'       
ROJO='\033[1;91m'       
MAGENTA='\033[1;95m'     
AZUL='\033[1;94m'        
RESET='\033[0m'          

# ;40m fondo negro ;44 fondo azul 
BLANCO_SOBRE_AZUL='\033[1;97;44m'   # Blanco brillante sobre azul oscuro
AMARILLO_SOBRE_NEGRO='\033[1;93;40m' # Amarillo sobre negro
CIAN_SOBRE_NEGRO='\033[1;96;40m'     # Cian sobre negro
VERDE_SOBRE_NEGRO='\033[1;92;40m'    # Verde sobre negro
ROJO_SOBRE_NEGRO='\033[1;91;40m'     # Rojo sobre negro
MAGENTA_SOBRE_NEGRO='\033[1;95;40m'  # Magenta sobre negro

# Función para limpiar la pantalla
limpiar_pantalla() {
    clear
}

while true; do
    limpiar_pantalla

    # Información de red
    echo -e "${INFO} ${BLANCO_SOBRE_AZUL}=== Información de Red de tu Equipo ===${RESET}"
    echo -e "${BLANCO}IP Local:${RESET} $(hostname -I | xargs)"
    echo -e "${BLANCO}Nombre del Equipo:${RESET} $(hostname)"
    echo -e "${BLANCO}Interfaces de Red:${RESET}"
    ip -o -4 addr show | awk '{printf "   %-7s %s\n", $2":", $4}'

    # Estado del servicio Samba
    if systemctl is-active smbd &> /dev/null; then
        echo -e "${CHECK_MARK} ${VERDE}El servicio Samba está en ejecución.${RESET}"
    else
        echo -e "${CROSS_MARK} ${ROJO}El servicio Samba no está en ejecución.${RESET}"
    fi

    # Menú principal
    echo -e "${MENU} ${CIAN_SOBRE_NEGRO}=== Menú Principal ===${RESET}"
    echo "Seleccione el número de la acción que desea realizar:"
    echo -e "${AMARILLO}1. Instalar Samba ${INSTALAR}${RESET}"
    echo -e "${AMARILLO}2. Eliminar Samba ${ELIMINAR}${RESET}"
    echo -e "${AMARILLO}3. Iniciar Servicio ${INICIAR}${RESET}"
    echo -e "${AMARILLO}4. Detener Servicio ${DETENER}${RESET}"
    echo -e "${AMARILLO}5. Consultar Registros (Logs) ${LOGS}${RESET}"
    echo -e "${AMARILLO}6. Editar Configuración ${EDIT}${RESET}"
    echo -e "${AMARILLO}7. Reiniciar Servicio ${REINICIAR}${RESET}"
    echo -e "${AMARILLO}8. Salir ${SALIR}${RESET}"

    # Leer la opción del usuario
    read -p "Ingrese su opción (1-8): " opcion

    case $opcion in
        1)
            echo -e "${INSTALAR} ${MAGENTA_SOBRE_NEGRO}=== Menú de Instalación ===${RESET}"
            echo "Seleccione el método de instalación:"
            echo -e "${CIAN}1. Instalar usando comandos manuales${RESET}"
            echo -e "${CIAN}2. Instalar usando Ansible${RESET}"
            echo -e "${CIAN}3. Instalar usando Docker${RESET}"
            read -p "Ingrese su opción (1-3): " metodo_instalacion
            case $metodo_instalacion in
                1)
                    echo -e "${CIAN}Instalando Samba usando comandos manuales...${RESET}"
                    echo "Manito."
                    echo -e "${CHECK_MARK} ${VERDE}Samba instalado correctamente.${RESET}"
                    ;;
                2)
                    echo -e "${CIAN}Instalando Samba usando Ansible...${RESET}"
                    echo "Pablito."
                    echo -e "${CHECK_MARK} ${VERDE}Samba instalado correctamente.${RESET}"
                    ;;
                3)
                    echo -e "${CIAN}Instalando Samba usando Docker...${RESET}"
                    echo "Manito."
                    echo -e "${CHECK_MARK} ${VERDE}Samba instalado correctamente.${RESET}"
                    ;;
                *)
                    echo -e "${CROSS_MARK} ${ROJO}Opción no válida.${RESET}"
                    ;;
            esac
            ;;
        2)
            echo -e "${ELIMINAR} ${ROJO_SOBRE_NEGRO}Eliminando Samba...${RESET}"
            sudo apt remove --purge samba -y
            echo -e "${CHECK_MARK} ${VERDE}Samba eliminado correctamente.${RESET}"
            ;;
        3)
            echo -e "${INICIAR} ${VERDE_SOBRE_NEGRO}Iniciando el servicio Samba...${RESET}"
            sudo systemctl start smbd
            echo -e "${CHECK_MARK} ${VERDE}Servicio Samba iniciado.${RESET}"
            ;;
        4)
            echo -e "${DETENER} ${ROJO_SOBRE_NEGRO}Deteniendo el servicio Samba...${RESET}"
            sudo systemctl stop smbd
            echo -e "${CHECK_MARK} ${VERDE}Servicio Samba detenido.${RESET}"
            ;;
        5)
            echo -e "${LOGS} ${CIAN_SOBRE_NEGRO}Consultando Registros (Logs):${RESET}"
            echo -e "${CIAN}1. Mostrar registros por fecha${RESET}"
            echo -e "${CIAN}2. Mostrar registros por tipo de error${RESET}"
            echo -e "${CIAN}3. Mostrar todos los registros${RESET}"
            read -p "Ingrese su opción (1-3): " tipo_logs
            case $tipo_logs in
                1)
                    echo -e "${CIAN}Mostrando registros por fecha...${RESET}"
                    sudo journalctl -u smbd --since yesterday
                    ;;
                2)
                    echo -e "${CIAN}Mostrando registros por tipo de error...${RESET}"
                    sudo journalctl -u smbd -p err
                    ;;
                3)
                    echo -e "${CIAN}Mostrando todos los registros...${RESET}"
                    sudo journalctl -u smbd
                    ;;
                *)
                    echo -e "${CROSS_MARK} ${ROJO}Opción no válida.${RESET}"
                    ;;
            esac
            ;;
        6)
            echo -e "${EDIT} ${MAGENTA_SOBRE_NEGRO}Editando la configuración de Samba...${RESET}"
            sudo nano /etc/samba/smb.conf
            ;;
        7)
            echo -e "${REINICIAR} ${VERDE_SOBRE_NEGRO}Reiniciando el servicio Samba...${RESET}"
            sudo systemctl restart smbd
            echo -e "${CHECK_MARK} ${VERDE}Servicio Samba reiniciado.${RESET}"
            ;;
        8)
            echo -e "${SALIR} ${ROJO_SOBRE_NEGRO}Saliendo del menú...${RESET}"
            break
            ;;
        *)
            echo -e "${CROSS_MARK} ${ROJO}Opción no válida. Intente de nuevo.${RESET}"
            ;;
    esac

    read -p "Presione Enter para continuar..."
done

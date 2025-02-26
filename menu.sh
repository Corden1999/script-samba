#!/bin/bash

# Emojis
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

# Colores
BLANCO='\033[1;97m'      
AMARILLO='\033[1;93m'    
CIAN='\033[1;96m'       
VERDE='\033[1;92m'       
ROJO='\033[1;91m'       
MAGENTA='\033[1;95m'     
AZUL='\033[1;94m'        
RESET='\033[0m'          

BLANCO_SOBRE_AZUL='\033[1;97;44m'   
AMARILLO_SOBRE_NEGRO='\033[1;93;40m' 
CIAN_SOBRE_NEGRO='\033[1;96;40m'    
VERDE_SOBRE_NEGRO='\033[1;92;40m' 
ROJO_SOBRE_NEGRO='\033[1;91;40m'     
MAGENTA_SOBRE_NEGRO='\033[1;95;40m'

# Función para limpiar la pantalla
limpiar_pantalla() {
    clear
}

# Función para instalar Samba usando comandos manuales
instalar_samba() {
   #!/bin/bash

# Actualización del sistema
echo "Actualizando el sistema..."
sudo apt-get update -y && sudo apt-get upgrade -y

# Instalación de Samba
echo "Instalando Samba..."
sudo apt-get install samba -y

# Crear una carpeta compartida
echo "Creando una carpeta compartida..."
read -p "¿Dónde quieres crear la carpeta compartida? " ruta
sudo mkdir -p "$ruta"
sudo chmod -R 777 "$ruta"
ruta2="$ruta/Readme.txt"
echo "Archivo de prueba" >> "$ruta2"

# Configurar Samba para compartir la carpeta
echo "Configurando Samba..."
sudo bash -c 'cat >> /etc/samba/smb.conf' <<EOF
   [Carpeta_compartida]
   comment = samba grupo cristian, pablo y mario
   path = $ruta
   browsable = yes
   read only = no
EOF

# Poner contraseña del usuario administrador
echo "Configurando la contraseña del administrador..."
(echo "12345"; echo "12345") | sudo smbpasswd -a -s root

# Reiniciar el servicio de Samba
echo "Reiniciando el servicio de Samba..."
sudo systemctl restart smbd

# Verificar el estado del servicio
echo "Verificando el estado del servicio Samba..."
sudo systemctl status smbd

echo "Instalación y configuración de Samba completada."
echo "El directorio compartido está en: $ruta"

echo "Actualizando la lista de paquetes..."
sudo apt update
echo "Actualizando los paquetes instalados..."
sudo apt upgrade -y
echo "Limpiando paquetes innecesarios..."
sudo apt autoremove -y
}

# Función para instalar Samba con Ansible
instalar_samba_ansible() {
    #!/bin/bash

if command -v ansible &> /dev/null; then
  echo "Ansible esta instalado"
  ansible --version
  read -p "¿Desea hacer la configuración? (y-n) " configurar
  configurar=${configurar:-n}
  if [[ ! $configurar =~ ^[Yy]$ ]]; then
    echo "Salienddo"
    echo "Configuración e instalación de samba"

      read -p "Dime el nombre del recurso compartido: " nombre
      read -p "Dime la ubicación del recurso que desea compartir (No tiene por que existir): " ruta
      read -p "Dime el nombre de usuario para samba: " usuario
      read -p "Dime la contraseña para el usuario: " contrasena
      
      if [[ -z $nombre || -z $ruta || -z $usuario || -z $contrasena ]]; then
        echo "Tiene algun valor vacio"
        exit 1
      else
        ansible-playbook Instalacion_samba_ansible.yml --ask-become-pass \
        -e "nombre=$nombre" \
        -e "ruta=$ruta" \
        -e "usuario=$usuario" \
        -e "contrasena=$contrasena"
        exit 1
     fi
  fi
else
  echo "Instalando ansible"
  sudo apt-get update -y
  sudo apt-get upgrade -y
  sudo apt-get install -y ansible

  if command -v ansible &> /dev/null; then
    echo "Ansible instalado"
  else
    echo "Error: No se ha podido instalar"
    exit 1
  fi
fi
echo "Iniciando configuración";
read -p "Dime el directorio del inventario: " inventario
inventario=${inventario:-./inventario/hosts}
read -p "Que usuario quieres para aceder en remoto: " usuario
usuario=${usuario:-root}
ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa
read -p "¿Quieres agregar host y-n ?" host
host=${host:-y}
mkdir -p "$(dirname "$inventario")"
if [[ $host =~ ^[Yy]$ ]]; then
  while true; do
        read -p "Dime el nombre del grupo ('exit' para salir): " grupo
        if [[ "$grupo" == "exit" ]]; then
            break
        fi
        echo "[$grupo]" >> "$inventario"
        while true; do
            read -p "Dime la IP o el nombre del host ('exit' para salir del grupo): " ip
            if [[ "$ip" == "exit" ]]; then
                break
            fi
            echo "$ip" >> "$inventario"
            ssh-copy-id -i ~/.ssh/id_rsa.pub "$usuario@$ip"
        done
        echo "" >> "$inventario"
    done
    
  echo "Archivo de host creado"
fi 
echo "Crear archivo de configuración"

cat << EOF > ansible.cfg
[defaults]
inventory = $inventario
remote_user = $usuario
EOF
ansible all -m ping
if [[ $? -eq 0 ]]; then
   echo "Configuración e instalación de samba"

      read -p "Dime el nombre del recurso compartido: " nombre
      read -p "Dime la ubicación del recurso que desea compartir (No tiene por que existir): " ruta
      read -p "Dime el nombre de usuario para samba: " usuario
      read -p "Dime la contraseña para el usuario: " contrasena
      
      if [[ -z $nombre || -z $ruta || -z $usuario || -z $contrasena ]]; then
        echo "Tiene algun valor vacio"
        exit 1
      else
        ansible-playbook Instalacion_samba_ansible.yml --ask-become-pass \
        -e "nombre=$nombre" \
        -e "ruta=$ruta" \
        -e "usuario=$usuario" \
        -e "contrasena=$contrasena"
     fi
else
  echo "Error: No se pudo conectar al host remoto."
fi
echo "Ansible instalado y configurado correctamente"
}

# Función para instalar Samba con Docker
instalar_samba_docker() {
    #!/bin/bash

    # Actualizar el sistema
    sudo apt-get update
    sudo apt-get upgrade -y

    # Instalación de certificados y claves de Docker
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    # Detectar la versión de Ubuntu y agregar el repositorio de Docker
    . /etc/os-release
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $UBUNTU_CODENAME stable"

    # Actualizar e instalar Docker
    sudo apt-get update
    sudo apt install -y docker-ce
    sudo systemctl enable --now docker

    # Probar Docker
    sudo docker run hello-world

    # Descargar la imagen de Ubuntu
    sudo docker pull ubuntu

    # Crear y ejecutar el contenedor en segundo plano
    sudo docker run -dit --name my_ubuntu_container ubuntu

    # Ejecutar comandos dentro del contenedor
    sudo docker exec -it my_ubuntu_container bash -c "
        apt-get update && apt-get upgrade -y;

        # Instalar Samba dentro del contenedor
        apt-get install -y samba;

        # Crear una carpeta compartida dentro del contenedor
        mkdir -p /shared_folder;
        chmod -R 777 /shared_folder;
        echo 'Archivo de prueba' > /shared_folder/Readme.txt;

        # Configurar Samba para compartir la carpeta
        echo '[Carpeta_compartida]
        comment = samba grupo cristian, pablo y mario
        path = /shared_folder
        browsable = yes
        read only = no' >> /etc/samba/smb.conf;

        # Poner contraseña del usuario administrador
        echo 'Configurando la contraseña del administrador...'
        (echo "12345"; echo "12345") | sudo smbpasswd -a -s root
    
        # Reiniciar el servicio de Samba
        service smbd restart;

        # Verificar el estado del servicio Samba
        service smbd status;

        # Mensaje final
        echo 'Instalación y configuración de Samba completada dentro del contenedor.';
        echo 'El directorio compartido está en: /shared_folder';
    "

# Mensaje final fuera del contenedor
echo "El contenedor 'my_ubuntu_container' ha sido configurado y ejecutado correctamente."

# Actualización de software para Ubuntu
echo "Actualizando la lista de paquetes..."
sudo apt update
echo "Actualizando los paquetes instalados..."
sudo apt upgrade -y
echo "Limpiando paquetes innecesarios..."
sudo apt autoremove -y


#posteriormente para entrar en el bash del ubuntu haremos los siguiente:
#sudo docker exec -it my_ubuntu_container bash

}

# Menú principal
while true; do
    limpiar_pantalla

    # Información de red
    echo -e "${INFO} ${BLANCO_SOBRE_AZUL}=== Información de red de tu PC ===${RESET}"
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

    # Menú
    echo -e "${MENU} ${CIAN_SOBRE_NEGRO}=== Menú ===${RESET}"
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
            echo -e "${INSTALAR} ${MAGENTA_SOBRE_NEGRO}=== Menú de instalación ===${RESET}"
            echo "Seleccione el método de instalación:"
            echo -e "${CIAN}1. Instalar usando comandos manuales${RESET}"
            echo -e "${CIAN}2. Instalar usando Ansible${RESET}"
            echo -e "${CIAN}3. Instalar usando Docker${RESET}"
            read -p "Ingrese su opción (1-3): " modo_de_instalacion
            case $modo_de_instalacion in
                1)
                    instalar_samba
                    ;;
                2)
                    instalar_samba_ansible
                    ;;
                3)
                    instalar_samba_docker
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

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

#posteriormente para entrar en el bash del ubuntu haremos los siguiente:
#sudo docker exec -it my_ubuntu_container bash


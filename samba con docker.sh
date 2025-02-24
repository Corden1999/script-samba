#!/bin/bash

# Actualizar el sistema
sudo apt-get update
sudo apt-get upgrade -y

# Instalación de certificados y claves de Docker
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Instalación del repositorio de Docker
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt-get update
apt-cache policy docker-ce

# Instalación de Docker
sudo apt install -y docker-ce
sudo docker run hello-world

# Descargamos la imagen de Ubuntu
sudo docker pull ubuntu

# Implementamos el contenedor y ejecutamos comandos dentro de él
echo "Iniciando el contenedor de Ubuntu y ejecutando comandos dentro del contenedor..."
sudo docker run -it --name my_ubuntu_container ubuntu bash -c "
    # Actualizar el sistema dentro del contenedor
    apt-get update && apt-get upgrade -y;

    # Instalar Samba dentro del contenedor
    apt-get install -y samba;

    # Crear una carpeta compartida dentro del contenedor
    mkdir -p /shared_folder;
    chmod -R 777 /shared_folder;
    echo 'Archivo de prueba' > /shared_folder/Readme.txt;

    # Configurar Samba para compartir la carpeta
    cat >> /etc/samba/smb.conf <<EOF
[Carpeta_compartida]
   comment = samba grupo cristian, pablo y mario
   path = /shared_folder
   browsable = yes
   read only = no
EOF

    # Reiniciar el servicio de Samba
    systemctl restart smbd;

    # Verificar el estado del servicio Samba
    systemctl status smbd;

    # Mensaje final
    echo 'Instalación y configuración de Samba completada dentro del contenedor.';
    echo 'El directorio compartido está en: /shared_folder';
"

# Mensaje final fuera del contenedor
echo "El contenedor 'my_ubuntu_container' ha sido configurado y ejecutado."



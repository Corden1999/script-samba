#!/bin/bash

#Actualizacion del sistema
echo "Actualizando el sistema..."
sudo apt-get update -y && sudo apt-get upgrade -y

#Instalacion de samba 
echo "Instalando Samba..."
sudo apt-get install samba -y

#Crear una carpeta compartida
echo "Creando una carpeta compartida..."
read -p "Donde Quieres crear la carpeta compartida?" ruta
sudo mkdir -p "$ruta"
sudo chmod -R 777 "$ruta"
ruta2 = "$ruta/Readme.txt"
echo "Archivo de prueba" >> $ruta2

#Configurar Samba para compartir la carpeta
echo "configurando samba..."
sudo bash -c 'cat >> /etc/samba/smb.conf' <<EOF
[Carpeta_compartida]
   comment = samba grupo cristian, pablo y mario
   path = $ruta
   browsable = yes
   read only = no
EOF

#Reiniciar el servicio de samba
echo "Reiniciando el servivio de samba..."
sudo systemctl restart smbd

# Verificar el estado del servicio
echo "Verificando el estado del servicio Samba..."
sudo systemctl status smbd

echo "Instalación y configuración de Samba completada."
echo "El directorio compartido está en: $ruta"

#!/bin/bash

#Actualizacion del sistema
echo "Actualizando el sistema..."
sudo apt-get update -y && sudo apt-get upgrade -y

#Instalacion de samba 
echo "Instalando Samba..."
sudo apt-get install samba -y

#Crear una carpeta compartida
echo "Creando una carpeta compartida..."


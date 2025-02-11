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
sudo mkdir -p $ruta
sudo chmod -R 777 $ruta
ruta2 = "$ruta/Readme.txt"
echo "Archivo de prueba" >> $ruta2

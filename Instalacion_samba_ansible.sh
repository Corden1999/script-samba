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
      else
        ansible-playbook Instalacion_samba_ansible.yml --ask-become-pass \
        -e "nombre=$nombre" \
        -e "ruta=$ruta" \
        -e "usuario=$usuario" \
        -e "contrasena=$contrasena"
     fi
  fi
else
  echo "Instalando ansible"
  sudo apt-get update -y
  sudo apt upgrade -y
  sudo apt install -y ansible

  if command -v ansible &> /dev/null; then
    echo "Ansible instalado"
  else
    echo "Error: No se ha podido instalar"
    exit 1
  fi
fi
echo "Iniciando configuración";

read -p "Dime el directorio del inventario" inventario
inventario=${./inventory/hosts}
read -p "¿Quieres agregar host?" host
host=${host:-y}

if [[ $host =~ ^[Yy]$ ]]; then

  while true; do
        read -p "Dime el nombre del grupo ('exit' para salir): " grupo
        if [[ "$grupo" == "exit" ]]; then
            break
        fi
        echo "[$grupo]" >> "$inventario
        while true; do
            read -p "Dime la IP o el nombre del host ('exit' para salir del grupo): " ip
            if [[ "$ip" == "exit" ]]; then
                break
            fi
            echo "$ip" >> "$inventario"
        done
        echo "" >> "$inventario"
    done
    
  echo "Archivo de host creado"
  
echo "Crear archivo de configuración"
read -p "Que usuario quieres para aceder en remoto" usuario
usuario=${usuario:-root}
cat << EOF > ansible.cfg
[defaults]
inventory = $inventario
remote_user = $usuario
EOF

echo "Ansible instalado y configurado correctamente"


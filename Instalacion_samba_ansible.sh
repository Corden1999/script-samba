#!/bin/bash

if command -v ansible &> /dev/null; then
  echo "Ansible esta instalado"
  ansible --version
  read -p "¿Desea hacer la configuración? (y-n) " configurar
  configurar=${configurar:-n}
  if [[ ! $configurar =~ ^[Yy]$ ]]; then
    echo "Salienddo"
    exit 0
  fi
else
  echo "Instalando ansible"
  sudo apt update
  sudo apt install -y ansible

  if command -v ansible &> /dev/null; then
    echo "Ansible instalado"
  else
    echo "Error: No se ha podido instalar"
    exit 1
  fi
fi


mkdir -p ~/ansible-project/{inventory,playbooks,roles}
cd ~/ansible-project
while $
cat 


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

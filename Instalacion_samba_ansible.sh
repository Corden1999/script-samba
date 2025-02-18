#!/bin/bash

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

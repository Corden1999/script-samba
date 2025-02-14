show_menu() {
    clear
    network_info
    service_status
    
    echo -e "${GREEN}=== Menú Samba ==="
    echo "1. Instalar Samba"
    echo "1.1 Instalar Samba con comandos"
    echo "1.2 Instalar Samba con Ansible"
    echo "1.3 Instalar Samba con Docker"
    echo "2. Eliminar Samba"
    echo "3. Iniciar servicio"
    echo "4. Detener servicio"
    echo "5. Consultar logs"
    echo "6. Editar configuración"
    echo "7. Reiniciar servicio"
    echo "8. Salir"
    echo -e "${NC}"
}

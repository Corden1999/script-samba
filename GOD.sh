RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'


show_menu() {
    clear
    network_info
    service_status
    
    echo -e "${GREEN}=== Menú Samba ==="
     echo "Seleccione el numero de la accion que quiere realizar"
    echo "1. Instalar Samba"
    echo "2. Eliminar Samba"
    echo "3. Iniciar servicio"
    echo "4. Detener servicio"
    echo "5. Consultar logs"
    echo "6. Editar configuración"
    echo "7. Reiniciar servicio"
    echo "8. Salir"
    echo -e "${NC}"
}

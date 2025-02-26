

## ¿Qué es Samba?

Samba es un software de código abierto que implementa el protocolo SMB/CIFS, permitiendo la interoperabilidad entre sistemas operativos Linux/Unix y Windows en una red. Funciona como un servidor que facilita la compartición de archivos, impresoras y otros recursos entre estos sistemas, permitiendo que usuarios de Windows puedan acceder a directorios y dispositivos conectados en un servidor Linux, y viceversa. Su capacidad de integración con servicios de autenticación como Active Directory también lo hace útil en redes empresariales mixtas.

Además de compartir recursos, Samba puede funcionar como un controlador de dominio, gestionando usuarios y permisos en una red, similar a un servidor Windows. Esto lo convierte en una herramienta esencial para empresas u organizaciones que buscan una solución flexible y económica para administrar redes heterogéneas, ofreciendo una alternativa eficiente para conectar diversos sistemas operativos en un entorno colaborativo.

## ¿Para qué podemos usar el servidor samba?
-**Compartición de archivos:** Samba permite que los archivos almacenados en servidores Linux/Unix sean accesibles por usuarios de Windows y viceversa. Esto facilita la colaboración en redes heterogéneas, permitiendo a los usuarios compartir, leer y escribir archivos entre diferentes sistemas sin problemas de compatibilidad.

-**Compartición de impresoras:** Los servidores Samba pueden compartir impresoras conectadas a un sistema Linux para que sean accesibles desde máquinas con Windows. Esto es especialmente útil en oficinas donde se desea centralizar el acceso a impresoras desde múltiples plataformas.

-**Controlador de dominio:** Samba puede actuar como un Controlador de Dominio (DC), similar a un servidor Windows con Active Directory. Esto permite gestionar usuarios, permisos y autenticación en una red, controlando el acceso a recursos de acuerdo con políticas establecidas.

-**Integración con Active Directory:** Samba puede integrarse con un entorno Active Directory de Windows, permitiendo a los sistemas Linux participar en dominios de Windows. De esta manera, los usuarios pueden iniciar sesión y acceder a recursos con las mismas credenciales, facilitando la administración centralizada.

-**Servidor de respaldo y almacenamiento centralizado:** Samba puede usarse como un servidor de almacenamiento de archivos o un NAS (Network Attached Storage), donde los usuarios de una red pueden almacenar y acceder a copias de seguridad, archivos compartidos o documentos importantes.

## Descripción

Este script en Bash permite instalar, configurar y administrar Samba en un sistema Linux. Proporciona tres opciones de instalación:

1. **Instalación manual** mediante comandos de `apt`.
2. **Instalación automatizada con Ansible**.
3. **Instalación en un contenedor Docker**.

Además, incluye opciones para iniciar, detener, reiniciar y eliminar el servicio Samba, así como visualizar registros y editar configuraciones.

## Características

- Interfaz de menú interactivo con colores y emojis.
- Instalación y configuración automática de Samba.
- Creación de un recurso compartido.
- Posibilidad de instalación con Ansible o Docker.
- Gestor de logs y opciones de administración del servicio.

## Requisitos

- Linux (Debian/Ubuntu).
- Privilegios de `sudo`.
- Conexión a Internet para instalar paquetes.

### Dependencias (según el método de instalación):

- **Instalación manual:** `samba`
- **Instalación con Ansible:** `ansible`
- **Instalación con Docker:** `docker`

## Uso

Ejecuta el script con:

```bash
bash menu.sh
```

### Opciones del Menú

1. **Instalar Samba**
   - Instalación manual
   - Instalación con Ansible
   - Instalación con Docker
2. **Eliminar Samba**
3. **Iniciar el servicio Samba**
4. **Detener el servicio Samba**
5. **Consultar logs de Samba**
6. **Editar configuración de Samba**
7. **Reiniciar el servicio Samba**
8. **Salir**

## Configuración

El script solicita la ruta de la carpeta compartida y la configura en `/etc/samba/smb.conf` de la siguiente manera:

```ini
[Carpeta_compartida]
comment = samba grupo cristian, pablo y mario
path = /ruta/del/recurso
browsable = yes
read only = no
```

Para acceder al recurso compartido, usa:

```bash
smbclient -L //IP_DEL_SERVIDOR
```

## Instalación con Docker

Si se elige Docker, el script:

1. Instala Docker si no está instalado.
2. Descarga una imagen de Ubuntu.
3. Configura un contenedor con Samba.
4. Comparte una carpeta dentro del contenedor.

## Instalación con Ansible

Si se elige Ansible, el script:

1. Verifica si Ansible está instalado.
2. Configura el inventario y las claves SSH.
3. Ejecuta `Instalacion_samba_ansible.yml` para configurar Samba en hosts remotos.

## Notas

- Se recomienda revisar la configuración de firewall y permisos de red para garantizar la accesibilidad del recurso compartido.
- El script crea un usuario `root` en Samba con contraseña `12345` por defecto (puede ser modificada en el código).

## Autor

Grupo: Cristian, Pablo y Mario.

---

### En honor a las 9 máquinas de Ubuntu perdidas y 3 Windows en el proceso.


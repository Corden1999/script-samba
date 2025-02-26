

## ¿Qué es Samba?

Samba es un software de código abierto que implementa el protocolo SMB/CIFS, permitiendo la interoperabilidad entre sistemas operativos Linux/Unix y Windows en una red. Funciona como un servidor que facilita la compartición de archivos, impresoras y otros recursos entre estos sistemas, permitiendo que usuarios de Windows puedan acceder a directorios y dispositivos conectados en un servidor Linux, y viceversa. Su capacidad de integración con servicios de autenticación como Active Directory también lo hace útil en redes empresariales mixtas.

Además de compartir recursos, Samba puede funcionar como un controlador de dominio, gestionando usuarios y permisos en una red, similar a un servidor Windows. Esto lo convierte en una herramienta esencial para empresas u organizaciones que buscan una solución flexible y económica para administrar redes heterogéneas, ofreciendo una alternativa eficiente para conectar diversos sistemas operativos en un entorno colaborativo.

## ¿Para qué podemos usar el servidor samba?
-**Compartición de archivos:** Samba permite que los archivos almacenados en servidores Linux/Unix sean accesibles por usuarios de Windows y viceversa. Esto facilita la colaboración en redes heterogéneas, permitiendo a los usuarios compartir, leer y escribir archivos entre diferentes sistemas sin problemas de compatibilidad.

-**Compartición de impresoras:** Los servidores Samba pueden compartir impresoras conectadas a un sistema Linux para que sean accesibles desde máquinas con Windows. Esto es especialmente útil en oficinas donde se desea centralizar el acceso a impresoras desde múltiples plataformas.

-**Controlador de dominio:** Samba puede actuar como un Controlador de Dominio (DC), similar a un servidor Windows con Active Directory. Esto permite gestionar usuarios, permisos y autenticación en una red, controlando el acceso a recursos de acuerdo con políticas establecidas.

-**Integración con Active Directory:** Samba puede integrarse con un entorno Active Directory de Windows, permitiendo a los sistemas Linux participar en dominios de Windows. De esta manera, los usuarios pueden iniciar sesión y acceder a recursos con las mismas credenciales, facilitando la administración centralizada.

-**Servidor de respaldo y almacenamiento centralizado:** Samba puede usarse como un servidor de almacenamiento de archivos o un NAS (Network Attached Storage), donde los usuarios de una red pueden almacenar y acceder a copias de seguridad, archivos compartidos o documentos importantes.

## Requisitos del Sistema

- **Sistema Operativo**: Linux/Unix (Ubuntu, Debian, CentOS, etc.)
- **Dependencias**: `samba`, `smbclient`, `winbind` (opcional para integración con Active Directory)
- **Permisos**: Acceso de superusuario (root) para la instalación y configuración.

## Instalación

1. **Instalar Samba**:
   ```bash
   sudo apt-get update
   sudo apt-get install samba smbclient
   ```

2. **Configurar Samba**:
   - Edita el archivo de configuración `/etc/samba/smb.conf` para definir los recursos compartidos.
   - A continuación, un ejemplo básico de configuración para compartir un directorio:
     ```ini
     [Compartido]
     path = /ruta/al/directorio
     browseable = yes
     writable = yes
     valid users = usuario
     ```

3. **Reiniciar el servicio Samba**:
   ```bash
   sudo systemctl restart smbd
   ```

4. **Añadir usuarios de Samba**:
   ```bash
   sudo smbpasswd -a usuario
   ```

## Uso

- **Acceder a recursos compartidos desde Windows**:
  - Abre el Explorador de Archivos y en la barra de direcciones escribe `\\ip_del_servidor`.
  - Introduce las credenciales del usuario de Samba cuando se te solicite.

- **Acceder a recursos compartidos desde Linux**:
  - Usa el comando `smbclient` para conectarte a un recurso compartido:
    ```bash
    smbclient //ip_del_servidor/Compartido -U usuario
    ```

## Contribuciones

¡Las contribuciones son bienvenidas! Si deseas mejorar este proyecto, por favor sigue estos pasos:

1. Haz un fork del repositorio.
2. Crea una rama para tu nueva característica (`git checkout -b nueva-caracteristica`).
3. Realiza tus cambios y haz commit (`git commit -am 'Añade nueva caracteristica'`).
4. Haz push a la rama (`git push origin nueva-caracteristica`).
5. Abre un Pull Request.

## Contacto

Si tienes alguna pregunta o sugerencia, no dudes en contactarme a través de [mi correo electrónico](mailto:c.alejandro57175@gmail.com).
```

¡Listo! Ahora puedes copiar y pegar este contenido directamente en tu archivo `README.md` en GitHub. 😊

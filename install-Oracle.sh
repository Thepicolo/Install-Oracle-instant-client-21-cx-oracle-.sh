#!/bin/bash

# Actualización de paquetes e instalación de alien
sudo apt-get update
sudo apt-get install -y alien

# Cambio al directorio del usuario
cd $HOME

# Descargar los archivos RPM de Oracle Instant Client
wget https://download.oracle.com/otn_software/linux/instantclient/2110000/oracle-instantclient-basic-21.10.0.0.0-1.el8.x86_64.rpm
wget https://download.oracle.com/otn_software/linux/instantclient/2110000/oracle-instantclient-sqlplus-21.10.0.0.0-1.el8.x86_64.rpm
wget https://download.oracle.com/otn_software/linux/instantclient/2110000/oracle-instantclient-devel-21.10.0.0.0-1.el8.x86_64.rpm

# Convertir RPM a DEB e instalar con dpkg
sudo alien --to-deb oracle-instantclient-basic-21.10.0.0.0-1.el8.x86_64.rpm
sudo alien --to-deb oracle-instantclient-sqlplus-21.10.0.0.0-1.el8.x86_64.rpm
sudo alien --to-deb oracle-instantclient-devel-21.10.0.0.0-1.el8.x86_64.rpm
sudo dpkg -i *.deb

# Configurar Oracle Instant Client en ldconfig
sudo sh -c "echo /usr/lib/oracle/21/client64/lib > /etc/ld.so.conf.d/oracle-instantclient.conf"
sudo ldconfig

# Configurar las variables de entorno
echo 'export LD_LIBRARY_PATH=/usr/lib/oracle/21/client64/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
echo 'export PATH=/usr/lib/oracle/21/client64/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# Crear el directorio network/admin (opcional, verifica si es necesario)
sudo mkdir -p /usr/lib/oracle/21/client64/lib/network/admin

# Instalar pip y cx-Oracle
sudo apt -y install python3-pip
pip install --user cx-Oracle

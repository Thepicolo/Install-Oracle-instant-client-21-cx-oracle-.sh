#!/bin/bash

sudo apt-get update
sudo apt-get install -y alien

sudo cd $HOME

wget https://download.oracle.com/otn_software/linux/instantclient/2110000/oracle-instantclient-basic-21.10.0.0.0-1.el8.x86_64.rpm
wget https://download.oracle.com/otn_software/linux/instantclient/2110000/oracle-instantclient-sqlplus-21.10.0.0.0-1.el8.x86_64.rpm
wget https://download.oracle.com/otn_software/linux/instantclient/2110000/oracle-instantclient-devel-21.10.0.0.0-1.el8.x86_64.rpm

sudo alien -i oracle-instantclient-basic-21.10.0.0.0-1.el8.x86_64.rpm
sudo alien -i oracle-instantclient-sqlplus-21.10.0.0.0-1.el8.x86_64.rpm
sudo alien -i oracle-instantclient-devel-21.10.0.0.0-1.el8.x86_64.rpm

sudo sh -c "echo /usr/lib/oracle/18.3/client64/lib > \
      /etc/ld.so.conf.d/oracle-instantclient.conf"
  sudo ldconfig

sudo export LD_LIBRARY_PATH=/usr/lib/oracle/21/client64/lib:$LD_LIBRARY_PATH

sudo mkdir -p /usr/lib/oracle/21/client64/lib/network/admin

sudo export PATH=/usr/lib/oracle/21/client64/bin:$PATH

sudo apt -y install python3-pip
pip install cx-Oracle

rm oracle-instantclient-*.rpm
echo "---AUTO-DESTROYING---"
rm install-oracle.sh

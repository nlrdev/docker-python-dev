#!/bin/bash
#####################################################################
## IMPORTANT ##
# Run this script with root (sudo su -), wont work if run as sudo.
# READ README.md!
######################################################################

######################################
# Config ~Change the variables as needed.
######################################
USER=webserver # User that will have ownership (chown) to /usr/local/bin and /usr/local/lib
USERHOME=/home/${USER} # The path to the users home, in this case /home/youruser
PYSHORT=3.6 # The Python short version, e.g. easy_install-${PYSHORT} = easy_install-3.6
PYTHONVER=3.6.6 # The actual version of python that you want to download from python.org

######################################
# Install all the things
######################################
cd ${USERHOME}
yum -y groupinstall "Development tools"
yum -y install zlib-devel  # gen'l reqs
yum -y install bzip2-devel openssl-devel ncurses-devel  # gen'l reqs
yum -y install mysql-devel  # req'd to use MySQL with python ('mysql-python' package)
yum -y install libxml2-devel libxslt-devel  # req'd by python package 'lxml'
yum -y install unixODBC-devel  # req'd by python package 'pyodbc'
yum -y install sqlite sqlite-devel xz-devel 
yum -y install readline-devel tk-devel gdbm-devel db4-devel 
yum -y install libpcap-devel xz-devel # you will be sad if you don't install this before compiling python, and later need it.
yum -y install libjpeg-devel
# Setup docker
yum -y remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine
yum -y install yum-utils device-mapper-persistent-data lvm2
yum-config-manager -y --add-repo  https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce
systemctl start docker

# nginx setup - Uncomment below if you want to run nginx on the host. Don't forget to configure nginx
#sudo rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
#yum -y install nginx
#systemctl start nginx

######################################
# Setup python and virtualenv
######################################
# Alias shasum to == sha1sum (will prevent some people's scripts from breaking)
echo 'alias shasum="sha1sum"' >> ${USERHOME}/.bashrc
# Install Python ${PYTHONVER} (do NOT remove 2.7, by the way)
wget --no-check-certificate https://www.python.org/ftp/python/${PYTHONVER}/Python-${PYTHONVER}.tgz
tar -zxvf Python-${PYTHONVER}.tgz 
cd ${USERHOME}/Python-${PYTHONVER}
./configure --prefix=/usr/local LDFLAGS="-Wl,-rpath /usr/local/lib" --with-ensurepip=install
make && make altinstall
cd ${USERHOME}
chown -R ${USER} /usr/local/bin
chown -R ${USER} /usr/local/lib
easy_install-${PYSHORT} virtualenv
easy_install-${PYSHORT} virtualenvwrapper
echo "export WORKON_HOME=${USERHOME}/.virtualenvs" >> ${USERHOME}/.bashrc # Change this directory if you don't like it
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3.6" >> ${USERHOME}/.bashrc
echo "export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv" >> ${USERHOME}/.bashrc
echo 'source /usr/local/bin/virtualenvwrapper.sh' >> ${USERHOME}/.bashrc # Important, don't change the order.
source ${USERHOME}/.bashrc
mkdir -p ${WORKON_HOME}
chown -R ${USER} ${WORKON_HOME}
chown -R ${USER} ${USERHOME}

######################################
# Virtualenv and pre docker setup
######################################
cd ${USERHOME}
mkvirtualenv appserver
# Run all the things inside env ...

######################################
# Fire up Docker
######################################
cd ${USERHOME}/Bin
docker-compose up -d
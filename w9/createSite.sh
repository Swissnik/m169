#! /usr/bin/bash

#########################################################
# Script Name   : createSite.sh                         #
# Description   : creates a website with ftp access     #
# Args          : name                                  #
# Author        : Yannik Noah Zechner                   #
# Email         : yannik.noah.zechner@gmail.com         #
#########################################################

name=${1} # Saves the name as a variable.
password=$(date +%s | sha256sum | base64 | head -c 12) # Generates a random 12-digit password and saves it as a variable.

echo "Checking if run by root..."
if [ "$(id -u)" != "0" ]; then
        echo "This script must be run as root." 1>&2
        exit 1
fi
echo "Check successful."

echo "Checking if site already exists..."
if id -u "${name}" >/dev/null 2>&1; then
        echo "This site already exîsts." 1>&2
        exit 1
fi
echo "Check successful."

echo "Creating website..."
echo "Creating website directory..."
mkdir /var/www/html/${name}

echo "Creating user..."
useradd ${name} -d /var/www/html/${name}

echo "Setting user password..."
echo "${name}:${password}" | chpasswd

echo "Setting user home..."
chown -R ${name}:${name} /var/www/html/${name}

echo "Activating FTP login..."
echo ${name} >> /etc/vsftpd.userlist

echo "Deactivating SSH login..."
sudo chsh ${name} -s /bin/false

echo "Restarting FTP server..."
systemctl restart vsftpd

echo "Your website was successfully created."
echo "Your password is : ${password}"

#! /bin/sh

# This is a Bash script to install all the things I need in order to start working on my PC
# Type "bash system.sh" to execute this script

Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan

system_password="insert password here"; # Your system $system_password goes here
php_version="7.2"; # PHP Version
script_dir=`pwd`; #file directory

# Find if system is Debian or Ubuntu to install somethings
CODENAME=`cat /etc/*-release | grep -w "ID"`

set -- "$CODENAME"
IFS="="; declare -a Array=($*)
distro="${Array[1]}"

if [ $distro == "debian" ]
then
  # Install commands go here
  echo $system_password | su
  apt-get install sudo -y
fi

# Update and Upgrade system
echo -e "$Cyan \n Updating system... $Color_Off"
echo $system_password | sudo -S apt-get update -y & sudo apt-get upgrade -y

#Install Apache Web Server
echo -e "$Cyan \n Installing Apache Web Server... $Color_Off"
echo $system_password | sudo -S apt-get install apache2 -y
echo $system_password | sudo mkdir /www
echo $system_password | sudo mkdir /www/html
echo $system_password | sudo touch index.html
echo "localhost" >> index.html
echo $system_password | sudo chmod 777 -R /www/html
echo $system_password | sudo -S rm -rf /etc/apache/apache2.conf
echo $system_password | sudo -S rm -rf /etc/apache/sites-available/000-default.conf
echo $system_password | sudo -S cp config_files/apache2.conf /etc/apache2
echo $system_password | sudo -S cp config_files/000-default.conf /etc/apache2/sites-available
echo $system_password | sudo a2enmod rewrite
echo $system_password | sudo systemctl restart apache2

#Install MySQL Server
echo -e "$Cyan \n Installing MySQL Server... $Color_Off"
echo $system_password | sudo -S apt-get install mysql-server -y

#Install PHP
echo -e "$Cyan \n Installing PHP... $Color_Off"
echo $system_password | sudo -S apt-get install php -y

#Install PHP Extensions
echo -e "$Cyan \n Installing PHP... $Color_Off"
echo $system_password | sudo -S apt-get install php-curl php-zip php-mbstring php-mysql -y

#Install PHPMyAdmin
echo -e "$Cyan \n Installing PHPMyAdmin... $Color_Off"
cd ~/Downloads
wget https://files.phpmyadmin.net/phpMyAdmin/4.8.2/phpMyAdmin-4.8.2-all-languages.zip
unzip phpMyAdmin-4.8.2-all-languages.zip
mkdir phpmyadmin
cd phpMyAdmin-4.8.2-all-languages
mv * ../phpmyadmin
cd ..
rm -rf phpMyAdmin-4.8.2-all-languages
echo $system_password | sudo mv phpmyadmin /www/html
echo $system_password | sudo systemctl restart apache2
cd $script_dir;

#Install PHPStorm
cd ~/Downloads
wget https://download.jetbrains.com/webide/PhpStorm-2018.1.6.tar.gz
echo $system_password | sudo -S tar -zxvf PhpStorm-2018.1.6.tar.gz /opt

#Install Atom
wget https://atom.io/download/deb
echo $system_password | sudo -S dpkg -i deb

#Install Postman
wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
echo $system_password | sudo -S tar -zxvf postman.tar.gz
echo $system_password | sudo -S mv Postman /opt
echo $system_password | sudo -S cp config_files/postman.desktop ~/.local/share/applications

#Reboot the system
echo $system_password | sudo -S reboot

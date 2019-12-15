# Update dpkg package database and upgrade packages.
apt-get update && apt-get upgrade

# Install Apache web server and activate the Mod_Rewrite
# module for URL manipulation.
apt-get install -y apache2
a2enmod rewrite

# Install PHP 7.x from the PPA (Personal Package Archive) of
# a 3rd party developer and a few PHP extensions.
apt-add-repository ppa:ondrej/php
apt-get update
apt-get install -y php7.3 php7.3-common php7.3-mysql libapache2-mod-php7.3

# Restart Apache
service apache2 restart

# Install MySQL
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
apt-get install -y mysql-server

# Download and Extract WordPress into the /var/www/html directory.
cd /var/www/html && wget -c https://wordpress.org/latest.tar.gz -O - | tar -xz && cd wordpress && mv * ../ && cd ../ && rm -rf wordpress

# Restart Apache
service apache2 restart
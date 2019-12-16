IP_ADDRESS=$1
MYSQL_DATABASE=$2
MYSQL_USERNAME=$3
MYSQL_PASSWORD=$4
WORDPRESS_USERNAME=$5
WORDPRESS_PASSWORD=$6
WORDPRESS_EMAIL=$7
WORDPRESS_TITLE=$8
URL="http://$IP_ADDRESS/"

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
debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_PASSWORD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_PASSWORD"
apt-get install -y mysql-server

# Create MySQL database for WordPress.
mysql -u$MYSQL_USERNAME -p$MYSQL_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"

# Download and install WordPress CLI.
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Change directory to root directory of web server and
# remove all files prior to installing WordPress.
service apache2 stop
cd /var/www
rm -rf html
mkdir html
service apache2 start

# Download WordPress, create wp-config, and create a user.
cd /var/www/html
wp core download --allow-root 
wp config create --allow-root --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USERNAME --dbpass=$MYSQL_PASSWORD 
wp core install --allow-root --url=$URL --title=$WORDPRESS_TITLE --admin_user=$WORDPRESS_USERNAME --admin_password=$WORDPRESS_PASSWORD --admin_email=$WORDPRESS_EMAIL

# Change Apache config file to allow .htaccess rewrites.
cp /vagrant/000-default.conf /etc/apache2/sites-available/000-default.conf

# Restart Apache
service apache2 restart
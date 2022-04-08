#!/bin/bash

openssl req -newkey rsa:4096 \
		-x509 \
		-sha256 \
		-days 365 \
		-nodes \
		-out /etc/ssl/certs/localhost.crt \
		-keyout /etc/ssl/private/localhost.key

rm -rf /etc/nginx/sites-enabled/*
cp /root/srcs/localhost.conf /etc/nginx/sites-enabled/

mkdir /var/www/localhost/

wget -O /root/srcs/phpMyAdmin-5.1.3-english.tar.gz https://files.phpmyadmin.net/phpMyAdmin/5.1.3/phpMyAdmin-5.1.3-english.tar.gz
tar -xf /root/srcs/phpMyAdmin-5.1.3-english.tar.gz -C /root/srcs/
cp -r /root/srcs/phpMyAdmin-5.1.3-english/* /var/www/localhost/
cp /root/srcs/config.inc.php /var/www/localhost/config.inc.php

chown www-data:www-data /var/www
chown www-data:www-data -R /var/www/*

find /var/www/* -type d -exec chmod 755 {} \;
find /var/www/* -type f -exec chmod 644 {} \;

/etc/init.d/mariadb start
/etc/init.d/mariadb status

echo "CREATE DATABASE test;" | mysql -u root
echo "CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';" | mysql -u root
echo "GRANT ALL PRIVILEGES ON test.* TO 'username'@'localhost';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

echo "SOURCE /var/www/localhost/sql/create_tables.sql;" | mysql -u root
echo "GRANT ALL PRIVILEGES ON phpmyadmin.* TO 'username'@'localhost';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

/etc/init.d/php7.4-fpm start
/etc/init.d/php7.4-fpm status

/etc/init.d/nginx start
/etc/init.d/nginx reload
/etc/init.d/nginx status

/bin/bash

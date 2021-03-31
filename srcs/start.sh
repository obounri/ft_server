!#/bin/bash

echo "Starting services"
service nginx start
service mysql start
service php7.3-fpm start

echo "Creating database for Wordpress"
mysql -u root <<MYSQL_SCRIPT
create database db;
create user 'admin'@'localhost' identified by 'admin';
grant all privileges on db.* to 'admin'@'localhost';
flush privileges;
MYSQL_SCRIPT

tail -f /var/log/nginx/access.log
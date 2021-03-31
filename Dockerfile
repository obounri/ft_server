FROM debian:buster

RUN apt update && apt upgrade -y


RUN apt install wget -y
RUN apt install php7.3-common php7.3-mysql php7.3-curl php7.3-json php7.3-mbstring php7.3-xml php7.3-zip php7.3-gd php7.3-soap php7.3-ssh2 php7.3-tokenizer php-pear php7.3-gettext php7.3-cgi php7.3-fpm -y
RUN apt install mariadb-client mariadb-server -y
RUN apt install nginx -y

RUN service nginx start
RUN rm /etc/nginx/sites-available/default
RUN rm /etc/nginx/sites-enabled/default
COPY srcs/default /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled
RUN chown www-data:www-data /usr/share/nginx/html/ -R

RUN wget https://wordpress.org/latest.tar.gz -P /tmp
RUN tar -xf /tmp/latest.tar.gz --strip-components=1 -C /var/www/html/
RUN rm -f  /tmp/latest.tar.gz 
COPY srcs/wp-config.php /var/www/html
RUN chown -R www-data:www-data /var/www/html/

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz -P /tmp
RUN mkdir /var/www/html/phpmyadmin
RUN tar -xf /tmp/phpMyAdmin-5.0.4-all-languages.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin
RUN rm -f  /tmp/phpMyAdmin-5.0.4-all-languages.tar.gz
COPY srcs/config.inc.php /var/www/html/phpmyadmin/
RUN chmod 660 /var/www/html/phpmyadmin/config.inc.php
RUN chown -R www-data:www-data /var/www/html/phpmyadmin

RUN mkdir /etc/nginx/ssl
RUN chmod 700 /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx-selfsigned.key -out /etc/nginx/ssl/nginx-selfsigned.crt -subj "/C=MA/LN=Kh/ON=1337/CN=host"

COPY srcs/start.sh /tmp/

CMD /tmp/start.sh

EXPOSE 80 443
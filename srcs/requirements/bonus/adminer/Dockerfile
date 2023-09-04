# Use an official Debian as a parent image
FROM debian:bullseye-slim

# Set the maintainer label
LABEL maintainer="nnakarac@42.fr"

RUN apt-get update && apt-get install -y \
    php \
    php-fpm \
    php-mysql \
    php-xml \
    php-mbstring \
    php-gd \
    php-zip \
    curl \
    mariadb-client

RUN mkdir -p /var/www/html && \
    curl -L https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php > /var/www/html/adminer.php

RUN mkdir /run/php

EXPOSE 9000

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

CMD ["/usr/sbin/php-fpm7.4", "-F"]

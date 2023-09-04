#!/bin/sh

if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded"
else

	wget https://wordpress.org/latest.tar.gz
	tar -xpvf latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	cp wp-config-sample.php wp-config.php
	sed -i "s/username_here/$WORDPRESS_DB_USER/g" wp-config.php
	sed -i "s/password_here/$WORDPRESS_DB_PASSWORD/g" wp-config.php
	sed -i "s/localhost/$WORDPRESS_DB_HOST/g" wp-config.php
	sed -i "s/database_name_here/$WORDPRESS_DB_NAME/g" wp-config.php

	wp user create $WORDPRESS_ADMIN_USER $WORDPRESS_ADMIN_EMAIL --role=administrator --user_pass=$WORDPRESS_ADMIN_PASSWORD --allow-root
	wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --role=author --user_pass=$WORDPRESS_USER_PASSWORD --allow-root


	wp config set WP_REDIS_HOST redis --allow-root
	wp config set WP_REDIS_PORT 6379 --raw --allow-root
	wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
	wp config set WP_REDIS_CLIENT phpredis --allow-root
	wp plugin install redis-cache --activate --allow-root
	wp plugin update --all --allow-root
	wp redis enable --allow-root


fi

exec "$@"

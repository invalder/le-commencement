#!/bin/sh

if [ ! -f "/var/www/html/static.html" ]; then

mv /tmp/static.html /var/www/html/static.html

fi

exec "$@"

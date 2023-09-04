# Basic Wordpress Configuration

## Test First
### Start Alpine Base
```
docker run -it -p 80:80 -p 443:443 --name wordpress alpine /bin/sh;
```

### Install required packages
```
apk update && \
apk add --update --no-cache php81 php81-fpm php81-opcache php81-gd php81-mysqli php81-zlib \
	php81-curl php81-json php81-mbstring php81-xml php81-phar php81-intl php81-zip curl tzdata\
	mariadb-client
```

### Edit lighttpd.conf (/etc/lighttpd/lighttpd.conf) and uncomment the line:
```
include "mod_fastcgi.conf"
```

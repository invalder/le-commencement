# Basic Nginx Configuration

## 1. Follow This Guideline
[Guideline](https://codingwithmanny.medium.com/configure-self-signed-ssl-for-nginx-docker-from-a-scratch-7c2bcd5478c6)

### Start Alpine Base
```
docker run -it -p 80:80 -p 443:443 --name nginx-alpine-ssl alpine /bin/sh;
```

### Install Nginx
```
apk add nginx;
```

### Run Nginx
```
nginx;
```

### Testing Running Nginx with curl
```
apk add curl;
curl localhost;

#Expect
<html>
<head><title>404 Not Found</title></head>
<body>
<center><h1>404 Not Found</h1></center>
<hr><center>nginx</center>
</body>
</html>
```

## 2. However Some configuration might not work so follow this as well
[Alpine-Wiki](https://wiki.alpinelinux.org/wiki/Nginx)

### Creating new user and group 'www' for nginx
```
adduser -D -g 'www' www;
```

### Create a directory for the html files and change the ownership to the 'www' user and group
```
mkdir /www;
chown -R www:www /var/lib/nginx;
chown -R www:www /www;
```

### Backup the default configuration file
```
mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig;
```

### Create a new configuration file
```
vi /etc/nginx/nginx.conf;
```

### Add the following to the configuration file
```
user							www;
worker_processes				auto; # it will be determinate automatically by the number of core

error_log						/var/log/nginx/error.log warn;
#pid							/var/run/nginx/nginx.pid; # it permit you to use /etc/init.d/nginx reload|restart|stop|start

events {
    worker_connections			1024;
}

http {
	include						/etc/nginx/mime.types;
	default_type				application/octet-stream;
	sendfile					on;
	access_log					/var/log/nginx/access.log;
	keepalive_timeout			3000;
	server {
		listen					80;
		root					/www;
		index					index.html index.htm;
		server_name				localhost;
		client_max_body_size	32m;
		error_page				500 502 503 504  /50x.html;
		location = /50x.html {
			root				/var/lib/nginx/html;
		}
	}
}

```

### Test the configuration file
### create the simple page
```
vi /www/index.html
```

```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>HTML5</title>
</head>
<body>
    Server is online
</body>
</html>
```

### restart nginx
```
nginx -s reload;
```

```
curl localhost;
```


## 3. Back to 1 Following the SSL Configuration

### Install Open SSL
```
apk add openssl;
```

### Create new Key and Crt files
```
openssl req -x509 -nodes -days 365 -subj "/C=CA/ST=QC/O=Company, Inc./CN=mydomain.com" -addext "subjectAltName=DNS:mydomain.com" -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt;
```

###Explanation:

**req** — to specify we want to use -x509

**-x509** — to specify we want to create a self-signed certificate instead of generating a certificate signing request.

**-nodes** — makes it so that we skip the option to secure our certificate with a passphrase, so that nginx can read it.

**-days 365** — specifies how long the certificate would be valid for, which is 365 days.

**-subj** “/C=CA/ST=QC/O=Company, Inc./CN=mydomain.com" — this allows us to specify subject without filling in prompts. /C for country, /ST for state, /O for organization, and /CN for common name.

**-addext** “subjectAltName=DNS:mydomain.com" — which adds additional attributes to our certificate which is needed to make it a valid certificate seen by both our browser and local machine.

**-newrsa rsa:2048** — specifies that we want to generate both a new certificate and a new key with an RSA key of 2048 bits.

**-keyout** /etc/.../yourfile.key — specifies the location of the output .key file.

**-out** /etc/.../yourfile.crt — specifies the location of the output .crt file.


### Then we come back to the Nginx Configuration
```
vi /etc/nginx/nginx.conf;
```

```
user							www;
worker_processes				auto; # it will be determinate automatically by the number of core

error_log						/var/log/nginx/error.log warn;
#pid							/var/run/nginx/nginx.pid; # it permit you to use /etc/init.d/nginx reload|restart|stop|start

events {
    worker_connections			1024;
}

http {
	include						/etc/nginx/mime.types;
	default_type				application/octet-stream;
	sendfile					on;
	access_log					/var/log/nginx/access.log;
	keepalive_timeout			3000;
	server {
		listen					80 default_server;
		listen					[::]:80 default_server;
		listen					443 ssl http2 default_server;
		listen					[::]:443 ssl http2 default_server;
		ssl_certificate			/etc/ssl/certs/nginx-selfsigned.crt;
		ssl_certificate_key		/etc/ssl/private/nginx-selfsigned.key;
		ssl_protocols			TLSv1.2 TLSv1.3;
		root					/www;
		index					index.html index.htm;
		server_name				localhost;
		client_max_body_size	32m;
		error_page				500 502 503 504  /50x.html;
		location = /50x.html {
			root				/var/lib/nginx/html;
		}
		# You may need this to prevent return 404 recursion.
		location = /404.html {
				internal;
		}
	}
}
```

### Test the configuration file
```
nginx -t;

# Expected Output
# nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
# nginx: configuration file /etc/nginx/nginx.conf test is successful
```

### restart nginx
```
nginx -s reload;
```

### Test the SSL
```
curl https://localhost;

# Expected Output
# curl: (60) SSL certificate problem: self signed certificate
# More details here: https://curl.haxx.se/docs/sslcerts.html
# curl failed to verify the legitimacy of the server and therefore could not establish a secure connection to it. To learn more about this situation and how to fix it, please visit the web page mentioned above.
```

### This is because the certificate is not trusted by the browser
```
curl https://localhost --insecure;
```

# 4. In order to Add self Certificate to the Trusted Certificate Follow this
## !!!do this on your local machine!!!
[AddTrustRootCA](https://support.kerioconnect.gfi.com/hc/en-us/articles/360015200119-Adding-Trusted-Root-Certificates-to-the-Server)

## Also add domin to the hosts file
```
vi /etc/hosts;
```

# 5. Dockerfile
## In the next step, we will create a ```Dockerfile``` with some configuration and an ```entrypoint.sh``` script to configure the container and run the Nginx process.

### At first, we will copy the ```nginx.conf``` file from our testing container
```
docker cp <container_id>:/etc/nginx/nginx.conf ./nginx.conf;
```

### Then we will copy the certificate and key files
```
docker cp <container_id>:/etc/ssl/certs/nginx-selfsigned.crt ./nginx-selfsigned.crt;
docker cp <container_id>:/etc/ssl/private/nginx-selfsigned.key ./nginx-selfsigned.key;
```

### Copy the index.html file
```
docker cp <container_id>:/www/index.html ./index.html;
```

### Create the Dockerfile
```
touch Dockerfile;
```

### Here is the content of the Dockerfile
```
# Base Image
FROM alpine:3.18

# RUN
RUN apk update && apk add nginx openssl

# Create www user and group
RUN adduser -D -g 'www' www

# Create the directory for html files
RUN mkdir /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www

# Copy the configuration file
COPY $PWD/conf/nginx.conf /etc/nginx/nginx.conf

# Copy the certificate and key files
COPY $PWD/conf/nginx-selfsigned.crt /etc/ssl/certs/nginx-selfsigned.crt
COPY $PWD/conf/nginx-selfsigned.key /etc/ssl/private/nginx-selfsigned.key

# Copy the index.html file
COPY ./index.html /www/index.html

WORKDIR /www

# Entrypoint
COPY $PWD/conf/entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/bin/sh", "/usr/local/bin/entrypoint.sh"]

# Expose the ports
EXPOSE 80 443

# RUN COMMAND
CMD ["/bin/sh", "-c", "nginx -g 'daemon off;'; nginx -s reload;"]
```

### Create the entrypoint.sh file
```
touch $PWD/conf/entrypoint.sh;
```

### Here is the content of the entrypoint.sh file
```
# Main shell script that is run at the time that the Docker image is run

# Go to default.conf directory
cd /etc/nginx;

# ENV VARS
# A list of environment variables that are passed to the container and their defaults
# CRT - double check that the file exists
export CRT="${CRT:=nginx-selfsigned.crt}";
if [ -f "/etc/ssl/certs/$CRT" ]
then
	# set crt file in the default.conf file
	sed -i "/ssl_certificate \//c\\\tssl_certificate \/etc\/ssl\/certs\/$CRT;" nginx.conf;
fi

# KEY - double check that the file exists
export KEY="${KEY:=nginx-selfsigned.key}";
if [ -f "/etc/ssl/private/$KEY" ]
then
	# set key file in the default.conf file
	sed -i "/ssl_certificate_key \//c\\\tssl_certificate_key \/etc\/ssl\/private\/$KEY;" nginx.conf;
fi

# Needed to make sure nginx is running after the commands are run
nginx -g 'daemon off;'; nginx -s reload;
```

# 6. Build the Dockerfile
```
docker build . -t nginx-ssl;
```

# 7. Test the container
```
docker run -it -d -p 80:80 -p 443:443 --name test nginx-ssl;
```

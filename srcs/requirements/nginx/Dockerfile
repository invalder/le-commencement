FROM debian:bullseye

# Set the maintainer label
LABEL maintainer="Inception Team <nnakarac@42.fr>"

RUN apt-get update && \
        apt-get install -y nginx openssl

RUN mkdir /etc/nginx/cert

RUN openssl req -newkey rsa:4096 -x509 -days 365 -nodes \
        -out /etc/nginx/cert/nnakarac.42.crt \
        -keyout /etc/nginx/cert/nnakarac.42.key \
        -subj "/C=TH/ST=BKK/L=BKK/O=42 Bangkok/CN=nnakarac.42.fr/"

COPY ./conf/nginx.conf /etc/nginx/conf.d

# # Expose the ports
# EXPOSE 80 443

# STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]

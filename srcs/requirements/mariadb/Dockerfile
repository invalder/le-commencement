FROM debian:bullseye

# Set the maintainer label
LABEL maintainer="Inception Team <nnakarac@42.fr>"

RUN apt-get update && apt-get -y install \
    mariadb-server \
    mariadb-client

RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

EXPOSE 3306

COPY ./tools/entrypoint.sh /usr/local/bin/
COPY ./conf/start.sql /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/start.sql

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

CMD ["mysqld", "--bind-address=0.0.0.0"]

FROM debian:bullseye
RUN apt-get update && \
        apt-get install -y redis

COPY ./tools/configure.sh /tmp/configure.sh

EXPOSE 6379

CMD ["sh", "/tmp/configure.sh"]

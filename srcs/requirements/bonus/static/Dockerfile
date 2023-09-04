FROM debian:bullseye

RUN apt update -y

COPY ./conf/configure.sh /tmp/configure.sh
COPY ./conf/static.html /tmp/static.html

ENTRYPOINT ["sh", "/tmp/configure.sh"]

CMD ["bash", "-c", "while true; do sleep 1; done"]

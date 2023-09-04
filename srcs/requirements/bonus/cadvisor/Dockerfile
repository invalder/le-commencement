FROM debian:bullseye

RUN apt-get update && apt-get install -y wget

RUN wget https://github.com/google/cadvisor/releases/download/v0.47.0/cadvisor-v0.47.0-linux-arm64


RUN chmod +x cadvisor-v0.47.0-linux-arm64

EXPOSE 8080

CMD ["./cadvisor-v0.47.0-linux-arm64", "-logtostderr"]

# Use an official Debian as a parent image
FROM debian:bullseye-slim

# Install required packages
RUN apt-get update && apt-get install -y wget tar curl

# Download Prometheus
RUN wget https://github.com/prometheus/prometheus/releases/download/v2.30.3/prometheus-2.30.3.linux-amd64.tar.gz \
    && tar xvf prometheus-2.30.3.linux-amd64.tar.gz \
    && mv prometheus-2.30.3.linux-amd64 prometheus \
    && rm prometheus-2.30.3.linux-amd64.tar.gz

# Set the working directory
WORKDIR /prometheus

RUN mv promtool /usr/local/bin/

# Copy configuration
COPY ./conf/prometheus.yml /prometheus/prometheus.yml

# Expose ports
EXPOSE 9090

# Run Prometheus
CMD ["./prometheus", "--config.file=prometheus.yml", "--web.enable-lifecycle"]

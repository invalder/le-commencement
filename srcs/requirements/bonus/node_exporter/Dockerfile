# Use Debian as base image
FROM debian:bullseye-slim

# Install wget and other dependencies
RUN apt-get update && \
    apt-get install -y wget

# Download and install Node Exporter
RUN wget https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz && \
    tar xvf node_exporter-1.2.2.linux-amd64.tar.gz && \
    mv node_exporter-1.2.2.linux-amd64 node_exporter && \
    rm node_exporter-1.2.2.linux-amd64.tar.gz

# Set the working directory
WORKDIR /node_exporter

# Expose port 9100
EXPOSE 9100

# Command to run Node Exporter
CMD ["./node_exporter"]

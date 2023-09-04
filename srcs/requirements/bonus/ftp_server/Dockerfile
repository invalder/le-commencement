# Use Debian Bullseye as the base image
FROM debian:bullseye

# Set the maintainer label
LABEL maintainer="Inception Team <nnakarac@42.fr>"

# Install vsftpd and openssl
RUN apt-get update && \
    apt-get install -y vsftpd openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy configuration files
COPY ./conf/vsftpd.conf /etc/vsftpd.conf
COPY ./tools/configure.sh /tmp/configure.sh
RUN chmod +x /tmp/configure.sh

# Expose FTP port and passive port range
EXPOSE 21 21100-21110

# Set the entry point to run the configure script
ENTRYPOINT ["sh", "/tmp/configure.sh"]

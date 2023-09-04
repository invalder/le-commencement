#!/bin/sh

if [ ! -f "/etc/vsftpd.conf.bak" ]; then

# Generate self-signed certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com"


mkdir -p /var/www/html
mkdir -p /var/run/vsftpd/empty

cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
# mv /tmp/vsftpd.conf /etc/vsftpd.conf

# Add user non-interactively
adduser --disabled-password --gecos "" $FTP_USR
# echo "$FTP_USR:$FTP_PWD" | chpasswd

echo "$FTP_USR:$FTP_PWD" | /usr/sbin/chpasswd &> /dev/null
chown -R $FTP_USR:$FTP_USR /var/www/html

echo $FTP_USR >> /etc/vsftpd.userlist

fi

echo "FTP started on :21"
/usr/sbin/vsftpd /etc/vsftpd.conf

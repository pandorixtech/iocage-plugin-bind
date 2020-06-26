#!/bin/sh

# Enable the service
sysrc -f /etc/rc.conf named_enable="YES"

# Configuration
touch /usr/local/etc/namedb/zones.register
echo "include \"/usr/local/etc/namedb/zones.register\";" >> /usr/local/etc/namedb/named.conf
sed -i .orig "s/^	listen-on	{ 127.0.0.1; };//" /usr/local/etc/namedb/named.conf
# Start the service
service named start 2>/dev/null

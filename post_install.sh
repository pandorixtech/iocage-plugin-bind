#!/bin/sh

# Enable the service
sysrc -f /etc/rc.conf named_enable="YES"

# Configuration

echo "include \"/usr/local/etc/namedb/zones.register\";" >> /usr/local/etc/namedb/named.conf
sed -i .orig "s/^	listen-on	{ 127.0.0.1; };//" /usr/local/etc/namedb/named.conf

chown bind:bind /usr/local/etc/namedb/zones.register
chown bind:bind /usr/local/etc/namedb/dynamic/example.local.db


# Start the service
service named start 2 > /dev/null

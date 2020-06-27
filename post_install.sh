#!/bin/sh

# Enable the service
sysrc -f /etc/rc.conf named_enable="YES"

# Configuration
touch /usr/local/etc/namedb/zones.register

echo "include \"/usr/local/etc/namedb/zones.register\";" >> /usr/local/etc/namedb/named.conf
sed -i .orig "s/^	listen-on	{ 127.0.0.1; };//" /usr/local/etc/namedb/named.conf

echo "// ZONES list" >> /usr/local/etc/namedb/zones.register
echo "// **********" >> /usr/local/etc/namedb/zones.register
echo "// " >> /usr/local/etc/namedb/zones.register
echo "// sample:" >> /usr/local/etc/namedb/zones.register
echo "// zone \"example.local\" \t{ type master; file \"/usr/local/etc/namedb/dynamic/example.local.db\"; };" >> /usr/local/etc/namedb/zones.register

touch /usr/local/etc/namedb/dynamic/example.local.db
echo "\$TTL 3H" >>  /usr/local/etc/namedb/dynamic/example.local.db
echo "@ SOA @ nobody.localhost. 42 	1d 	 12h 	1w 	3h" >>  /usr/local/etc/namedb/dynamic/example.local.db
echo ";                         Serial, Refresh, Retry, Expire, Neg. cache TTL" >>  /usr/local/etc/namedb/dynamic/example.local.db
echo " " >>  /usr/local/etc/namedb/dynamic/example.local.db
echo "@	NS 	@" >>  /usr/local/etc/namedb/dynamic/example.local.db
echo "@	A 	127.0.0.1" >>  /usr/local/etc/namedb/dynamic/example.local.db
chown bind:bind /usr/local/etc/namedb/zones.register
chown bind:bind /usr/local/etc/namedb/dynamic.local.db
# Start the service
service named start 2 > /dev/null

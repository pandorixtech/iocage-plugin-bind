#!/bin/sh

# Enable the service
sysrc -f /etc/rc.conf named_enable="YES"

# Start the service
service named start 2>/dev/null

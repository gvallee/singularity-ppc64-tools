#!/bin/sh
#

#
# Copyright(c)		2019	UT-Battelle, LLC
#				All rights reserved
#

# Note: this script needs root privileges

echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
iptables -I FORWARD 1 -i tap0 -j ACCEPT
iptables -I FORWARD 1 -o tap0 -m state --state RELATED,ESTABLISHED -j ACCEPT

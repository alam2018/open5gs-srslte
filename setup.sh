#!/bin/sh
iptables -t nat -A POSTROUTING -o tun+ -j MASQUERADE

ip tuntap add name ogstun mode tun
ip addr del 10.45.0.1/16 dev ogstun 2> /dev/null
ip addr add 10.45.0.1/16 dev ogstun
ip addr del 2001:230:cafe::1/48 dev ogstun 2> /dev/null
ip addr add 2001:230:cafe::1/48 dev ogstun
ip link set ogstun up

iptables -t nat -A POSTROUTING -s 10.45.0.0/16 ! -o ogstun -j MASQUERADE
ip6tables -t nat -A POSTROUTING -s 2001:230:cafe::/48 ! -o ogstun -j MASQUERADE

#sudo systemctl restart open5gs-mmed
#sudo systemctl restart open5gs-sgwud

#child=$!
#wait "$child"
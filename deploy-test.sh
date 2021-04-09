#!/bin/sh
/docker-entrypoint/setup.sh

#cp mme.yml /etc/open5gs/
echo "Starting MongoDB......."
mongod --config /etc/mongodb.conf &
sleep 5s

echo "Starting PCRF......."
/bin/open5gs-pcrfd /etc/open5gs/pcrf.yaml &
sleep 5s

echo "Starting MME......."
/bin/open5gs-mmed /etc/open5gs/mme.yaml &
sleep 5s

echo "Starting SPGWU......."
/bin/open5gs-sgwud /etc/open5gs/sgwu.yaml &
sleep 5s

echo "Starting SPGWC......."
/bin/open5gs-sgwcd /etc/open5gs/sgwc.yaml &
sleep 5s

echo "Starting HSS......."
/bin/open5gs-hssd /etc/open5gs/hss.yaml &
sleep 5s

#echo "Starting PCF......."
#/usr/bin/open5gs-pcfd /etc/open5gs/pcf.yaml &
#sleep 5s




echo "All core VNFs started..."
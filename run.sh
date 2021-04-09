#!/bin/sh
./docker-entrypoint/setup.sh

#cp mme.yml /etc/open5gs/
echo "Starting MongoDB......."
/usr/bin/mongod --config /etc/mongodb.conf &
sleep 5s

echo "Starting MME......."
/usr/bin/open5gs-mmed /etc/open5gs/mme.yaml &
sleep 5s

echo "Starting SPGWC......."
/usr/bin/open5gs-sgwcd /etc/open5gs/sgwc.yaml &
sleep 5s

echo "Starting SPGWU......."
/usr/bin/open5gs-sgwud /etc/open5gs/sgwu.yaml &
sleep 5s

#echo "Starting HSS......."
#/usr/bin/open5gs-hssd /etc/open5gs/hss.yaml &
#sleep 5s

#echo "Starting PCF......."
#./usr/bin/open5gs-pcfd /etc/open5gs/pcf.yaml &
#sleep 5s

echo "Starting PCRF......."
/usr/bin/open5gs-pcrfd /etc/open5gs/pcrf.yaml &
sleep 5s


echo "All core VNFs started..."
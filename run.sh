#!/bin/sh
./docker-entrypoint/setup.sh

#cp mme.yml /etc/open5gs/

/usr/bin/mongod --config /etc/mongodb.conf &
sleep 5
/usr/bin/open5gs-mmed /etc/open5gs/mme.yaml &
#sleep 5
#/usr/bin/open5gs-sgwcd /etc/open5gs/sgwc.yaml &
#sleep 5
#/usr/bin/open5gs-sgwud /etc/open5gs/sgwu.yaml &
#sleep 5
#/usr/bin/open5gs-hssd /etc/open5gs/hss.yaml &
#sleep 5
#./usr/bin/open5gs-pcfd /etc/open5gs/pcf.yaml &
#sleep 5
#/usr/bin/open5gs-pcrfd /etc/open5gs/pcrf.yaml &
#sleep 5


echo "All core VNFs started..."
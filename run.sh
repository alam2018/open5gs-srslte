#!/bin/sh
./docker-entrypoint/setup.sh

#cp mme.yml /etc/open5gs/

./usr/bin/open5gs-mmed /etc/open5gs/mme.yaml &
wait
./usr/local/bin/open5gs-sgwud /etc/open5gs/sgwu.yaml &
wait
./usr/local/bin/open5gs-sgwcd /etc/open5gs/sgwc.yaml &
wait
./usr/local/bin/open5gs-pcfd /etc/open5gs/pcf.yaml &
wait
./usr/local/bin/open5gs-pcrfd /etc/open5gs/pcrf.yaml &
wait
./usr/local/bin/open5gs-hssd /etc/open5gs/hss.yaml &
wait



/usr/local/bin/open5gs-pgwd -D

echo "All core VNFs started..."
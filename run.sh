#!/bin/sh

_term() {
  echo "Caught SIGTERM signal!"
  kill -TERM "$child"
}
trap _term SIGTERM
env


/docker-entrypoint/setup.sh

ip4=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)

echo "Open5gs local interface ip: $ip4"

sed -i 's/LOCAL_INTERFACE_IP/'$ip4'/g' /etc/open5gs/mme.yaml
sed -i 's/LOCAL_INTERFACE_IP/'$ip4'/g' /etc/open5gs/sgwu.yaml

#cp mme.yml /etc/open5gs/
echo "Starting MongoDB......."
/usr/bin/mongod --config /etc/mongodb.conf &
npm run dev &
sleep 5s

echo "Starting PCRF......."
/usr/bin/open5gs-pcrfd /etc/open5gs/pcrf.yaml &
sleep 5s

echo "Starting MME......."
/usr/bin/open5gs-mmed /etc/open5gs/mme.yaml &
sleep 5s

echo "Starting SPGWU......."
/usr/bin/open5gs-sgwud /etc/open5gs/sgwu.yaml &
sleep 5s

echo "Starting SPGWC......."
/usr/bin/open5gs-sgwcd /etc/open5gs/sgwc.yaml &
sleep 5s

echo "Starting HSS......."
/usr/bin/open5gs-hssd /etc/open5gs/hss.yaml &
sleep 5s

#echo "Starting PCF......."
#/usr/bin/open5gs-pcfd /etc/open5gs/pcf.yaml &
#sleep 5s

echo "All core VNFs started..."


child=$!
wait "$child"
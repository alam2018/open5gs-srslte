#!/bin/sh
./setup.sh

cp mme.yml /etc/open5gs/

/usr/bin/open5gs-mmed /etc/open5gs/mme.yml
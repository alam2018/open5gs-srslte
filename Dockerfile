FROM ubuntu:18.04

MAINTAINER Md Ashraful Alam <anjonbd2007@gmail.com>

ENV DEBIAN_FRONTEND noninteractive


# Dependencies 
RUN apt-get update && apt-get -yq install cmake git libfftw3-dev libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev libuhd-dev iproute2 libzmq3-dev libtool autoconf iptables net-tools

RUN apt-get update && \
   apt-get -yq dist-upgrade && \
   apt-get --no-install-recommends -qqy install python3-pip python3-setuptools python3-wheel ninja-build build-essential flex bison git libsctp-dev libgnutls28-dev libgcrypt-dev libssl-dev \
   libidn11-dev libmongoc-dev libbson-dev libyaml-dev libmicrohttpd-dev libcurl4-gnutls-dev meson iproute2 libnghttp2-dev \
   iptables iputils-ping tcpdump cmake curl gnupg meson software-properties-common systemd openssh-server nano 

#Install Open5gs 
RUN add-apt-repository ppa:open5gs/latest
RUN apt update
RUN apt -y install open5gs


#RUN git clone --recursive https://github.com/open5gs/open5gs && \
#   cd open5gs && meson build --prefix=/ && ninja -C build && cd build && ninja install 
   
RUN apt -y install mongodb

RUN mkdir -p /data/db
VOLUME ["/data/db"]
RUN chown -R mongodb:mongodb /data/db
#EXPOSE 27017
#EXPOSE 3000


ADD /conf/mme.yaml /etc/open5gs/
ADD /conf/sgwu.yaml /etc/open5gs/


ADD setup.sh /docker-entrypoint/
RUN chmod +x /docker-entrypoint/setup.sh
#CMD ["./setup.sh"]


# Install anything. The service you want to start must be a SystemD service.
#VOLUME [ “/sys/fs/cgroup” ]
#CMD [“/usr/sbin/init”]
#ADD cmd.sh /usr/local/bin/
#RUN chmod +x /usr/local/bin/cmd.sh

# Run the launcher script
ADD run.sh /docker-entrypoint/
RUN chmod +x /docker-entrypoint/run.sh

ADD deploy-test.sh /docker-entrypoint/
RUN chmod +x /docker-entrypoint/deploy-test.sh

ENTRYPOINT ["/bin/bash", "/docker-entrypoint/run.sh"]
#ENTRYPOINT ["/bin/bash", "/docker-entrypoint/run.sh"]


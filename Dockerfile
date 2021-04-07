FROM ubuntu:18.04

MAINTAINER Md Ashraful Alam <anjonbd2007@gmail.com>

ENV DEBIAN_FRONTEND noninteractive


# Dependencies for the UHD driver for the USRP hardware
RUN apt-get update && apt-get -yq install cmake git libfftw3-dev libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev libuhd-dev iproute2 libzmq3-dev libtool autoconf iptables net-tools
#RUN apt-get update && apt-get -yq install git

RUN apt-get update && \
#   apt-get -yq dist-upgrade && \
   apt-get --no-install-recommends -qqy install python3-pip python3-setuptools python3-wheel ninja-build build-essential flex bison git libsctp-dev libgnutls28-dev libgcrypt-dev libssl-dev \
   libidn11-dev libmongoc-dev libbson-dev libyaml-dev libmicrohttpd-dev libcurl4-gnutls-dev meson iproute2 libnghttp2-dev \
   iptables iputils-ping tcpdump cmake curl gnupg meson software-properties-common systemd


#RUN apt -y install snapd
#RUN apt-get update 
#RUN systemctl status snapd.service
#RUN snap install systemd-manager --beta


 
RUN add-apt-repository ppa:open5gs/latest
RUN apt update
RUN apt -y install open5gs

ADD /conf/mme.yaml /etc/open5gs/


ADD setup.sh /docker-entrypoint/
RUN chmod +x /docker-entrypoint/setup.sh
#CMD ["./setup.sh"]


#ENV container docker
#RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
#systemd-tmpfiles-setup.service ] || rm -f $i; done); \
#rm -f /lib/systemd/system/multi-user.target.wants/*;\
#rm -f /etc/systemd/system/*.wants/*;\
#rm -f /lib/systemd/system/local-fs.target.wants/*; \
#rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
#rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
#rm -f /lib/systemd/system/basic.target.wants/*;\
#rm -f /lib/systemd/system/anaconda.target.wants/*;

# Install anything. The service you want to start must be a SystemD service.
#VOLUME [ “/sys/fs/cgroup” ]
#CMD [“/usr/sbin/init”]
#ADD cmd.sh /usr/local/bin/
#RUN chmod +x /usr/local/bin/cmd.sh

# Run the launcher script
ADD run.sh /docker-entrypoint/
RUN chmod +x /docker-entrypoint/run.sh
ENTRYPOINT ["/bin/bash", "/docker-entrypoint/run.sh"]
#CMD ["./run.sh"]


#CMD ["/usr/local/bin/cmd.sh"]
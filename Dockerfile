FROM \
    debian:wheezy-20190228-slim

RUN  mkdir -p /usr/share/man/man1
RUN  echo "deb http://archive.debian.org/debian wheezy main contrib non-free" >> /etc/apt/sources.list
RUN  echo "deb http://http.debian.net/debian wheezy-backports main"           >> /etc/apt/sources.list
RUN  apt-get update --allow-unauthenticated
RUN  update-alternatives --force --all --skip-auto
RUN  apt-get -yu dist-upgrade --allow-unauthenticated
RUN  apt-get -y --force-yes install tzdata=2016d-0+deb7u1
RUN  DEBIAN_FRONTEND=noninteractive apt-get --allow-unauthenticated -y install jq
RUN  DEBIAN_FRONTEND=noninteractive apt-get --allow-unauthenticated -y install x11vnc
RUN  DEBIAN_FRONTEND=noninteractive apt-get --allow-unauthenticated -y install xvfb
RUN  DEBIAN_FRONTEND=noninteractive apt-get --allow-unauthenticated -y install jwm
RUN  DEBIAN_FRONTEND=noninteractive apt-get --allow-unauthenticated -y install iceweasel
RUN  DEBIAN_FRONTEND=noninteractive apt-get --allow-unauthenticated -y install openjdk-6-jre
RUN  DEBIAN_FRONTEND=noninteractive apt-get --allow-unauthenticated -y install tzdata-java
RUN  DEBIAN_FRONTEND=noninteractive apt-get --allow-unauthenticated -y install icedtea-6-plugin
RUN  DEBIAN_FRONTEND=noninteractive apt-get --allow-unauthenticated -y install icedtea-netx
RUN  DEBIAN_FRONTEND=noninteractive apt-get --allow-unauthenticated -y install novnc

RUN  apt-get -y autoremove
RUN  apt-get clean
RUN  rm -rf /var/lib/{apt,dpkg,cache,log}

COPY bashio/lib /usr/lib/bashio
RUN ln -sf /usr/lib/bashio/bashio /usr/bin/bashio

COPY run.sh /
RUN chmod 755 /run.sh
RUN adduser --disabled-password --gecos "" vnc

CMD [ "/run.sh" ]


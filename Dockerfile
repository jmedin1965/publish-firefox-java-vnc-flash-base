FROM \
    debian:wheezy-20190228-slim

RUN \
    mkdir -p /usr/share/man/man1 \
    && echo "deb http://archive.debian.org/debian wheezy main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian wheezy-backports main"       >> /etc/apt/sources.list \
    && apt-get update --allow-unauthenticated \
    && update-alternatives --force --all --skip-auto \
    && apt-get -yu dist-upgrade --allow-unauthenticated \
    && apt-get -y --force-yes install tzdata=2016d-0+deb7u1
RUN \
    DEBIAN_FRONTEND=noninteractive apt-get --allow-unauthenticated -y install git
RUN \
    DEBIAN_FRONTEND=noninteractive apt-get --allow-unauthenticated -y install \
      git jq x11vnc xvfb jwm iceweasel openjdk-6-jre tzdata-java icedtea-6-plugin icedtea-netx novnc curl \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

COPY run.sh /
RUN chmod 755 /run.sh
RUN adduser --disabled-password --gecos "" vnc

CMD [ "/run.sh" ]


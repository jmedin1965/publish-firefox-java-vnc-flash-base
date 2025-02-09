FROM \
    debian:wheezy-20190228-slim

RUN \
    mkdir -p /usr/share/man/man1 \
    && echo "deb http://archive.debian.org/debian wheezy main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian wheezy-backports main"       >> /etc/apt/sources.list \
    && apt-get update --allow-unauthenticated \
    && apt-get -yu dist-upgrade --allow-unauthenticated \
    && apt-get -y --force-yes install tzdata=2016d-0+deb7u1 \
    && DEBIAN_FRONTEND=noninteractive apt-get --allow-unauthenticated -y install \
      jq x11vnc xvfb jwm iceweasel openjdk-6-jre tzdata-java icedtea-6-plugin icedtea-netx curl x11-apps sudo vim sqlite3 \
    && update-alternatives --set javaws /usr/lib/jvm/java-6-openjdk-amd64/jre/bin/javaws \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/{apt,dpkg,cache,log} /tmp/*

COPY files/. /
COPY run.sh /
RUN \
    chmod 755 /run.sh \
    && cp -a /etc/skel/. /root
RUN adduser --disabled-password --gecos "" vnc

CMD [ "/run.sh" ]


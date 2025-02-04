#!/bin/bash

release="0.16.2"

if [ ! -e "v${release}.tar.gz" ]
then
	wget https://github.com/hassio-addons/bashio/archive/refs/tags/v${release}.tar.gz && \
	echo "info: got bashio version bashio-${release}"
fi

if [ ! -e "bashio-${release}" ]
then
	tar -zxf "v${release}.tar.gz" && \
	echo "info: got extracted v${release}.tar.gz to bashio-${release}"
fi

ln -sf "bashio-${release}" bashio &&

if [ ! -d "bashio" ]
then
	echo "error: failed to get bashio"
fi

#!/bin/bash

read_conf()
{
	local data

	if [ -n "$1" ]
	then
		data="$(set -- $(grep "\"$1\":" /data/options.json); echo $2)"		
		data="${data%%,}"
		echo "$data"
	fi
}

echo "Hello x11vnc! pw = $(read_conf vnc_password) changed"


(
	while :
	do
		echo "loop: start x11vnc"
		/usr/bin/sudo -i -u vnc \
			/usr/bin/x11vnc \
			-forever \
			-create \
			-passwd "$(read_conf vnc_password)"
		sleep 5
	done
)&

(
	while :
	do
		echo "loop: start "
		/usr/bin/sudo -u nova \
			/usr/bin/nova-novncproxy \
			--nodaemon \
			--logfile=/dev/stdout \
			--novncproxy_host=local-firefox-java-vnc-flash \
			--novncproxy_port=8099 \
			--vnc-novncproxy_port 8099 \
			--flagfile=/etc/nova/nova.conf \
			--web /usr/share/novnc/
		sleep 5
	done
)

#exec /usr/bin/x11vnc -forever -create -passwd "j2000"

#exec /usr/bin/x11vnc -forever -create -passwd "$VNC_PW"

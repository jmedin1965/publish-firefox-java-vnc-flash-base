#!/bin/bash

#
# read_conf - this works with Home Assistant
#
# Usage: reaf_conf key [default]
#
# will return the value stored in key. If no value found
# it will return default
#
CONFIG_PATH="/data/options.json"
read_conf()
{
	local data

	if [ -n "$1" -a -e "$CONFIG_PATH" ]
	then
		data="$(jq --raw-output ".$1" < "$CONFIG_PATH")"
	fi
	[ -z "$date" ] && data="$2"
	echo -n "$data"
}

vnc_user="$(read_conf vnc_user vnc)"
vnc_password="$(read_conf vnc_password vnc)"
vnc_allow_hosts_list="$(read_conf vnc_allow_hosts_list)"
vnc_scale="$(read_conf vnc_scale)"
vnc_extra_opts=()

# option vnc_allow_hosts_list, used to limit what vnc is listening on.
[ -n "$vnc_allow_hosts_list" ] && vnc_extra_opts=("${vnc_extra_opts[@]}" "-allow" "$vnc_allow_hosts_list")

# option -scale, used to scale the screen
[ -n "$vnc_scale" ] && vnc_extra_opts=("${vnc_extra_opts[@]}" "-scale" "$vnc_scale")

echo "x11vnc is starting, vnc_user = $vnc_user"

# check and create list of users and paswords
if [ -n "$vnc_user" -a -n "$vnc_password" ]
then
	users=()
	pwds=()
	IFS="," read -a users <<< "$vnc_user"
	if [ "${#users[@]}" -gt 0 ]
	then
		IFS="," read -a pwds <<< "$vnc_password"
	else
		users[0]="$vnc_user"	
		pwds[0]="$vnc_password"
	fi
	i="0"
	last=""
	for user in "${users[@]}"
	do
		if [ -z "${pwds[$i]}" ]
		then
			pwds[$i]="$last"
		else
			last="${pwds[$i]}"
		fi
		echo "setting up user $user, ${pwds[$i]}"
		/usr/bin/getent passwd $user || /usr/sbin/adduser --disabled-password --gecos "" $user
		echo "$user:${pwds[$i]}" | /usr/sbin/chpasswd
		((i++))
	done
fi


# -allow host1[,host2...]
# Only allow client connections from hosts matching list of names or IP
#
# -localhost
# Basically the same as -allow 127.0.0.1
#
# -unixpw_cmd cmd
# cmd is executed, first line of stdin is username, second line is password
# if exits 0, allow login
(
	while :
	do
		echo "loop: x11vnc is starting, vnc_user = $vnc_user"

#		/usr/bin/sudo -i -u $vnc_user \
echo command line:	/usr/bin/x11vnc \
			"${vnc_extra_opts[@]}" \
			-ncache -ncache_cr \
			-xrandr resize \
			-shared \
			-forever \
			-create \
			-users "$vnc_user" \
			-unixpw "root:deny,$vnc_user"

#		/usr/bin/sudo -i -u $vnc_user \
			/usr/bin/x11vnc \
			"${vnc_extra_opts[@]}" \
			-ncache -ncache_cr \
			-xrandr resize \
			-shared \
			-forever \
			-create \
			-users "$vnc_user" \
			-unixpw "root:deny,$vnc_user"

#			-passwd "$(read_conf vnc_password)"
		sleep 5
	done
)


#exec /usr/bin/x11vnc -forever -create -passwd "vnc"
#exec /usr/bin/x11vnc -forever -create -passwd "$VNC_PW"

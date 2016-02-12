#!/bin/bash

range(){
	export s=""
	export e=""
	export parm=""

	for x in $*; do
		if [ "$parm" == "-s" ]; then
			export s="$x"
		elif [ "$parm" == "-e" ]; then
			export e="$x"
		fi
		export parm="$x"
	done

	while [ $s -le $e ]; do
		echo -n "$s "
		let s=$s+1
	done
}

reconnect(){
	loop=1
	while [ "$loop" == 1 ]; do
		loop=0
		pos=0
		essids=$(iwlist scanning | grep ESSID)
		for x in $essids; do
			let len="$(python /usr/share/wifi-lan/strlen $x)-1"
			ESSID[$pos]=$(echo $x | cut -c8-$len)
			let pos=$pos+1
		done

		let pos=$pos-1
		LINKS=$(ls etc/wifi_lan/)
		for x in $LINKS; do
			for y in $(range -s 0 -e $pos); do
				if [ "$x" == "${ESSID[$pos]}" ]; then
					ifconfig wlan0 up &&
						wpa_supplicant -i wlan0 -c ~/.wifi_lan/$x -BD wext &&
						return 0
					ifconfig wlp3s0 up &&
						wpa_supplicant -i wlp3s0 -c ~/.wifi_lan/$x -BD wext &&
						return 0
					echo "Wifi-Device not found." &&
					return 1

					loop=1
				fi
			done
		done
	done
}

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

	while [ $s -lt $e ]; do
		echo -n "$s "
		let s=$s+1
	done
}

reconnect(){
	while [ "loop" ]; do
		on=$(ps aux | grep wpa_su | wc -l)
		[[ "$on" -gt "1" ]] &&
			killall -s TERM wpa_supplicant -w &&
			[[ "$(ifconfig | grep $dev)" ]] &&
				ifconfig $dev up
		pos=0
		essids=$(iwlist $1 scanning | grep ESSID)
		for x in $(echo $essids | tr '"' '\n' | grep -v ':'); do
			ESSID[$pos]=$x
			let pos=$pos+1
		done

		let pos=$pos-1
		LINKS=$(ls /etc/wifi_lan/)
		for x in $LINKS; do
			for y in $(range -s 0 -e $pos); do
				if [ "$x" == "${ESSID[$y]}" ]; then
					ifconfig wlp3s0 up &&
						wpa_supplicant -i $1 -c /etc/wifi_lan/$x -BD wext &&
						return 0
					echo "Wifi-Device not found." &&
					return 1
				fi
			done
		done
		sleep 2
	done
}

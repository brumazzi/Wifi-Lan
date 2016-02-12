#!/bin/bash

[[ "$(pwd)" == "/" ]] && exit 1

cp share /usr/ -r
cp bin /usr/ -r

mkdir -p /etc/wifi_lan/

exit 0

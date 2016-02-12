#Wifi-Lan

##Description
Automatic wifi manager without GUI.

##Install
```
$ git clone git@github.com/Brumazzi/Wifi-Lan.git Wifi-Lan
$ cd Wifi-Lan

$ sudo sh install.sh
```

##Usage
On script header, put `. /usr/share/wifi-lan/wifi-lan`.
And call run.
Ex:
```
!#/bin/bash

. /usr/share/wifi-lan/wifi-lan

run &
```
Use `wifi-add` to insert or alter a new wifi host.
```
$ wifi-add <ESSID> <PASSWORD>
```

#!/bin/sh

mknod /dev/stpwmt c 190 0
mknod /dev/stpgps c 191 0
mknod /dev/stpbt  c 192 0
mknod /dev/wmtWifi c 153 0
mknod /dev/hwmsensor c 10 39
chmod 0777 /dev/hwmsensor
chmod 0666 /dev/stpwmt
chown system:system /dev/stpwmt 
chmod 0666 /dev/wmtWifi
chown system:system /dev/wmtWifi
mv /lib/systemd/systemd-udevd /lib/systemd/systemd-udevd1
systemctl stop systemd-udevd
while [ ! -f /sys/devices/platform/mt-wifi/net/wlan0/mtu ]
do
   echo 1 > /dev/wmtWifi
   sleep 3
done
mv /lib/systemd/systemd-udevd1 /lib/systemd/systemd-udevd
systemctl start systemd-udevd

echo -c "LOADED"

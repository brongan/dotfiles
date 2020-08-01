#!/bin/sh

set -eux

XORG_SERVICE="xorg-server@0.service"
VM_NAME="win10"

if [ -z $1 ]; then
    "Please enter the name of the user as argument"
fi

sudo -u $1 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/`id -u $1`/bus systemctl --user stop ${XORG_SERVICE}

while [ "$(sudo -u $1 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/`id -u $1`/bus systemctl --user is-active ${XORG_SERVICE})" = 'active' ]; do
    sleep 0.5
done

virsh start ${VM_NAME}


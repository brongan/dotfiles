#!/usr/bin/env bash

BAR_ICON=" "
NOTIFY_ICON=/usr/share/icons/Papirus/32x32/apps/system-software-update.svg

while true; do
    UPDATES=$(checkupdates 2>/dev/null | wc -l)

    if (( UPDATES == 1 )); then
        echo "$BAR_ICON $UPDATES Update"
        sleep 300
    elif (( UPDATES > 1 )); then
        echo "$BAR_ICON $UPDATES Updates"
        sleep 300
    else
        echo $BAR_ICON
        sleep 1800
    fi
done


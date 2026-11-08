#!/bin/bash

set -eu

BAT=BAT1
DIR="/sys/class/power_supply/${BAT}"

if [ ! -d ${DIR} ]; then
	echo "🔌"
	exit 0
fi

battery_percentage=$(<"${DIR}/capacity")
battery_status=$(<"${DIR}/status")
battery_icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")
charging_icon="󰂄"
icon_index=$((battery_percentage / 10))
if [ "$battery_percentage" -eq 100 ]; then
	icon_index=9
fi
battery_icon=${battery_icons[$icon_index]}
if [ "$battery_status" = "Charging" ]; then
	battery_icon="$charging_icon"
fi
echo "$battery_percentage% $battery_icon"

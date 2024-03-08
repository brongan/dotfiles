#!/usr/bin/env zsh

set -eu

local args=($(echo $@ | tr ',' ' '))
local backlight=${args[1]}
local brightness=${args[4]::-1}

if [ $brightness -le 25 ]; then
	icon=display-brightness-off-symbolic
elif [ $brightness -le 50 ]; then
	icon=display-brightness-low-symbolic
elif [ $brightness -le 75 ]; then
	icon=display-brightness-medium-symbolic
else
	icon=display-brightness-high-symbolic
fi

canberra-gtk-play -i dialog-information -d "notifyBrightness"
dunstify -h string:x-canonical-private-synchronous:brightness "${backlight}: ${brightness}%" -h int:value:"$brightness" -t 1500 --icon $icon


#!/usr/bin/env zsh

set -eu

local volume=$(pamixer --get-volume)
local mute=$(pamixer --get-mute)
local sink=$(pamixer --get-default-sink | tail -n 1 | awk -F\" '{print $4}')

if [[ $volume -eq 0 || "$mute" == "true" ]]; then
	msg="Muted:  "
	icon=audio-volume-muted
elif [[ $volume -le 30 ]]; then
	msg="Volume:  "
	icon=audio-volume-low
elif [[ $volume -le 70 ]]; then
	msg="Volume:  "
	icon=audio-volume-medium
else
	msg="Volume:  "
	icon=audio-volume-high
fi

canberra-gtk-play -i audio-volume-change -d "notifyVolume"
dunstify -h string:x-canonical-private-synchronous:audio $sink "${msg} ${volume}%" -h int:value:"$volume" -t 1500 --icon $icon

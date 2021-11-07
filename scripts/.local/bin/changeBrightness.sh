#!/usr/bin/env zsh
# changeBrightness

# A R B I T R A R y
MSG_ID="9694209"

MAX_TICKS=20
NUM_TICKS=$(( 100/${MAX_TICKS} ))

function get_brightness {
  xbacklight -get | cut -d '.' -f 1
}

function send_notification {
	local brightness=$(get_brightness)
	dunstify -a "changeBrightness" -u low -i display-brightness -r $MSG_ID \
		"Brightness: ${brightness}%" -h int:value:$brightness
}

case $1 in
    up)
	xbacklight -inc ${NUM_TICKS}
	;;
    down)
	if [[ $(get_brightness) -le ${NUM_TICKS} ]]; then
		xbacklight -set 1
	else
		xbacklight -dec ${NUM_TICKS}
	fi
	;;
esac

send_notification


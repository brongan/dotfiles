#!/usr/bin/env zsh
# changeBrightness

# A R B I T R A R y
MSG_ID="9694209"

BRIGHTNESS_PCT_CHANGE=5
MAX_TICKS=20
NUM_TICKS=$(( 100/${MAX_TICKS} ))

function get_brightness {
  xbacklight -get | cut -d '.' -f 1
}

function get_progress_string {
	local brightness=$1
	local range=$((  ${brightness}/${NUM_TICKS} ))
	printf '▀%.0s' {1..$range}
}

function send_notification {
	local brightness=$(get_brightness)
	dunstify -a "changeBrightness" -u low -i display-brightness -r $MSG_ID \
		"Brightness: ${brightness}%" "$(get_progress_string ${brightness})"
}

case $1 in
    up)
	xbacklight -inc ${BRIGHTNESS_PCT_CHANGE}
	;;
    down)
	if [[ $(get_brightness) -le ${BRIGHTNESS_PCT_CHANGE} ]]; then
		xbacklight -set 1
	else
		xbacklight -dec ${BRIGHTNESS_PCT_CHANGE}
	fi
	;;
esac

send_notification


#!/usr/bin/env zsh
# changeVolume

# Arbitrary but unique message id
MSG_ID="9969420"

VOLUME_PCT_CHANGE=1
MAX_TICKS=20
NUM_TICKS=$(( 100/${MAX_TICKS} ))

function get_progress_string {
	local volume=$1
	local range=$((  ${volume}/${NUM_TICKS} ))
	printf '▀%.0s' {1..$range}
}

function send_notification {
	local volume="$(pamixer --get-volume)"
	local mute="$(pamixer --get-mute)"
	if [[ $volume == 0 || "$mute" == "true" ]]; then
		# Show the sound muted notification
		dunstify -a "changeVolume" -u low -i audio-volume-muted -r "$MSG_ID" "Volume muted" 
	else
		# Show the volume notification
		dunstify -a "changeVolume" -u low -i audio-volume-high -r "$MSG_ID" \
			"Volume: ${volume}%" "$(get_progress_string $volume)"
	fi
}

case $1 in
    up)
    pamixer -u
	pamixer -i $VOLUME_PCT_CHANGE
	;;
    down)
	pamixer -d $VOLUME_PCT_CHANGE
	;;
    mute)
    # Toggle mute
	pamixer -t
	;;
esac

# Play the volume changed sound
canberra-gtk-play -i audio-volume-change -d "changeVolume"

send_notification


#!/bin/env sh
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
for m in $(xrandr --query -display ${DISPLAY}| grep " connected" | cut -d" " -f1); do
  MONITOR=$m polybar -c ~/.config/polybar/config.ini top &
done


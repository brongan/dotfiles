if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
	local hostname=$(hostnamectl hostname --pretty)
	if [[ $hostname = "framework" ||  $hostname = "desktop" ]]; then
		exec uwsm start hyprland.desktop
	fi
fi


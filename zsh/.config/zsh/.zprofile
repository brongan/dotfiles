if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
	if [[ $(hostnamectl hostname) = "framework" ||  $(hostnamectl hostname) = "desktop" ]]; then
		exec Hyprland
	fi
fi


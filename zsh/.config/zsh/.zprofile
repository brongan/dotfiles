if [[ -z $DISPLAY && $(tty) = /dev/tty1 ]]; then
	if [[ $(hostnamectl hostname --pretty) = "framework" ||  $(hostnamectl hostname --pretty) = "desktop" ]]; then
		Hyprland
	fi
fi


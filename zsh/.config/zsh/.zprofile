if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	if [[ $(hostnamectl hostname) = "framework" ]]; then
		exec sway
	elif [[ $(hostnamectl hostname) = "desktop" ]]; then
		startplasma-wayland
	fi
fi


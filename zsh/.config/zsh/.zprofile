if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	if [[ $(hostnamectl hostname) = "framework" ]]; then
		exec sway
	elif [[ $(hostnamectl hostname) = "desktop" ]]; then
		startx "$XDG_CONFIG_HOME/X11/xinitrc" -- "$XDG_CONFIG_HOME/X11/xserverrc" vt1
	fi
fi


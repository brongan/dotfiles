WAYLAND=true

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	if [ "${WAYLAND}" -eq "true" ]; then
		exec startx "$XDG_CONFIG_HOME/X11/.xinitrc" vt1
	else
		exec sway
	fi
fi


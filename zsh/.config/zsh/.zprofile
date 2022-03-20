if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	exec /usr/bin/env GBM_BACKEND=nvidia-drm __GLX_VENDOR_LIBRARY_NAME=nvidia WLR_NO_HARDWARE_CURSORS=1 XDG_CURRENT_DESKTOP=sway QT_QPA_PLATFORM=wayland SDL_VIDEODRIVER=wayland MOZ_ENABLE_WAYLAND=1 sway --unsupported-gpu
elif [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty2 ]]; then
	startx "$XDG_CONFIG_HOME/X11/xinitrc" -- "$XDG_CONFIG_HOME/X11/xserverrc" vt2
fi


local hostname=$(hostnamectl hostname --pretty)
if [[ $hostname = "framework" ||  $hostname = "desktop" ]]; then
	if uwsm check may-start 1; then
		exec uwsm start hyprland.desktop
	fi
fi


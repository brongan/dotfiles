hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_SCALE_FACTOR", "1")
hl.env("GDK_SCALE", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("WAYLAND_DISPLAY", "wayland-1")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("GDK_BACKEND", "wayland")
hl.env("GTK_THEME", "Adwaita:dark")
hl.env("QT_STYLE_OVERRIDE", "Adwaita-Dark")

pcall(require, "monitors")

hl.config({
	input = {
		kb_options = "caps:escape",
		repeat_rate = 50,
		repeat_delay = 240,
		sensitivity = 0.0,
		accel_profile = "flat",
		follow_mouse = false,

		touchpad = {
			natural_scroll = true,
			clickfinger_behavior = true,
			middle_button_emulation = false,
			tap_to_click = true,
		},
	},

	gestures = {
		workspace_swipe_min_speed_to_force = 5,
		workspace_swipe_create_new = false,
	},

	general = {
		allow_tearing = true,
		layout = "dwindle",
		gaps_in = 8,
		gaps_out = 15,
		border_size = 5,
		col = {
			active_border = "0xff5e81ac",
			inactive_border = "0x66333333",
		},
	},

	decoration = {
		rounding = 18,
		blur = {
			enabled = true,
			size = 7,
			passes = 2,
			new_optimizations = true,
		},
		shadow = {
			enabled = true,
			range = 15,
			color = "0xffa7caff",
			color_inactive = "0x50000000",
		},
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		force_split = 2,
		preserve_split = true,
	},

	master = {
		new_on_top = true,
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		enable_anr_dialog = false,
		mouse_move_enables_dpms = true,
		mouse_move_focuses_monitor = false,
		on_focus_under_fullscreen = 1,
	},

	render = {
		direct_scanout = true,
	},

	xwayland = {
		force_zero_scaling = true,
	},

	debug = {
		disable_logs = false,
	},

	ecosystem = {
		no_update_news = true,
	},
})

hl.curve("overshot", {
	type = "bezier",
	points = { { 0.13, 0.99 }, { 0.29, 1.1 } },
})

hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 4,
	bezier = "overshot",
	style = "popin",
})
hl.animation({
	leaf = "fade",
	enabled = true,
	speed = 10,
	bezier = "default",
})
hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 6,
	bezier = "overshot",
	style = "slide",
})
hl.animation({
	leaf = "border",
	enabled = true,
	speed = 10,
	bezier = "default",
})

hl.on("hyprland.start", function()
	hl.exec_cmd("swaybg -o '*' -i ~/Desktop/frieren.jpg")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("ghostty", { workspace = "1 silent" })
	hl.exec_cmd("firefox", { workspace = "2 silent" })
	hl.exec_cmd("signal-desktop", { workspace = "4 silent" })
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("ironbar")
	hl.exec_cmd("blueberry-tray")
	hl.exec_cmd("/usr/lib/kdeconnectd")
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)

require("bindings")
require("rules")

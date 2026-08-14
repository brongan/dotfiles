hl.layer_rule({
	name = "blurl-waybar",
	match = { namespace = "waybar" },
	blur = true,
})

hl.layer_rule({
	name = "blurl-lockscreen",
	match = { namespace = "lockscreen" },
	blur = true,
})

hl.layer_rule({
	name = "layerrule-fuzzel",
	match = { namespace = "fuzzel" },
	blur = true,
	no_anim = true,
})

hl.layer_rule({
	name = "layerrule-notifications",
	match = { namespace = "notifications" },
	blur = true,
	no_anim = true,
})

hl.layer_rule({
	name = "layerrule-anyrun",
	match = { namespace = "anyrun" },
	no_anim = true,
})

hl.window_rule({
	name = "float-chip8",
	match = { title = "^(Chip-8)$" },
	float = true,
})

hl.window_rule({
	name = "float-gameboy",
	match = { title = "^(Gameboy)$" },
	float = true,
})

hl.window_rule({
	name = "float-open-file",
	match = { title = "^(Open File)" },
	float = true,
})

hl.window_rule({
	name = "float-save-file",
	match = { title = "^(Save File)" },
	float = true,
})

hl.window_rule({
	name = "float-file-progress",
	match = { class = "^(file_progress)$" },
	float = true,
})

hl.window_rule({
	name = "float-file-chooser",
	match = { class = "^(GtkFileChooserDialog)$" },
	float = true,
})

hl.window_rule({
	name = "float-operation-progress",
	match = { title = "^(File Operation Progress)" },
	float = true,
})

hl.window_rule({
	name = "float-xdg-portal",
	match = { class = "^(xdg-desktop-portal-gtk)$" },
	float = true,
})

hl.window_rule({
	name = "float-pip",
	match = { title = "^(Picture-in-Picture)$" },
	float = true,
})

hl.window_rule({
	name = "float-firefox-file",
	match = { title = "^(Firefox - Choose File)" },
	float = true,
})

hl.window_rule({
	name = "float-pavucontrol",
	match = { class = "^(org.pulseaudio.pavucontrol)$" },
	float = true,
})

hl.window_rule({
	name = "passage-pin-float",
	match = { class = "^(passage-pin)$" },
	float = true,
	size = { "monitor_w*0.2", "monitor_h*0.2" },
	center = true,
})

hl.window_rule({
	name = "game-steam",
	match = { class = "^(steam_app_.*)$" },
	immediate = true,
})

hl.window_rule({
	name = "game-pioneer",
	match = { class = "^(pioneergame.exe)$" },
	stay_focused = true,
	render_unfocused = true,
	opacity = "1.0 override 1.0 override",
	suppress_event = "activate",
})

hl.window_rule({
	name = "passage-gui-float",
	match = { class = "^(com\\.brongan\\.passage-gui)$" },
	float = true,
	center = true,
})

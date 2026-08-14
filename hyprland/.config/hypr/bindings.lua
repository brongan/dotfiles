local function bind(keys, dispatcher, options)
	return hl.bind(keys, dispatcher, options)
end

local function exec(command)
	return hl.dsp.exec_cmd(command)
end

bind("SUPER + SPACE", exec("$(fuzzel)"), { release = true })
bind("SUPER + RETURN", exec("ghostty"))
bind("CTRL + SHIFT + L", exec("loginctl lock-session"))
bind("SUPER + W", hl.dsp.window.close())
bind("SUPER + SHIFT + R", hl.dsp.exit())
bind("SUPER + F", hl.dsp.window.fullscreen({ action = "toggle" }))
bind("SUPER + SHIFT + S", hl.dsp.window.float({ action = "toggle" }))
bind("SUPER + A", exec("pavucontrol"))
bind("SUPER + B", exec("blueberry"))
bind("SUPER + D", exec("vesktop"))
bind("SUPER + E", exec("thunar"))
bind("SUPER + G", exec("signal-desktop"))
bind("SUPER + N", exec("ghostty -e nvim"))
bind("SUPER + O", exec("obsidian"))
bind("SUPER + T", exec("ghostty -e btop"))
bind("SUPER + V", exec("cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"))
bind("SUPER + s", exec("steam"))
bind("SUPER + P", exec("passage-gui --clip --qrcode"))

for _, direction in ipairs({
	{ key = "h", direction = "l" },
	{ key = "j", direction = "d" },
	{ key = "k", direction = "u" },
	{ key = "l", direction = "r" },
	{ key = "left", direction = "l" },
	{ key = "down", direction = "d" },
	{ key = "up", direction = "u" },
	{ key = "right", direction = "r" },
}) do
	bind("SUPER + " .. direction.key, hl.dsp.focus({ direction = direction.direction }))
end

for _, direction in ipairs({
	{ key = "h", direction = "l" },
	{ key = "j", direction = "d" },
	{ key = "k", direction = "u" },
	{ key = "l", direction = "r" },
	{ key = "left", direction = "l" },
	{ key = "down", direction = "d" },
	{ key = "up", direction = "u" },
	{ key = "right", direction = "r" },
}) do
	bind("SUPER + SHIFT + " .. direction.key, hl.dsp.window.swap({ direction = direction.direction }))
end

for workspace = 1, 10 do
	local key = workspace % 10
	bind("SUPER + " .. key, hl.dsp.focus({ workspace = workspace }))
	bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace, follow = false }))
end

bind("SUPER + BRACKETLEFT", hl.dsp.focus({ workspace = "e-1" }))
bind("SUPER + BRACKETRIGHT", hl.dsp.focus({ workspace = "e+1" }))

bind("SUPER + CTRL + left", hl.dsp.workspace.move({ monitor = "l" }))
bind("SUPER + CTRL + right", hl.dsp.workspace.move({ monitor = "r" }))

bind("ALT + left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
bind("ALT + right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
bind("ALT + up", hl.dsp.window.resize({ x = 0, y = -50, relative = true }))
bind("ALT + down", hl.dsp.window.resize({ x = 0, y = 50, relative = true }))
bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })

bind("Print", exec("hyprshot -m output --clipboard-only"))
bind("SUPER + Print", exec("hyprshot -m region --clipboard-only"))
bind("SHIFT + Print", exec("hyprshot -m window --clipboard-only"))

bind(
	"XF86AudioRaiseVolume",
	exec("wpctl set-volume @DEFAULT_SINK@ -l 1.0 5%+ && notifyVolume.sh"),
	{ repeating = true }
)
bind(
	"XF86AudioLowerVolume",
	exec("wpctl set-volume @DEFAULT_SINK@ -l 1.0 5%- && notifyVolume.sh"),
	{ repeating = true }
)
bind("XF86AudioMute", exec("wpctl set-mute @DEFAULT_SINK@ toggle && notifyVolume.sh"), { repeating = true })
bind("XF86MonBrightnessUp", exec("brightnessctl set 5%+ -m | xargs notifyBrightness.sh"), { repeating = true })
bind("XF86MonBrightnessDown", exec("brightnessctl set 5%- -m | xargs notifyBrightness.sh"), { repeating = true })

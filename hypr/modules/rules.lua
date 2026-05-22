hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({
	name = "browser-workspace",
	match = {
		class = "firefox",
	},
	workspace = "3",
})

hl.window_rule({
	name = "spotify-workspace",
	match = {
		class = "Spotify",
	},
	workspace = "9 silent",
})

hl.window_rule({
	name = "steam-workspace",
	match = {
		class = "steam",
	},
	workspace = "5 silent",
})

hl.window_rule({
	name = "bluetooth panel",
	match = {
		class = "kitty",
		title = "bluetui",
	},
	no_anim = true,
	float = true,
	center = 1,
	size = "(monitor_w*0.6) (monitor_h*0.6)",
})

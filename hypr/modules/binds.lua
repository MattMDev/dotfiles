local terminal = "kitty"
-- local browser = "firefox"
-- local browser2 = "qutebrowser"
local fileManager = "dolphin"
-- local menu = "wofi --show drun --columns 1"
local menu = "qs -c noctalia-shell ipc call launcher toggle"
local clipboard = "cliphist list | wofi -S dmenu | cliphist decode | wl-copy"

local mainMod = "ALT" -- Sets "Windows" key as main modifier
local secondaryMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", function()
	hl.exec_cmd("killall bluetui 2>/dev/null")
	hl.exec_cmd(terminal .. " --title bluetui bluetui")
end)
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(secondaryMod .. " + V", hl.dsp.exec_cmd(clipboard))
hl.bind(mainMod .. "+ SHIFT + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(
	mainMod .. "+ SHIFT + M",
	hl.dsp.exec_cmd(
		"command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()' || poweroff"
	)
)

-- To switch between windows in a floating workspace:
hl.bind(mainMod .. "+ Tab", function()
	hl.dispatch(hl.dsp.window.cycle_next()) -- Change focus to another window
	hl.dispatch(hl.dsp.window.bring_to_top()) -- Bring it to the top
end)

-- To switch between windows in a floating workspace:
hl.bind(mainMod .. "+ SHIFT + Tab", function()
	hl.dispatch(hl.dsp.window.cycle_next(-1)) -- Change focus to another window
	hl.dispatch(hl.dsp.window.bring_to_top()) -- Bring it to the top
end)

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Modes
-- Resize Mode
-- Switch to a submap called `resize`.
hl.bind("CTRL + ALT + R", hl.dsp.submap("resize"))

-- Start a submap called "resize".
hl.define_submap("resize", function()
	-- Set repeating binds for resizing the active window.
	hl.bind("H", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("L", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("K", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("J", hl.dsp.window.resize({ x = 10, y = -10, relative = true }), { repeating = true })
	hl.bind("CTRL + H", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
	hl.bind("CTRL + L", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
	hl.bind("CTRL + K", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })
	hl.bind("CTRL + J", hl.dsp.window.resize({ x = 30, y = -30, relative = true }), { repeating = true })

	-- Use `reset` to go back to the global submap
	hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Window switcher mode
hl.bind("CTRL + ALT + W", hl.dsp.submap("window_switcher"))

-- Start a submap called "resize".
hl.define_submap("window_switcher", function()
	-- Set repeating binds for resizing the active window.
	hl.bind("H", hl.dsp.focus({ direction = "left" }))
	hl.bind("L", hl.dsp.focus({ direction = "right" }))
	hl.bind("K", hl.dsp.focus({ direction = "up" }))
	hl.bind("J", hl.dsp.focus({ direction = "down" }))
	hl.bind("CTRL + H", hl.dsp.window.move({ direction = "left" }))
	hl.bind("CTRL + L", hl.dsp.window.move({ direction = "right" }))
	hl.bind("CTRL + K", hl.dsp.window.move({ direction = "up" }))
	hl.bind("CTRL + J", hl.dsp.window.move({ direction = "down" }))

	-- Use `reset` to go back to the global submap
	hl.bind("escape", hl.dsp.submap("reset"))
end)

-- power mode
hl.bind("CTRL + ALT + P", hl.dsp.submap("power"))

-- Start a submap called "power".
hl.define_submap("power", function()
	hl.bind("P", hl.dsp.exec_cmd("poweroff"))

	-- Use `reset` to go back to the global submap
	hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Custom scripts
hl.bind("CTRL + F1", hl.dsp.cursor.move_to_corner({ corner = 0 }))
hl.bind("CTRL + F2", function()
	if toggle_monitor_profile then
		toggle_monitor_profile()
	end
end)

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

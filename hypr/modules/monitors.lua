local PROFILE_FILE = "/tmp/hypr-monitor-profile"

local function read_profile()
	local f = io.open(PROFILE_FILE, "r")
	local p = f and f:read("*l") or nil
	if f then
		f:close()
	end
	return p
end

local function write_profile(name)
	local f = io.open(PROFILE_FILE, "w")
	if f then
		f:write(name)
		f:close()
	end
end

if not read_profile() then
	write_profile("desktop")
end

local profile = read_profile()

local function set_spotify_scale(scale)
	hl.exec_cmd(
		"sed -i 's/force-device-scale-factor=[0-9.]\\+/force-device-scale-factor="
			.. scale
			.. "/' ~/.config/spotify-launcher.conf"
	)
end

if profile == "tv" then
	hl.monitor({ output = "HDMI-A-3", mode = "2560x1440@60", position = "0x0", scale = 2 })
	set_spotify_scale(3.0)
else
	hl.monitor({ output = "DP-1", mode = "2560x1440@164.96Hz", position = "0x0", scale = 1 })
	hl.monitor({ output = "DP-3", mode = "1920x1080@60", position = "2560x0", scale = 1 })
	hl.workspace_rule({ workspace = "9", monitor = "DP-3" })
	hl.monitor({ output = "HDMI-A-3", mode = "2560x1440@60", position = "4480x0", scale = 2 })
	set_spotify_scale(2.0)
end

function apply_profile_after_reload()
	local p = profile

	if p == "tv" then
		hl.exec_cmd("killall qs 2>/dev/null")
		hl.exec_cmd("sleep 0.5")
		hl.exec_cmd("qs -c noctalia-shell")
		set_spotify_scale(3.0)
		hl.exec_cmd("killall spotify 2>/dev/null; spotify-launcher &")
		hl.notification.create({ text = "Switched to TV mode", timeout = 3000 })
		return
	end

	local monitors = {}
	for _, m in ipairs(hl.get_monitors()) do
		monitors[m.name] = true
	end

	if monitors["DP-1"] then
		if monitors["DP-3"] then
			hl.dispatch(hl.dsp.workspace.move({ workspace = 9, monitor = "DP-3" }))
		end
		for _, ws in ipairs(hl.get_workspaces()) do
			if ws.id ~= 9 then
				hl.dispatch(hl.dsp.workspace.move({ workspace = ws.id, monitor = "DP-1" }))
			end
		end
	end

	hl.exec_cmd("killall qs 2>/dev/null")
	hl.exec_cmd("qs -c noctalia-shell")
	set_spotify_scale(2.0)
	hl.exec_cmd("killall spotify 2>/dev/null; spotify-launcher &")
	hl.notification.create({ text = "Switched to desktop mode", timeout = 3000 })
end

function toggle_monitor_profile()
	local current = profile
	local next = current == "tv" and "desktop" or "tv"
	profile = next
	write_profile(next)

	if next == "tv" then
		hl.exec_cmd(
			"hyprctl reload && hyprctl eval 'hl.monitor({output = \"DP-1\", disabled = true})' && hyprctl eval 'hl.monitor({output = \"DP-3\", disabled = true})' && hyprctl eval 'apply_profile_after_reload()'"
		)
	else
		hl.exec_cmd(
			"hyprctl reload && hyprctl eval 'hl.monitor({output = \"HDMI-A-3\", disabled = true})' && hyprctl eval 'apply_profile_after_reload()'"
		)
	end
end

hl.on("monitor.removed", function(monitor)
	if monitor.name == "HDMI-A-3" then
		if profile == "tv" then
			profile = "desktop"
			write_profile("desktop")
			hl.notification.create({ text = "TV disconnected, switching to desktop", timeout = 3000 })
			hl.exec_cmd("hyprctl reload")
		end
	end
end)

hl.on("monitor.added", function(monitor)
	if profile == "tv" and (monitor.name == "DP-1" or monitor.name == "DP-3") then
		profile = "desktop"
		write_profile("desktop")
		hl.notification.create({ text = "Monitors detected, switching to desktop", timeout = 3000 })
		hl.exec_cmd("hyprctl reload")
	end
end)

hl.on("hyprland.start", function()
	local p = profile
	if p == "tv" then
		hl.timer(function()
			hl.exec_cmd(
				"hyprctl eval 'hl.monitor({output = \"DP-1\", disabled = true})' && hyprctl eval 'hl.monitor({output = \"DP-3\", disabled = true})' && hyprctl eval 'apply_profile_after_reload()'"
			)
		end, { timeout = 500 })
	else
		hl.timer(function()
			hl.exec_cmd("hyprctl eval 'hl.monitor({output = \"HDMI-A-3\", disabled = true})'")
			apply_profile_after_reload()
		end, { timeout = 500 })
	end
end)

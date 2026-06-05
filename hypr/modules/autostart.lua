local music = "spotify-launcher"
local browser = "firefox"
local terminal = "kitty"
local wallpaper = "hyprpaper"
local bar = "qs -c noctalia-shell"
local steam = "steam"

local DESKTOP_MAIN = "DP-1"
local DESKTOP_SECONDARY = "DP-3"

local function organize_workspaces()
	local monitors = {}
	for _, m in ipairs(hl.get_monitors()) do
		monitors[m.name] = true
	end
	if not monitors[DESKTOP_MAIN] then
		return
	end

	if monitors[DESKTOP_SECONDARY] then
		hl.dispatch(hl.dsp.workspace.move({ workspace = 9, monitor = DESKTOP_SECONDARY }))
	end

	for _, ws in ipairs(hl.get_workspaces()) do
		if ws.id ~= 9 then
			hl.dispatch(hl.dsp.workspace.move({ workspace = ws.id, monitor = DESKTOP_MAIN }))
		end
	end
end

hl.on("hyprland.start", function()
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")

	organize_workspaces()

	hl.exec_cmd(terminal, { workspace = 1 })
	hl.exec_cmd(terminal, { workspace = 2 })

	hl.exec_cmd(browser)
	hl.exec_cmd(music)
	hl.exec_cmd(wallpaper)
	hl.exec_cmd(bar)
	hl.exec_cmd(steam)
end)

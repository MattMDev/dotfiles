-- local terminal = "kitty"
-- local browser = "firefox"
-- local browser2 = "qutebrowser"
-- local fileManager = "dolphin"
-- local scripts = "/home/matan/dev/dotfiles/scripts"
-- local menu = "wofi --show drun --columns 1"
-- local copy = "cliphist list | wofi -S dmenu | cliphist decode | wl-copy"

local music = "spotify-launcher"
local wallpaper = "hyprpaper"
local bar = "qs -c noctalia-shell"

-- TODO: Open apps in dedicated workspaces
-- exec-once = [workspace 1 silent] $terminal
-- exec-once = [workspace 2 silent] $terminal
-- exec-once = [workspace 3 silent] $browser
-- exec-once = [workspace 4 silent] sleep 2 && qutebrowser
-- exec-once = [workspace 9 silent] sleep 5 && $music

hl.on("hyprland.start", function()
	hl.exec_cmd(bar)
	hl.exec_cmd(wallpaper)
	hl.exec_cmd(music)
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)

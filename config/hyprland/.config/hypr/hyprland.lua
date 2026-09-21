hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("GTK_THEME", "Tokyonight-Dark")

hl.config({
	input = {
		kb_layout = "us, br",
		kb_model = ", abnt2",

		follow_mouse = 1,
		touchpad = {
			natural_scroll = false,
			disable_while_typing = false,
		},
	},

	ecosystem = {
		enforce_permissions = true,
	},
})

hl.permission({ binary = "/usr/(bin|local/bin)/discord", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/(bin|local/bin)/grim", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/(bin|local/bin)/hyprlock", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", type = "screencopy", mode = "allow" })

-- startup
hl.on("hyprland.start", function()
	hl.exec_cmd("nm-applet") -- internet tray
	hl.exec_cmd("hyprpaper") -- wallpaper
	hl.exec_cmd("hypridle") -- idle management
	hl.exec_cmd("waybar") -- taskbar

	-- wayland portals (screen sharing)
	hl.exec_cmd("xdg-desktop-portal-hyprland")
	hl.exec_cmd("xdg-desktop-portal")
end)

-- modules
require("lua.theme") -- gaps, borders, animations, rules
require("lua.binds") -- keybinds and gestures

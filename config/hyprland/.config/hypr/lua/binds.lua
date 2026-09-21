local mod = "SUPER"

-- gestures
hl.gesture({ fingers = 2, direction = "pinchout", mods = mod, action = "close" })
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "swipe", mods = mod, action = "move" })
hl.gesture({ fingers = 3, direction = "swipe", mods = "CTRL", action = "resize" })

-- workspaces
local workspaceKeys = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }

-- media player
local player = "playerctl --player=spotify "
local playerDirActions = { left = "previous", right = "next", up = "volume 0.1+", down = "volume 0.1-" }

-- arrow keys + vim keys
-- stylua: ignore
local directions = {
	left = "left", right = "right", up = "up", down = "down",
	h = "left", l = "right", k = "up", j = "down",
}

local binds = {
	-- programs
	browser = { key = "B", cmd = "brave" },
	fileManager = { key = "E", cmd = "thunar" },
	launcher = { key = "Space", cmd = "~/.config/rofi/scripts/lauch.sh drun" },
	musicPlayer = { key = "S", cmd = "spotify" },
	terminal = { key = "Return", cmd = "kitty" },
	screenLock = { key = "CTRL + l", cmd = "hyprlock" },
	printScreen = { key = "Print", nomod = true, cmd = 'grim -g "$(slurp)" - | wl-copy' },
	discord = { key = "d", cmd = "discord" },
	obsidian = { key = "n", cmd = "obsidian" },

	-- scripts
	switchLayout = { key = "grave", cmd = "hyprctl switchxkblayout all next" }, -- us / br
	reload = { key = "SHIFT + r", cmd = "pkill waybar; hyprctl reload && waybar" },
	cycleSink = { key = "ALT + s", cmd = "~/.dotfiles/scripts/cycle_sink.sh", repeating = true, locked = true },

	-- window
	close = { key = "Q", action = hl.dsp.window.close() },
	fullscreen = { key = "F", action = hl.dsp.window.fullscreen() },
	float = { key = "SHIFT + Space", action = hl.dsp.window.float() },
	drag = { key = "mouse:272", action = hl.dsp.window.drag(), mouse = true },
	resize = { key = "mouse:273", action = hl.dsp.window.resize(), mouse = true },

	toggleAnimations = {
		key = "a",
		action = function()
			hl.config({ animations = { enabled = not hl.get_config("animations.enabled") } })
		end,
	},

	-- multimedia keys
	volumeUp = {
		key = "XF86AudioRaiseVolume",
		nomod = true,
		cmd = "pactl set-sink-volume @DEFAULT_SINK@ +10%",
		repeating = true,
		locked = true,
	},
	volumeDown = {
		key = "XF86AudioLowerVolume",
		nomod = true,
		cmd = "pactl set-sink-volume @DEFAULT_SINK@ -10%",
		repeating = true,
		locked = true,
	},
	mute = {
		key = "XF86AudioMute",
		nomod = true,
		cmd = "pactl set-mute @DEFAULT_AUDIO_SINK@ toggle",
		repeating = true,
		locked = true,
	},
	micMute = {
		key = "XF86AudioMicMute",
		nomod = true,
		cmd = "pactl set-source-mute @DEFAULT_SOURCE@ toggle",
		repeating = true,
		locked = true,
	},
	brightnessUp = {
		key = "XF86MonBrightnessUp",
		nomod = true,
		cmd = "brightnessctl -e4 -n2 set 5%+",
		repeating = true,
		locked = true,
	},
	brightnessDown = {
		key = "XF86MonBrightnessDown",
		nomod = true,
		cmd = "brightnessctl -e4 -n2 set 5%-",
		repeating = true,
		locked = true,
	},

	-- media player
	playPause = { key = "ALT + Space", cmd = player .. "play-pause", locked = true },
	seekForward = { key = "ALT + u", cmd = player .. "position 5+", locked = true },
	seekBackward = { key = "ALT + d", cmd = player .. "position 5-", locked = true },
}

-- direction keybinds
for key, dir in pairs(directions) do
	table.insert(binds, {
		key = key,
		action = hl.dsp.focus({ direction = dir }),
	}) -- focus

	table.insert(binds, {
		key = "SHIFT + " .. key,
		action = hl.dsp.window.move({ direction = dir }),
	}) -- move window

	table.insert(binds, {
		key = "ALT + " .. key,
		cmd = player .. playerDirActions[dir],
		locked = true,
	}) -- media player
end

-- workspace keybinds
for ws, key in ipairs(workspaceKeys) do
	table.insert(binds, {
		key = key,
		action = hl.dsp.focus({ workspace = ws }),
	}) -- switch to workspace

	table.insert(binds, {
		key = "SHIFT + " .. key,
		action = hl.dsp.window.move({ workspace = ws, follow = false }),
	}) -- move focused window to workspace
end

-- apply binds
for _, bind in pairs(binds) do
	local keys = bind.key

	if not bind.nomod then
		keys = mod .. " + " .. keys
	end

	hl.bind(keys, bind.action or hl.dsp.exec_cmd(bind.cmd), bind)
end

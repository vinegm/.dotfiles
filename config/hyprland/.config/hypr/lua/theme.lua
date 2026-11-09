hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 15,

		border_size = 2,

		col = {
			active_border = "rgba(F7768FEE)",
			inactive_border = "rgba(7AA2F7EE)",
		},

		allow_tearing = true,

		layout = "dwindle",
	},

	dwindle = {
		preserve_split = true,
	},

	decoration = {
		rounding = 10,
		rounding_power = 2,
	},

	animations = {
		enabled = false,
	},
})

-- NAME = { { X0, Y0 }, { X1, Y1} }
local curves = {
	linear = { { 1.00, 1.00 }, { 1.00, 1.00 } },
	bouncy = { { 0.70, -0.55 }, { 0.27, 1.55 } },
	slowSlide = { { 0.12, 0.00 }, { 0.40, 0.00 } },
}

for name, points in pairs(curves) do
	hl.curve(name, { type = "bezier", points = points })
end

-- { LEAF, ONOFF, SPEED, CURVE, STYLE}
local animations = {
	{ "border", false },

	{ "layers", true, 3.00, "bouncy", "slide" },
	{ "workspaces", true, 3.50, "slowSlide", "slide" },

	{ "fade", true, 3.00, "linear" },
	{ "windows", true, 5.00, "bouncy", "slide" },
	{ "windowsIn", true, 3.00, "bouncy", "gnomed" },
	{ "windowsOut", true, 3.00, "slowSlide", "slide" },
}

for _, a in ipairs(animations) do
	local leaf, enabled, speed, bezier, style = table.unpack(a)
	hl.animation({
		leaf = leaf,
		enabled = enabled,
		speed = speed,
		bezier = bezier,
		style = style,
	})
end

-- Ignore maximize requests from apps
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Only shows gaps if there is more than one window
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
-- for i, ws in ipairs({ "w[tv1]", "f[1]" }) do
--   hl.window_rule({
--     name = "windowrule-" .. i,
--     border_size = 0,
--     rounding = 0,
--     match = { float = false, workspace = ws },
--   })
-- end

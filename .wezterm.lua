-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Monokai Pro (Gogh)"

config.colors = {
	background = "#2d2a2e",
}

config.enable_tab_bar = false

config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = 500 })
config.freetype_load_target = "Normal"

config.default_prog = { "wsl", "~", "zellij" }

config.default_cursor_style = "SteadyBar"

-- config.window_decorations = "NONE"

config.font_size = 10.0

local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

-- and finally, return the configuration to wezterm
return config

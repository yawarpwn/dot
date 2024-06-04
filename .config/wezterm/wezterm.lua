---@type Wezterm
local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("keys").setup(config)
require("links").setup(config)
require("tabs").setup(config)

config.front_end = "WebGpu"
config.front_end = "OpenGL" -- current work-around for https://github.com/wez/wezterm/issues/4825
config.enable_wayland = true
config.webgpu_power_preference = "HighPerformance"
-- config.animation_fps = 1
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- Colorscheme
config.color_scheme_dirs = { "https://github.com/folke/tokyonight.nvim/tree/main/extras/wezterm" }
config.color_scheme = "tokyonight_night"
-- wezterm.add_to_config_reload_watch_list(config.color_scheme_dirs[1] .. config.color_scheme .. ".toml")

config.colors = {
	indexed = { [241] = "#65bcff" },
}

config.underline_thickness = 3
config.cursor_thickness = 4
config.underline_position = -6

if wezterm.target_triple:find("windows") then
	config.default_prog = { "pwsh" }
	config.window_decorations = "RESIZE|TITLE"
	wezterm.on("gui-startup", function(cmd)
		local screen = wezterm.gui.screens().active
		local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
		local gui = window:gui_window()
		local width = 0.7 * screen.width
		local height = 0.7 * screen.height
		gui:set_inner_size(width, height)
		gui:set_position((screen.width - width) / 2, (screen.height - height) / 2)
	end)
else
	config.term = "wezterm"
	-- config.window_decorations = "RESIZE"
end
-- Fonts
config.font_size = 11
config.font = wezterm.font({ family = "Fira Code Nerd Font" })
config.bold_brightens_ansi_colors = true

-- Cursor
config.default_cursor_style = "BlinkingBar"
config.force_reverse_video_cursor = true
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_background_opacity = 0.98
-- cell_width = 0.9,
config.scrollback_lines = 10000

-- and finally, return the configuration to wezterm
return config --[[@as Wezterm]]

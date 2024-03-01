---@type Wezterm
local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("tabs").setup(config)
require("keys").setup(config)
require("links").setup(config)

-- WSL.exe
local wsl_domains = wezterm.default_wsl_domains()
for idx, domain in ipairs(wsl_domains) do
	domain.default_cwd = "~"
end

-- wezterm.on("gui-startup", function(cmd)
-- 	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
-- 	window:gui_window():toggle_fullscreen()
-- end)
config.default_domain = "WSL:Debian"
config.set_environment_variables = {
	-- This changes the default prompt for cmd.exe to report the
	-- current directory using OSC 7, show the current time and
	-- the current directory colored in the prompt.
	prompt = "$E]7;file://localhost/$P$E\\$E[32m$T$E[0m $E[35m$P$E[36m$_$G$E[0m ",
}

config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.animation_fps = 1
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.underline_thickness = 3
config.cursor_thickness = 4
config.underline_position = -6

--Colorscheme
config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 0.9

config.disable_default_key_bindings = true

-- Fonts
config.font_size = 11
-- config.font = wezterm.font({ family = "Fira Code" })
config.font = wezterm.font("JetBrains Mono")
-- config.font = wezterm.font({
-- 	family = "FiraCode Nerd Font Mono",
-- 	weight = "Light",
-- 	stretch = "Normal",
-- 	style = "Normal",
-- 	harfbuzz_features = { "cv29", "cv30", "ss01", "ss03", "ss06", "ss07", "ss09" },
-- })
config.bold_brightens_ansi_colors = true

-- Cursor
config.default_cursor_style = "BlinkingBar"
config.force_reverse_video_cursor = true
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_close_confirmation = "NeverPrompt"
-- cell_width = 0.9,
--
config.scrollback_lines = 10000
config.wsl_domains = wsl_domains

return config--[[@as Wezterm]]

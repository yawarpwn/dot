local wezterm = require("wezterm") --[[@as Wezterm]]

local act = wezterm.action
local M = {}

M.is_vim = function(pane)
	local process_info = pane:get_foreground_process_info()
	local process_name = process_info and process_info.name

	return process_name == "nvim" or process_name == "vim"
end

local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	-- reverse lookup
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

---@param resize_or_move "resize" | "move"
---@param key "h" | "j" | "k" | "l" | "Left" | "Down" | "Up" | "Right"
M.split_nav = function(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if M.is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

M.mod = wezterm.target_triple:find("windows") and "SHIFT|CTRL" or "SHIFT|SUPER"
-- M.mod = "SHIFT|SUPER"
M.smart_split = wezterm.action_callback(function(window, pane)
	local dim = pane:get_dimensions()
	if dim.pixel_height > dim.pixel_width then
		window:perform_action(act.SplitVertical({ domain = "CurrentPaneDomain" }), pane)
	else
		window:perform_action(act.SplitHorizontal({ domain = "CurrentPaneDomain" }), pane)
	end
end)

---@param config Config
function M.setup(config)
	config.disable_default_key_bindings = true
	config.keys = {
		-- Scrollback
		{ mods = M.mod, key = "k", action = act.ScrollByPage(-0.5) },
		{ mods = M.mod, key = "j", action = act.ScrollByPage(0.5) },
		-- New Tab
		{ mods = "CTRL|SHIFT", key = "t", action = act.SpawnTab("CurrentPaneDomain") },
		-- Splits
		{ mods = M.mod, key = "Enter", action = M.smart_split },
		{ mods = M.mod, key = "|", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ mods = M.mod, key = "_", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ mods = M.mod, key = "(", action = act.DecreaseFontSize },
		{ mods = M.mod, key = ")", action = act.IncreaseFontSize },
		-- Move Tabs
		{ mods = M.mod, key = ">", action = act.MoveTabRelative(1) },
		{ mods = M.mod, key = "<", action = act.MoveTabRelative(-1) },
		-- Acivate Tabs
		{ mods = M.mod, key = "l", action = act({ ActivateTabRelative = 1 }) },
		{ mods = M.mod, key = "h", action = act({ ActivateTabRelative = -1 }) },
		{ mods = M.mod, key = "R", action = wezterm.action.RotatePanes("Clockwise") },
		-- show the pane selection mode, but have it swap the active and selected panes
		{ mods = M.mod, key = "S", action = wezterm.action.PaneSelect({}) },
		-- Clipboard
		{ mods = M.mod, key = "c", action = act.CopyTo("Clipboard") },
		{ mods = M.mod, key = "Space", action = act.QuickSelect },
		{ mods = M.mod, key = "X", action = act.ActivateCopyMode },
		{ mods = M.mod, key = "f", action = act.Search("CurrentSelectionOrEmptyString") },
		{ mods = M.mod, key = "v", action = act.PasteFrom("Clipboard") },
		{
			mods = M.mod,
			key = "u",
			action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
		},
		-- { mods = M.mod, key = "v", action = act.ShowDebugOverlay },
		{ mods = M.mod, key = "m", action = act.TogglePaneZoomState },
		{ mods = M.mod, key = "p", action = act.ActivateCommandPalette },
		{ mods = M.mod, key = "d", action = act.ShowDebugOverlay },
		M.split_nav("move", "h"),
		M.split_nav("move", "j"),
		M.split_nav("move", "k"),
		M.split_nav("move", "l"),
		-- resize panes
	}
end

return M

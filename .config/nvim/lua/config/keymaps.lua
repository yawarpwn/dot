local util = require("util")

local Util = require("lazyvim.util")
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Disabled keymaps
keymap.set("n", "<leader>l", "")
keymap.set("n", "<leader>-", "")
keymap.set("n", "<leader>|", "")
keymap.set("n", "<leader>`", "")

keymap.set("n", "x", '"_x')

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root() })
end

--Floating terminal
keymap.set("n", "<m-3>", lazyterm, { desc = "Terminal (root dir)" })
keymap.set("n", "<m-1>", function()
  Util.terminal()
end, { desc = "Terminal (cwd)" })

--Terminal Mapping
keymap.set("t", "<m-3>", "<cmd>close<cr>", { desc = "Hide Terminal" })
keymap.set("t", "<m-1>", "<cmd>close<cr>", { desc = "which_key_ignore" })

keymap.set("n", "<c-w>", ":bd<cr>")

--Lsp
keymap.set("n", "<leader>lr", "<cmd>:LspRestart<cr>", { desc = "Restart LSP" })

local nav = {
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

local function navigate(dir)
  return function()
    local win = vim.api.nvim_get_current_win()
    vim.cmd.wincmd(dir)
    local pane = vim.env.WEZTERM_PANE
    if vim.system and pane and win == vim.api.nvim_get_current_win() then
      local pane_dir = nav[dir]
      vim.system({ "wezterm", "cli", "activate-pane-direction", pane_dir }, { text = true }, function(p)
        if p.code ~= 0 then
          vim.notify(
            "Failed to move to pane " .. pane_dir .. "\n" .. p.stderr,
            vim.log.levels.ERROR,
            { title = "Wezterm" }
          )
        end
      end)
    end
  end
end

util.set_user_var("IS_NVIM", true)

-- Move to window using the movement keys
for key, dir in pairs(nav) do
  vim.keymap.set("n", "<" .. dir .. ">", navigate(key))
  vim.keymap.set("n", "<C-" .. key .. ">", navigate(key))
end

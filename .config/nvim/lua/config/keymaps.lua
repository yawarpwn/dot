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

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

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

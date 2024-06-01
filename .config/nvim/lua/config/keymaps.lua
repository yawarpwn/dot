local util = require("util")

util.wezterm()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Disabled keymaps
keymap.set("n", "<leader>l", "")
keymap.set("n", "<leader>-", "")
keymap.set("n", "<leader>|", "")
keymap.set("n", "<leader>`", "")

-- keymap.set("n", "x", '"_x')

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

--Lsp
keymap.set("n", "<leader>lr", "<cmd>:LspRestart<cr>", { desc = "Restart LSP" })

--Change word with <c-c>
keymap.set("n", "<c-c>", "<cmd>normal! ciw<cr>a")

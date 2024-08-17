local util = require("util")

util.cowboy()
util.wezterm()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- change word with <c-c>
vim.keymap.set({ "n", "x" }, "<C-c>", "<cmd>normal! ciw<cr>a")

-- restart lsp
vim.keymap.set("n", "<leader>r", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

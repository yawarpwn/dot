local util = require("util")

util.cowboy()
util.wezterm()

-- change word with <c-c>
vim.keymap.set({ "n", "x" }, "<C-c>", "<cmd>normal! ciw<cr>a")

-- restart lsp
vim.keymap.set("n", "<leader>r", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })

-- vim.keymap.set("n", "\\", "<C-w>", { desc = "Show Window menu", remap = true })

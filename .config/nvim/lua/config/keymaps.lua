-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Disabled keymaps
keymap.set("n", "<leader>l", "")

keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
-- keymap.set("n", "dw", 'vb"_d')

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

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

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

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

keymap.set("n", "<m-r>", "<cmd>RustRun<cr>", { desc = "Rust run" })

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "<c-w>", ":bd<cr>")

-- Move to window using the <ctrl> hjkl keys
keymap.set("n", "<leader>h", "<C-w>h", opts)
keymap.set("n", "<leader>j", "<C-w>j", opts)
keymap.set("n", "<leader>k", "<C-w>k", opts)
keymap.set("n", "<leader>l", "<C-w>l", opts)

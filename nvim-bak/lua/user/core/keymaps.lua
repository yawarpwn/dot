vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<Leader>nh", ":nohl<cr>", { desc = "Clear search highlights" })

--increment descrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Icrement Number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Descrement Number" })

--window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window Horizontaly" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make split equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close current split" })


keymap.set("n", "<leader>to", "<cmd>tabnew<cr>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "Close current tab" })
keymap.set("n", "<s-h>", "<cmd>tabn<cr>", { desc = "Go to next tab" })
keymap.set("n", "<s-l>", "<cmd>tabp<cr>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabp %<cr>", { desc = "Open current buffer in new tab" })

-- Move Lines
keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- buffers
keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
keymap.set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

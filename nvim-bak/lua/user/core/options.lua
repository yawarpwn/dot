vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt
opt.relativenumber = true
opt.number = true

--tabs & identations
opt.tabstop = 2
opt.shiftwidth = 2
opt.autoindent = true

opt.wrap = false

--search settings
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

--turn on termguicolors for tokyonight colorscheme dark
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

--clipboard
opt.clipboard:append("unnamedplus") --use system clipboard default register

--split windows
opt.splitright = true
opt.splitbelow = true

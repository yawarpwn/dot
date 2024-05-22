return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			highlight = {
				enable = true
			},

			autotag = {
				enable = true
			},

			indent = {
				enable = true
			},

			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"json",
				"javascript",
				"typescript",
				"tsx",
				"html",
				"yaml",
				"css",
				"markdown",
				"markdown-inline",
				"gitignore",
			},
			increment_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>"
				}
			}
		})
	end
}

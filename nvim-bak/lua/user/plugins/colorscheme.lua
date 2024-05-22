return {
	"folke/tokyonight.nvim",
	priority = 1000,
	config = function()
		local bg = '#011628'

		require("tokyonight").setup({
			style = "night",
			transparent = true, -- Enable this to disable setting the background color
			styles = {
				sidebars = "transparent",
				floats = "transparent"
			}

		})
		vim.cmd("colorscheme tokyonight")
	end
}

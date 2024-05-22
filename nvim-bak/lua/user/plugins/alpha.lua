return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- set Header
		dashboard.section.header.val = {
			"			██╗ ██████╗ ██╗  ██╗███╗   ██╗███████╗██╗   ██╗██████╗ ███████╗██████╗",
			"			██║██╔═══██╗██║  ██║████╗  ██║██╔════╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗",
			"			██║██║   ██║███████║██╔██╗ ██║█████╗   ╚████╔╝ ██║  ██║█████╗  ██████╔╝",
			"██   ██║██║   ██║██╔══██║██║╚██╗██║██╔══╝    ╚██╔╝  ██║  ██║██╔══╝  ██╔══██╗",
			"╚█████╔╝╚██████╔╝██║  ██║██║ ╚████║███████╗   ██║   ██████╔╝███████╗██║  ██║",
			" ╚════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝"

		}

		--set Menu
		dashboard.section.buttons.val = {
			dashboard.button("f", " " .. " Find file", "<cmd> Telescope find_files <cr>"),
			dashboard.button("n", " " .. " New file", "<cmd> ene <BAR> startinsert <cr>"),
			dashboard.button("r", " " .. " Recent files", "<cmd> Telescope oldfiles <cr>"),
			dashboard.button("g", " " .. " Find text", "<cmd> Telescope live_grep <cr>"),
			dashboard.button("c", " " .. " Config", "<cmd> lua require('lazyvim.util').telescope.config_files()() <cr>"),
			dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
			dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
		}

		alpha.setup(dashboard.opts)

		--Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end

}

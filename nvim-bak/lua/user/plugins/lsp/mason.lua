return {
	"williamboman/mason.nvim",
	dependencies = {
		-- "williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim"
	},
	config = function()
		local mason = require("mason")
		-- local mason_lspconfig = require("mason-lspconfig").setup()
		local mason_tool_installer = require("mason-tool-installer")

		--enable mason and config icons
		mason.setup({})

		-- mason_lspconfig.setup({
		-- 	ensure_installed = {
		-- 		"lua_ls",
		-- 		"tsserver",
		-- 		"html",
		-- 		"cssls",
		-- 		"tailwindcss",
		-- 		"emmet_ls",
		-- 	}
		-- })

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"eslint_d"
			}
		})
	end
}

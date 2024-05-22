return {
	"neovim/nvim-lspconfig",
	event        = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason-lspconfig.nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim",                   opts = {} }
	},
	config       = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local mason_lspconfig = require("mason-lspconfig")

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				local keymap = vim.keymap
				--set keymaps
				opts.desc = "Show Lsp definition"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "See Available code actions"
				keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart Rename"
				keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

		local handlers = {
			function(server_name) -- default handler (optional)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities
				})
			end,
			-- Next, you can provide targeted overrides for specific servers.
			["rust_analyzer"] = function()
				require("rust-tools").setup {}
			end,
			["lua_ls"] = function()
				local lspconfig = require("lspconfig")
				lspconfig.lua_ls.setup {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" }
							}
						}
					}
				}
			end,
		}

		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"tsserver",
				"html",
				"cssls",
				"tailwindcss",
				"emmet_ls",
			},
			handlers = handlers
		})
	end
}

return {
  -- neodev
  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "dprint",
        "css-lsp",
        "astro-language-server",
        "html-lsp",
      })
    end,
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    -- init = function()
    --   local keys = require("lazyvim.plugins.lsp.keymaps").get()
    --   keys[#keys + 1] = {
    --     "gd",
    --     function()
    --       -- DO NOT RESUSE WINDOW
    --       require("telescope.builtin").lsp_definitions({ reuse_win = false })
    --     end,
    --     desc = "Goto Definition",
    --     has = "definition",
    --   }
    -- end,
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      setup = {
        ---@type lspconfig.options
        servers = {
          -- tsserver will be automatically installed with mason and loaded with lspconfig
          tsserver = {},
        },
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
        setup = {
          -- example to setup with typescript.nvim
          tsserver = function(_, opts)
            require("typescript").setup({ server = opts })
            return true
          end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      },
    },
  },
}

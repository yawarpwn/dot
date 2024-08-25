return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        separator_style = "slope",
      },
    },
  },
  --Wezterm types
  { "justinsgithub/wezterm-types", lazy = true },
  "axkirillov/hbac.nvim",
  opts = {
    threshold = 4,
  },
  -- {
  --   "letieu/wezterm-move.nvim",
  --   keys = { -- Lazy loading, don't need call setup() function
  --     {
  --       "<C-h>",
  --       function()
  --         require("wezterm-move").move("h")
  --       end,
  --     },
  --     {
  --       "<C-j>",
  --       function()
  --         require("wezterm-move").move("j")
  --       end,
  --     },
  --     {
  --       "<C-k>",
  --       function()
  --         require("wezterm-move").move("k")
  --       end,
  --     },
  --     {
  --       "<C-l>",
  --       function()
  --         require("wezterm-move").move("l")
  --       end,
  --     },
  --   },
  -- },
  --
  {
    "numToStr/Navigator.nvim",
    config = function()
      require("Navigator").setup({})
    end,
    keys = {
      -- {'c-h', false}
      { "<A-h>", "<CMD>NavigatorLeft<CR>" },
      { "<A-l>", "<CMD>NavigatorRight<CR>" },
      { "<A-k>", "<CMD>NavigatorUp<CR>" },
      { "<A-j>", "<CMD>NavigatorDown<CR>" },
      { "<A-p>", "<CMD>NavigatorPrevious<CR>" },
    },
  },
}

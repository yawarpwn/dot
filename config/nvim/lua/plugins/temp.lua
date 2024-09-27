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
  --
  -- {
  --   "numToStr/Navigator.nvim",
  --   config = function()
  --     require("Navigator").setup({})
  --   end,
  --   keys = {
  --     -- {'c-h', false}
  --     { "<A-h>", "<CMD>NavigatorLeft<CR>" },
  --     { "<A-l>", "<CMD>NavigatorRight<CR>" },
  --     { "<A-k>", "<CMD>NavigatorUp<CR>" },
  --     { "<A-j>", "<CMD>NavigatorDown<CR>" },
  --     { "<A-p>", "<CMD>NavigatorPrevious<CR>" },
  --   },
  -- },
}

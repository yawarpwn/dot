return {
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<m-2>",
        "<CMD>Oil --float<CR>",
        mode = "n",
        noremap = true,
        silent = true,
        expr = false,
        desc = "Open parent Directory",
      },
    },
  },
}

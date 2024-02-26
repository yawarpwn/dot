return {
  -- {
  --   enabled = false,
  --   "folke/flash.nvim",
  --   ---@type Flash.Config
  --   opts = {
  --     search = {
  --       forward = true,
  --       multi_window = false,
  --       wrap = false,
  --       incremental = true,
  --     },
  --   },
  -- },
  -- {
  --   "echasnovski/mini.surround",
  --   opts = {
  --     mappings = {
  --       add = "sa", -- Add surrounding in Normal and Visual modes
  --       delete = "sd", -- Delete surrounding
  --       find = "sf", -- Find surrounding (to the right)
  --       find_left = "sF", -- Find surrounding (to the left)
  --       highlight = "sh", -- Highlight surrounding
  --       replace = "sr", -- Replace surrounding
  --       update_n_lines = "sn", -- Update `n_lines`
  --     },
  --   },
  -- },
  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = {
      highlighters = {
        hsl_color = {
          pattern = "hsl%(%d+,? %d+,? %d+%)",
          group = function(_, match)
            local utils = require("util.color")
            local h, s, l = match:match("hsl%((%d+),? (%d+),? (%d+)%)")
            h, s, l = tonumber(h), tonumber(s), tonumber(l)
            local hex_color = utils.hslToHex(h, s, l)
            return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
          end,
        },
      },
    },
  },
  {
    "dinhhuy258/git.nvim",
    event = "BufReadPre",
    opts = {
      keymaps = {
        -- Open blame window
        blame = "<Leader>gb",
        -- Open file/folder in git repository
        browse = "<Leader>go",
      },
    },
  },
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

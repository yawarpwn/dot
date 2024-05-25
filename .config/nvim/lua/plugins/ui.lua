return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {
      override_by_filename = {
        ["bun.lockb"] = {
          icon = "󰳮",
          color = "#fbf0df",
          name = "Bun",
        },
      },
      override_by_extension = {
        --  󱓟 
        ["astro"] = {
          icon = "󱓞",
          color = "#FF7E33",
          name = "astro",
        },
      },
    },
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[

     ██╗ ██████╗ ██╗  ██╗███╗   ██╗███████╗██╗   ██╗██████╗ ███████╗██████╗ 
     ██║██╔═══██╗██║  ██║████╗  ██║██╔════╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗
     ██║██║   ██║███████║██╔██╗ ██║█████╗   ╚████╔╝ ██║  ██║█████╗  ██████╔╝
██   ██║██║   ██║██╔══██║██║╚██╗██║██╔══╝    ╚██╔╝  ██║  ██║██╔══╝  ██╔══██╗
╚█████╔╝╚██████╔╝██║  ██║██║ ╚████║███████╗   ██║   ██████╔╝███████╗██║  ██║
 ╚════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },

  "folke/twilight.nvim",
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
}

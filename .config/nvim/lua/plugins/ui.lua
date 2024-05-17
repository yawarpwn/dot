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
}

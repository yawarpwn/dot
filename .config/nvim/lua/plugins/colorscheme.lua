return {
  {
    "tokyonight.nvim",
    priority = 1000,
    opts = function()
      return {
        style = "night",
        -- transparent = true,
        -- styles = {
        --   sidebars = "transparent",
        --   floats = "transparent",
        -- },
        sidebars = {
          "qf",
          "vista_kind",
          -- "terminal",
          "spectre_panel",
          "startuptime",
          "Outline",
        },
      }
    end,
  },
}

return {
  -- { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "typescript",
        "javascript",
        "tsx",
        "html",
        "astro",
        "css",
        "gitignore",
        "graphql",
        "http",
        "sql",
      },
    },
  },
}

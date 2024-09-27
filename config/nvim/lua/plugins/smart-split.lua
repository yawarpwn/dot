return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  build = "./kitty/install-kittens.bash",
  keys = {
    {
      "<C-h>",
      mode = { "n", "v" },
      function()
        require("smart-splits").move_cursor_left()
      end,
      desc = "Move to left window",
    },
    {
      "<C-l>",
      mode = { "n", "v" },
      function()
        require("smart-splits").move_cursor_right()
      end,
      desc = "Move to right window",
    },
    {
      "<C-j>",
      mode = { "n", "v" },
      function()
        require("smart-splits").move_cursor_down()
      end,
      desc = "Move to below window",
    },
    {
      "<C-k>",
      mode = { "n", "v" },
      function()
        require("smart-splits").move_cursor_up()
      end,
      desc = "Move to above window",
    },
  },
}

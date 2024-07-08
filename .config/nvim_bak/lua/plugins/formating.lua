return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      ["markdown"] = { { "prettierd", "prettier" } },
      ["markdown.mdx"] = { { "prettierd", "prettier" } },
      ["css"] = { "prettierd", "prettier" },
      ["javascript"] = { "dprint", "prettierd", "prettier" },
      ["javascriptreact"] = { "dprint", "prettier" },
      ["typescript"] = { "dprint", "prettierd", "prettier" },
      ["typescriptreact"] = { "dprint", "prettier" },
    },
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2", "-ci" },
      },
      dprint = {
        condition = function(ctx)
          return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
        end,
      },
    },
  },
}

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        go = { "gofmt" }
      },
    })

    -- Configure individual formatters
    conform.formatters.prettier = {
      args = {
        "--stdin-filepath",
        "$FILENAME",
        "--tab-width",
        "4",
        "--use-tabs",
        "false",
      },
    }
  end,
}

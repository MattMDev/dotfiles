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
      },
      -- format_on_save = {
      -- 	lsp_fallback = true,
      -- 	async = false,
      -- 	timeout_ms = 1000,
      -- },
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

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,



        async = false,
        timeout_ms = 1000,
      })
    end, { desc = " Prettier Format whole file or range (in visual mode) with" })
  end,
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require("nvim-treesitter.configs")

      -- configure treesitter
      treesitter.setup({       -- enable syntax highlighting
        highlight = {
          enable = true,
        },
        -- enable indentation
        indent = { enable = true },

        -- ensure these languages parsers are installed
        ensure_installed = {
          "json",
          "go",
          "yaml",
          "html",
          "css",
          "python",
          "http",
          "markdown",
          "markdown_inline",
          "bash",
          "lua",
          "dockerfile",
          "gitignore",
          "vim",
          "vimdoc",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
          },
        },
        additional_vim_regex_highlighting = false,
        sync_install = false,
        ignore_install = {},
        auto_install = true,
      })
    end,
  },
}

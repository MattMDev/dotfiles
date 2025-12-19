return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        PATH = "prepend",
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- language servers
             "lua_ls",
                    "gopls",
                    "rust-analyzer",
                    "bashls",
                    "pyright",
                    "cssls",
                    "html",
                    "jsonls",
                    "yamlls",

                    -- Linters
                    "luacheck",
                    "golangci-lint",
                    "shellcheck",
                    "markdownlint",
                    "yamllint",
                    "jsonlint",
                    "htmlhint",
                    "ruff",

                    -- Formatters
                    "stylua",
                    "goimports",
                    "prettier",
                    "black",
                    "isort",
                    "shfmt",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { 'saghen/blink.cmp' },

    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lspconfig = require('lspconfig')

      lspconfig['lua_ls'].setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" }, -- Recognize 'vim' as a global variable
                },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true), -- Include Neovim runtime files
                },
                telemetry = {
                  enable = false,
                },
              },
            },
          })
   end
  }
}
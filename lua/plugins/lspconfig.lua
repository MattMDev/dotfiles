return {
  {
    "williamboman/mason.nvim",
  },
  {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        lazy = false,
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    -- Language Servers
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
                    "stylelint",
                    "ruff",
                    "mypy",

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
    dependencies = { 'saghen/blink.cmp' },

    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      
      vim.lsp.config('*', {
        capabilities = capabilities
      })

      vim.lsp.config('lua_ls', {
          cmd = {lua-language-server},
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

          vim.lsp.enable('*')
   end
  }
}
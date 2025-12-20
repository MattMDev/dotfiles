return {
{
    "mason-org/mason-lspconfig.nvim",
    opts = {
      -- list of servers for mason to install
      ensure_installed = {
        "lua_ls",
        "gopls",
        "bashls",
        "pyright",
        "cssls",
        "html",
        "jsonls",
        "yamlls",
      },
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
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
}

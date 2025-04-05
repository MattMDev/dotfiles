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
          "lua_ls",
        },
      })
    end,
  },
  {

    "hrsh7th/cmp-nvim-lsp",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        -- cmd = { "lua_ls" },
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
    end,
  },
}

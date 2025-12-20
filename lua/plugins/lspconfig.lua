return {
  {
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      
      vim.lsp.config('*', {
        capabilities = capabilities
      })

      vim.lsp.config('lua_ls', {
          cmd = {'lua-language-server'},
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
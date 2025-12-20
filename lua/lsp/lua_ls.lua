return {
local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config('lua_ls', {
    cmd = {'lua-language-server'},
    filetypes = {'lua'},
    capabilities = capabilities,
    settings = {
               Lua = {
                  workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true) },
                  telemetry = { enable = false },
                  diagnostics = {
                     globals = { "vim" },
                  },
               },
            },
    })
}
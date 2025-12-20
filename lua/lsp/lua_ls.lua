return {
local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config('lua_ls', {
    cmd = {'lua-language-server'},
    filetypes = {'lua'},
    capabilities = capabilities,
    })
}
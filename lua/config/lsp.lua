-- ============================================================================
-- LSP Keymaps Setup
-- ============================================================================
local function setup_keymaps(bufnr)
    local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP: " .. desc, silent = true })
    end

    -- Information
    map("n", "K", function()
        vim.lsp.buf.hover({
            border = "rounded", -- Sets a single line border for hover
            max_height = 25,   -- Sets a maximum height
            max_width = 120    -- Sets a maximum width
        })
    end, "Hover documentation")

    map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
    map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

    -- Diagnostics
    map("n", "<leader>cl", vim.diagnostic.setloclist, "Diagnostics to loclist")

    -- Inlay hints toggle (useful for manual control)
    if vim.lsp.inlay_hint then
        map("n", "<leader>ih", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
        end, "Toggle inlay hints")
    end
end

-- ============================================================================
-- LSP Attach Handler
-- ============================================================================
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if not client then return end

        -- Setup keymaps for this buffer
        setup_keymaps(bufnr)

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Enable inlay hints if supported (Neovim 0.10+)
        if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        -- Document highlight on cursor hold
        -- if client.server_capabilities.documentHighlightProvider then
        --     local highlight_group = vim.api.nvim_create_augroup("LspDocumentHighlight_" .. bufnr,
        --         { clear = true })
        --     vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        --         buffer = bufnr,
        --         group = highlight_group,
        --         callback = vim.lsp.buf.document_highlight,
        --     })
        --     vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        --         buffer = bufnr,
        --         group = highlight_group,
        --         callback = vim.lsp.buf.clear_references,
        --     })
        -- end
    end,
})

-- ============================================================================
-- Diagnostic Configuration
-- ============================================================================
vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})


-- Enable LSPs
vim.lsp.enable('lua_ls')
local api = vim.api

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Enable spell checking for certain file types
api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    {
        pattern = { "*.txt", "*.md", "*.tex" },
        callback = function()
            vim.opt.spell = true
            vim.opt.spelllang = "en"
        end,
    }
)

-- fix terraform and hcl comment string
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
    callback = function(ev)
        vim.bo[ev.buf].commentstring = "# %s"
    end,
    pattern = { "terraform", "hcl" },
})
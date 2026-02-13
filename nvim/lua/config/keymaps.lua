-- Move selected line / block of text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Yanking to clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = "Yank to system clipboard" })

-- delete and don't push to register
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = "Delete without copying" })

-- paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dp')
vim.keymap.set("v", "P", '"_dP')

-- Move to start/end of line
-- vim.keymap.set({ "n", "x", "o" }, "H", "^", opts)
-- vim.keymap.set({ "n", "x", "o" }, "L", "g_", opts)


-- Panes resizing
vim.keymap.set("n", "+", ":vertical resize +5<CR>")
vim.keymap.set("n", "_", ":vertical resize -5<CR>")
vim.keymap.set("n", "=", ":resize +5<CR>")
vim.keymap.set("n", "-", ":resize -5<CR>")

-- Center Cursor
vim.keymap.set("n", "n", "nzz", opts)
vim.keymap.set("n", "N", "Nzz", opts)
vim.keymap.set("n", "*", "*zz", opts)
vim.keymap.set("n", "#", "#zz", opts)
vim.keymap.set("n", "g*", "g*zz", opts)
vim.keymap.set("n", "g#", "g#zz", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

vim.keymap.set("n", "<C-c>", ":nohlsearch<CR>", opts)

-- TODO - Diff
-- Navigate in quickfix
vim.keymap.set("n", "<M-k>", ":cnext", opts)
vim.keymap.set("n", "<M-j>", ":cprevious", opts)

return {
    {
  'stevearc/oil.nvim',
  opts = {
    view_options = {
    -- Show files and directories that start with "."
    show_hidden = true,
  },
  },
  -- Optional dependencies
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,

  -- Open parent directory in current window
  vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
}
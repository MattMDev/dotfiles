return {
	{
		"stevearc/oil.nvim",
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		config = function()
			local oil = require("oil")
			oil.setup({
				view_options = {
					-- Show files and directories that start with "."
					show_hidden = true,
				},
			})

			vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>")
		end,
		lazy = false,
	},
}


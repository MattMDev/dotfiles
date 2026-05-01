return {
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup({
                attach_to_untracked = true,
                current_line_blame = false,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol",
                    delay = 1000,
                    ignore_whitespace = false,
                },
                current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
                update_debounce = 200,
                max_file_length = 40000,
                preview_config = {
                    border = "rounded",
                    style = "minimal",
                    relative = "cursor",
                    row = 0,
                    col = 1,
                },
                on_attach = function(bufnr)
                    local gs = require("gitsigns")
                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                    end
                    -- Navigation
                    map("n", "]h", gs.next_hunk, "Next Hunk")
                    map("n", "[h", gs.prev_hunk, "Prev Hunk")
                end,
            })
        end,
        keys = {
            -- Hunk operations under <leader>gh (git hunk)
            { "<leader>hp", function() require("gitsigns").preview_hunk() end, desc = "Preview Hunk" },
            { "<leader>hP", function() require("gitsigns").preview_hunk_inline() end, desc = "Preview Hunk Inline" },
            { "<leader>hs", function() require("gitsigns").stage_hunk() end, desc = "Stage Hunk" },
            { "<leader>hu", function() require("gitsigns").undo_stage_hunk() end, desc = "Undo Stage Hunk" },
            { "<leader>hr", function() require("gitsigns").reset_hunk() end, desc = "Reset Hunk" },
            -- -- Buffer operations
            -- { "<leader>hR", function() require("gitsigns").reset_buffer() end, desc = "Reset Buffer" },
            -- { "<leader>gS", function() require("gitsigns").stage_buffer() end, desc = "Stage Buffer" },
            -- Blame
            { "<leader>tb", function() require("gitsigns").blame_line() end, desc = "Blame Line" },
            { "<leader>tB", function() require("gitsigns").blame() end, desc = "Blame Buffer" },
            -- -- Diff
            -- { "<leader>gD", function() vim.cmd("Gitsigns diffthis HEAD") end, desc = "Diff HEAD" },
        },
    },
    {
        "sindrets/diffview.nvim",
        event = "VeryLazy",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    }
}

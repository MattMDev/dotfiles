-- Coding: Completion, treesitter, and dev tools
return {
  -- ════════════════════════════════════════════════════════════════════════════
  -- Completion (blink.cmp)
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "saghen/blink.cmp",
    version = "*",
    config = function()
      require("blink.cmp").setup({
        snippets = { preset = "default" },
        signature = { enabled = true },
        appearance = {
          use_nvim_cmp_as_default = false,
          nerd_font_variant = "normal",
        },
        sources = {
          default = { "lsp", "path", "buffer", "snippets" },
          providers = {
            cmdline = {
              min_keyword_length = 2,
            },
          },
        },
        cmdline = {
          enabled = true,
          completion = { menu = { auto_show = true } },
          keymap = {
            ["<CR>"] = { "accept_and_enter", "fallback" },
          },
        },
        completion = {
          menu = {
            border = "rounded",
            scrolloff = 1,
            scrollbar = false,
            draw = {
              padding = 1,
              gap = 1,
              columns = {
                { "kind_icon" },
                { "label", "label_description", gap = 1 },
                { "kind" },
                { "source_name" },
              },
            },
          },
          documentation = {
            window = {
              border = "rounded",
              scrollbar = false,
              winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
            },
            auto_show = true,
            auto_show_delay_ms = 500,
          },
        },
      })
    end,
  },

  -- ════════════════════════════════════════════════════════════════════════════
  -- Treesitter
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local parsers = {
        "bash", "c", "css", "go", "gomod", "gosum", "gowork",
        "html", "javascript", "json", "lua", "luadoc", "luap",
        "markdown", "markdown_inline", "proto", "python",
        "regex", "rust", "scss", "terraform",
        "tsx", "typescript", "vim", "vimdoc", "yaml",
      }
      require("nvim-treesitter").install(parsers)

      -- Enable treesitter-based highlighting and indentation per-buffer
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  -- ════════════════════════════════════════════════════════════════════════════
  -- Comments
  -- ════════════════════════════════════════════════════════════════════════════
  {
    "numToStr/Comment.nvim",
    opts = {},
    lazy = false,
  }
}

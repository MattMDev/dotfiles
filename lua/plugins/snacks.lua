return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = {enabled = true },
      explorer = {
        enabled = false,
      },
      quickfile = {
        enabled = true,
        exclude = { "latex" },
      },
      indent = { enabled = true},
      picker = {
        hidden = true,
        enabled = true,
        grep = {
          hidden = true,
        },
        files = {
          hidden = true,
        },
        layout = {
          -- presets options : "default" , "ivy" , "ivy-split" , "telescope" , "vscode", "select" , "sidebar"
          -- override picker layout in keymaps function as a param below
          preset = "telescope", -- defaults to this layout unless overidden
          cycle = false,
        },
      },
    },
    keys = {
      -- Snacks Picker
      { "<leader><leader>",  function() require("snacks").picker.files() end,                                   desc = "Find Files (Snacks Picker)" },
      { "<leader>fr",  function() require("snacks").picker.recent() end, desc = "Find Config File" },
      { "<leader>fs",  function() require("snacks").picker.grep() end,                                    desc = "Grep word" },
      { "<leader>fw",  function() require("snacks").picker.grep_word() end,                               desc = "Search Visual selection or Word",  mode = { "n", "x" } },
      { "<leader>fk",  function() require("snacks").picker.keymaps({ layout = "ivy" }) end,               desc = "Search Keymaps (Snacks Picker)" },

      -- Git Stuff

      { "<leader>gb", function() require("snacks").picker.gitbrowse() end,       desc = "Pick and Switch Git Branches", mode = {"n", "v"} },

      -- Other Utils
      { "<leader>th",  function() require("snacks").picker.colorschemes({ layout = "ivy" }) end,          desc = "Pick Color Schemes" },
      { "<leader>vh",  function() require("snacks").picker.help() end,                                    desc = "Help Pages" },
    }
  }
}

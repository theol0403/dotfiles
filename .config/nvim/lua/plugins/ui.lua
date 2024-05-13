return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  -- {
  --   "loctvl842/monokai-pro.nvim",
  --   lazy = false,
  --   branch = "master",
  --   priority = 1000,
  --   config = function()
  --     local monokai = require("monokai-pro")
  --     monokai.setup({
  --       transparent_background = false,
  --       devicons = true,
  --       filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
  --       inc_search = "background", -- underline | background
  --       background_clear = {},
  --       plugins = {
  --         bufferline = {
  --           underline_selected = true,
  --           underline_visible = true,
  --           bold = false,
  --         },
  --         indent_blankline = {
  --           context_highlight = "pro", -- default | pro
  --           context_start_underline = true,
  --         },
  --       },
  --       override = function(c)
  --         return {
  --           colorcolumn = { bg = c.base.dimmed3 },
  --           dashboardrecent = { fg = c.base.magenta },
  --           dashboardproject = { fg = c.base.blue },
  --           dashboardconfiguration = { fg = c.base.white },
  --           dashboardsession = { fg = c.base.green },
  --           dashboardlazy = { fg = c.base.cyan },
  --           dashboardserver = { fg = c.base.yellow },
  --           dashboardquit = { fg = c.base.red },
  --         }
  --       end,
  --     })
  --     monokai.load()
  --   end,
  -- },

  {
    "tummetott/reticle.nvim",
    config = true,
    init = function()
      vim.wo.cursorline = true
      vim.wo.cursorcolumn = false
    end,
  },
  { "winston0410/cmd-parser.nvim", vscode = true },
  { "winston0410/range-highlight.nvim", config = true, vscode = true },
  -- { "myusuf3/numbers.vim", vscode = true },

  "wakatime/vim-wakatime",

  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    opts = {
      set_highlights = false,
      excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
        "noice",
        "neo-tree",
        "dashboard",
        "alpha",
        "lazy",
        "mason",
        "DressingInput",
        "",
      },
      handlers = {
        gitsigns = true,
      },
    },
  },

  {
    "folke/which-key.nvim",
    opts = {
      plugins = {
        registers = false,
      },
    },
  },

  -- fix surround-nvim
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "echomsg",
            find = "No textobject",
          },
          opts = { skip = true },
        },
      },
    },
  },
}

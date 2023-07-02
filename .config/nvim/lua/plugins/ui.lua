local plugins = {
  -- custom UI
  either({
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    branch = "master",
    priority = 1000,
    config = function()
      local monokai = require("monokai-pro")
      monokai.setup({
        transparent_background = false,
        devicons = true,
        filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
        inc_search = "background", -- underline | background
        background_clear = {},
        plugins = {
          bufferline = {
            underline_selected = true,
            underline_visible = true,
            bold = false,
          },
          indent_blankline = {
            context_highlight = "pro", -- default | pro
            context_start_underline = true,
          },
        },
        override = function(c)
          return {
            colorcolumn = { bg = c.base.dimmed3 },
            dashboardrecent = { fg = c.base.magenta },
            dashboardproject = { fg = c.base.blue },
            dashboardconfiguration = { fg = c.base.white },
            dashboardsession = { fg = c.base.green },
            dashboardlazy = { fg = c.base.cyan },
            dashboardserver = { fg = c.base.yellow },
            dashboardquit = { fg = c.base.red },
          }
        end,
      })
      monokai.load()
    end,
  }),

  {
    "tummetott/reticle.nvim",
    config = true,
    init = function()
      vim.wo.cursorline = true
      vim.wo.cursorcolumn = false
    end,
  },
  either("winston0410/cmd-parser.nvim"),
  either({ "winston0410/range-highlight.nvim", config = true }),
  either({
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      either("nvim-treesitter/nvim-treesitter-textobjects"),
    },
    opts = {
      highlight = {
        enable = is_nvim(),
      },
    },
  }),
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

  -- distro-provided UI
  -- { import = "nvpunk.plugins.interface.whichkey" },
  -- -- { import = "nvpunk.plugins.interface.ufo" },
  -- { import = "nvpunk.plugins.interface.navic" },
  -- { import = "nvpunk.plugins.interface.highlight_colors" },
  -- { import = "nvpunk.plugins.interface.gitsigns" },
  -- { import = "nvpunk.plugins.interface.bufferline" },
  -- { import = "nvpunk.plugins.tools.toggleterm" },
  -- { import = "nvpunk.plugins.interface.bqf" },
  { import = "lazyvim.plugins.ui" },
  is_nvim() and { import = "lazyvim.plugins.treesitter" } or nil,
  -- { import = "tvl.core.resources.tools" },

  {
    "rcarriga/nvim-notify",
    keys = function(_, keys)
      return {
        { "<leader>un", desc = " Notifications" },
        {
          "<leader>und",
          function()
            require("notify").dismiss()
          end,
          desc = "Dismiss Notifications",
        },
        {
          "<leader>unl",
          function()
            require("telescope").extensions.notify.notify()
          end,
          desc = "List Notifications",
        },
      }
    end,
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

return plugins

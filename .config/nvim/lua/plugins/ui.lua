local plugins = {
  nvim({
    "https://gitlab.com/theol0403/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      g.monokaipro_transparent = false
      cmd([[colorscheme monokaipro]])
    end,
  }),

  nvim({
    "tummetott/reticle.nvim",
    config = true,
    init = function()
      vim.wo.cursorline = true
      vim.wo.cursorcolumn = true
    end,
  }),
  "winston0410/cmd-parser.nvim",
  { "winston0410/range-highlight.nvim", config = true },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      highlight = {
        enable = is_nvim(),
      },
    },
  },
  nvim({
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
  }),
  nvim("wakatime/vim-wakatime"),
}

local lazy = require("lazyvim.plugins.ui")
for i, plugin in ipairs(lazy) do
  table.insert(plugins, { plugin[1] or plugin, cond = is_nvim })
end

return plugins

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

  nvim("inkarkat/vim-CursorLineCurrentWindow"),
  "winston0410/cmd-parser.nvim",
  { "winston0410/range-highlight.nvim", config = true },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["aC"] = "@class.outer",
            ["iC"] = "@class.inner",
          },
        },
      },
      highlight = {
        enable = is_nvim(),
      },
    },
  },
  nvim("wakatime/vim-wakatime"),
}

local lazy = require("lazyvim.plugins.ui")
for i, plugin in ipairs(lazy) do
  table.insert(plugins, { plugin[1] or plugin, cond = is_nvim })
end

local lazy = require("lazyvim.plugins.lsp.init")
for i, plugin in ipairs(lazy) do
  table.insert(plugins, { plugin[1] or plugin, cond = is_nvim })
end

return plugins

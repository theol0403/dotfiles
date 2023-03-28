local plugins = {

  -- custom editor
  either({
    "echasnovski/mini.nvim",
    config = function()
      require("mini.move").setup()
      -- require("mini.basics").setup()
      if is_nvim() then
        -- require('mini.indentscope').setup{draw = {animation = require('mini.indentscope').gen_animation.none() }}
      end
    end,
  }),

  -- editor utilities
  either("tommcdo/vim-lion"),
  either("tpope/vim-unimpaired"),
  either({
    "monaqa/dial.nvim",
    keys = {
      {
        mode = "n",
        "<C-a>",
        function()
          require("dial.map").inc_normal()
        end,
      },
      {
        mode = "n",
        "<C-x>",
        function()
          require("dial.map").dec_normal()
        end,
      },
      {
        mode = "v",
        "<C-a>",
        function()
          require("dial.map").inc_visual()
        end,
      },
      {
        mode = "v",
        "<C-x>",
        function()
          require("dial.map").dec_visual()
        end,
      },
      {
        mode = "v",
        "g<C-a>",
        function()
          require("dial.map").inc_gvisual()
        end,
      },
      {
        mode = "v",
        "g<C-x>",
        function()
          require("dial.map").dec_gvisual()
        end,
      },
    },
  }),

  -- distro-provided editor
  { import = "lazyvim.plugins.editor" },
  { import = "tvl.core.resources.editor" },

  -- motion
  either({
    "ggandor/leap.nvim",
    dependencies = { "ggandor/leap-spooky.nvim" },
  }),
  either("ggandor/flit.nvim"),
}

return plugins

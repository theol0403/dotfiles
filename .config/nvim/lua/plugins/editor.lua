local plugins = {

  -- extra setup
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.move").setup()
      require("mini.basics").setup()
      if is_nvim() then
        -- require('mini.indentscope').setup{draw = {animation = require('mini.indentscope').gen_animation.none() }}
      end
    end,
  },

  -- motion
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").set_default_keymaps()
    end,
    keys = {
      {
        "s",
        function()
          require("leap").leap({ target_windows = { vim.fn.win_getid() } })
        end,
      },
    },
    dependencies = {
      "ggandor/leap-spooky.nvim",
      { "ggandor/flit.nvim", opts = { labeled_modes = "nv" } },
    },
  },

  --  exchange/replace
  {
    "gbprod/substitute.nvim",
    opts = {
      on_substitute = function(event)
        require("yanky").init_ring("p", event.register, event.count, event.vmode:match("[vV�]"))
      end,
    },
    keys = {
      { "gr", "<cmd>lua require('substitute').operator()<cr>" },
      { "grr", "<cmd>lua require('substitute').line()<cr>" },
      { "gR", "<cmd>lua require('substitute').eol()<cr>" },
      { "gr", "<cmd>lua require('substitute').visual()<cr>", mode = "x" },
      { "cx", "<cmd>lua require('substitute.exchange').operator()<cr>" },
      { "cxx", "<cmd>lua require('substitute.exchange').line()<cr>" },
      { "X", "<cmd>lua require('substitute.exchange').visual()<cr>", mode = "x" },
      { "cxc", "<cmd>lua require('substitute.exchange').cancel()<cr>" },
    },
    dependencies = {
      {
        "gbprod/yanky.nvim",
        opts = {
          system_clipboard = {
            sync_with_ring = false,
          },
        },
        keys = {
          { mode = { "n", "x" }, "p", "<Plug>(YankyPutAfter)" },
          { mode = { "n", "x" }, "P", "<Plug>(YankyPutBefore)" },
          { mode = { "n", "x" }, "gp", "<Plug>(YankyGPutAfter)" },
          { mode = { "n", "x" }, "gP", "<Plug>(YankyGPutBefore)" },
          { mode = "n", "<c-n>", "<Plug>(YankyCycleForward)" },
          { mode = "n", "<c-p>", "<Plug>(YankyCycleBackward)" },
        },
      },
    },
  },

  -- editor utilities
  "tommcdo/vim-lion",
  "tpope/vim-unimpaired",
  {
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
  },

  -- disable lazyvim
  nvim("nvim-neo-tree/neo-tree.nvim"),
  nvim("nvim-telescope/telescope.nvim"),
  nvim("folke/which-key.nvim"),
  nvim("lewis6991/gitsigns.nvim"),
  nvim("folke/trouble.nvim"),
  nvim("folke/todo-comments.nvim"),
}

return plugins

return {

  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.move").setup()
    end,
    vscode = true,
  },
  { "tommcdo/vim-lion", vscode = true },
  { "tpope/vim-unimpaired", vscode = true },
  -- stylua: ignore start
  {
    "monaqa/dial.nvim",
    keys = {
      { mode = "n", "<C-a>", function() require("dial.map").inc_normal() end, },
      { mode = "n", "<C-x>", function() require("dial.map").dec_normal() end, },
      { mode = "v", "<C-a>", function() require("dial.map").inc_visual() end, },
      { mode = "v", "<C-x>", function() require("dial.map").dec_visual() end, },
      { mode = "v", "g<C-a>", function() require("dial.map").inc_gvisual() end, },
      { mode = "v", "g<C-x>", function() require("dial.map").dec_gvisual() end, },
    },
    vscode = true,
  },
  -- stylua: ignore end

  { "max397574/better-escape.nvim", opts = { mapping = { "jk", "kj" } }, vscode = true },

  -- {
  --   "folke/flash.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     jump = {
  --       autojump = true,
  --       highlight = {
  --         label = {
  --           current = false,
  --         },
  --       },
  --     },
  --     modes = {
  --       char = {
  --         highlight = { backdrop = false },
  --       },
  --     },
  --   },
  --   keys = {
  --     {
  --       "s",
  --       mode = { "n", "x", "o" },
  --       function()
  --         -- default options: exact mode, multi window, all directions, with a backdrop
  --         require("flash").jump()
  --       end,
  --     },
  --     {
  --       "S",
  --       mode = { "o", "x" },
  --       function()
  --         require("flash").treesitter()
  --       end,
  --     },
  --     {
  --       "r",
  --       mode = "o",
  --       function()
  --         require("flash").remote()
  --       end,
  --       desc = "Remote Flash",
  --     },
  --   },
  --   vscode = true,
  -- },
}

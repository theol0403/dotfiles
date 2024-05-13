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
  {
    "monaqa/dial.nvim",
    -- stylua: ignore start
    keys = {
      { mode = "n", "<C-a>", function() require("dial.map").inc_normal() end, },
      { mode = "n", "<C-x>", function() require("dial.map").dec_normal() end, },
      { mode = "v", "<C-a>", function() require("dial.map").inc_visual() end, },
      { mode = "v", "<C-x>", function() require("dial.map").dec_visual() end, },
      { mode = "v", "g<C-a>", function() require("dial.map").inc_gvisual() end, },
      { mode = "v", "g<C-x>", function() require("dial.map").dec_gvisual() end, },
    },
    -- stylua: ignore end
    vscode = true,
  },

  { "max397574/better-escape.nvim", opts = { mapping = { "jk", "kj" } }, vscode = true },

  { "toppair/reach.nvim", vscode = true, opts = { notifications = true } },

  {
    "vscode-neovim/vscode-multi-cursor.nvim",
    event = "VeryLazy",
    cond = not not vim.g.vscode,
    vscode = true,
    keys = {
      {
        mode = { "n", "x", "i" },
        "<C-S-l>",
        function()
          require("vscode-multi-cursor").selectHighlights()
        end,
      },
    },
  },
}

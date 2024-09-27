return {
  { "tommcdo/vim-lion", vscode = true },
  { "tpope/vim-unimpaired", vscode = true },
  { "max397574/better-escape.nvim", opts = {}, vscode = true },
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
  -- {
  --   "folke/flash.nvim",
  --   ---@type Flash.Config
  --   opts = { highlight = { backdrop = false } },
  -- },
  {
    "ggandor/leap.nvim",
    enabled = true,
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      -- vim.keymap.del({ "x", "o" }, "x")
      -- vim.keymap.del({ "x", "o" }, "X")
      vim.keymap.set("n", "s", function()
        require("leap").leap({ target_windows = { vim.api.nvim_get_current_win() } })
      end)
    end,
  },
}

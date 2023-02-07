return {

  -- surround
  { "kylechui/nvim-surround", config = true },

  -- better text-objects
  "PeterRincker/vim-argumentative", -- <, shift argument, [, move argument, , - argument

  {
    "kana/vim-textobj-user",
    dependencies = {
      "kana/vim-textobj-entire", -- e - entire
      "kana/vim-textobj-line", -- l - line
      "Julian/vim-textobj-variable-segment", -- v - segment
      "kana/vim-textobj-indent", -- i - indent block, I - same indent (wont select sub indent)
      -- 'pianohacker/vim-textobj-indented-paragraph' -- r - paragraph that won',t go less indent
      -- 'tkhren/vim-textobj-numeral', -- n - number (do you want gn - jump to number)
      "MRAAGH/vim-textobj-chunk", -- lines that contain {},(),[] block. Use to select functions.
    },
  },

  -- snippets
  nvim({
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  }),

  -- lazyvim
  nvim("hrsh7th/nvim-cmp"),
  nvim("echasnovski/mini.pairs"),

  { "echasnovski/mini.surround", enabled = false },
}

local plugins = {

  -- surround
  { "kylechui/nvim-surround", config = true },
  { "echasnovski/mini.surround", enabled = false },

  -- textobjects
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

  -- disable lazy
  nvim("L3MON4D3/LuaSnip"),
  nvim("hrsh7th/nvim-cmp"),
  nvim("echasnovski/mini.pairs"),
}

return plugins

return {
  -- surround
  either({ "kylechui/nvim-surround", config = true }),

  --  exchange/replace
  either({
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
      either({
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
      }),
    },
  }),

  -- better text-objects
  either("PeterRincker/vim-argumentative"), -- <, shift argument, [, move argument, , - argument
  either({
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
  }),

  -- distro-provided coding
  { import = "lazyvim.plugins.coding" },
  either("JoosepAlviste/nvim-ts-context-commentstring"),
  either("echasnovski/mini.comment"),
  { "echasnovski/mini.surround", enabled = false },

  either({
    "echasnovski/mini.ai",
    config = function()
      if not is_nvim() then
        return function(_, opts)
          require("mini.ai").setup(opts)
        end
      else
        return nil
      end
    end,
  }),
}

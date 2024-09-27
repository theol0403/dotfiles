return {
  -- surround
  { "kylechui/nvim-surround", config = true, vscode = true },
  -- fix surround-nvim
  {
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
  },

  --  exchange/replace
  {
    "gbprod/substitute.nvim",
    opts = {},
    -- stylua: ignore start
    keys = {
      { "gr", function() require('substitute').operator() end },
      { "grr", function() require('substitute').line() end },
      { "gR", function() require('substitute').eol() end },
      { "gr", function() require('substitute').visual() end, mode = "x" },
      { "cx", function() require('substitute.exchange').operator() end },
      { "cxx", function() require('substitute.exchange').line() end },
      { "X", function() require('substitute.exchange').visual() end, mode = "x" },
      { "cxc", function() require('substitute.exchange').cancel() end },
    },
    -- stylua: ignore end
    vscode = true,
  },

  -- better text-objects
  { "PeterRincker/vim-argumentative", vscode = true }, -- <, shift argument, [, move argument, , - argument
  {
    "kana/vim-textobj-user",
    dependencies = {
      { "kana/vim-textobj-entire", vscode = true }, -- e - entire
      { "kana/vim-textobj-line", vscode = true }, -- l - line
      { "Julian/vim-textobj-variable-segment", vscode = true }, -- v - segment
      { "kana/vim-textobj-indent", vscode = true }, -- i - indent block, I - same indent (wont select sub indent, vscode = true}
      { "pianohacker/vim-textobj-indented-paragraph", vscode = true }, -- r - paragraph that won',t go less indent
      -- 'tkhren/vim-textobj-numeral', -- n - number (do you want gn - jump to number)
      { "MRAAGH/vim-textobj-chunk", vscode = true }, -- lines that contain {},(, vscode = true},[] block. Use to select functions.
    },
    vscode = true,
  },

  -- -- Use <tab> for completion and snippets (supertab)
  -- {
  --   "hrsh7th/nvim-cmp",
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local has_words_before = function()
  --       unpack = unpack or table.unpack
  --       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  --     end
  --
  --     local cmp = require("cmp")
  --
  --     opts.mapping = vim.tbl_extend("force", opts.mapping, {
  --       ["<Tab>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
  --           cmp.select_next_item()
  --         elseif vim.snippet.active({ direction = 1 }) then
  --           vim.schedule(function()
  --             vim.snippet.jump(1)
  --           end)
  --         elseif has_words_before() then
  --           cmp.complete()
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --       ["<S-Tab>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           cmp.select_prev_item()
  --         elseif vim.snippet.active({ direction = -1 }) then
  --           vim.schedule(function()
  --             vim.snippet.jump(-1)
  --           end)
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --     })
  --   end,
  -- },
}

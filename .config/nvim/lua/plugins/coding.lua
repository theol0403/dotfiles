return {
  -- surround
  { "kylechui/nvim-surround", config = true, vscode = true },

  --  exchange/replace
  {
    "gbprod/substitute.nvim",
    opts = {
      on_substitute = function(event)
        require("yanky").init_ring("p", event.register, event.count, event.vmode:match("[vV�]"))
      end,
    },
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
    dependencies = {
      {
        "gbprod/yanky.nvim",
        opts = {
          system_clipboard = {
            sync_with_ring = false,
          },
        },
        vscode = true,
      },
    },
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
      -- 'pianohacker/vim-textobj-indented-paragraph' -- r - paragraph that won',t go less indent
      -- 'tkhren/vim-textobj-numeral', -- n - number (do you want gn - jump to number)
      { "MRAAGH/vim-textobj-chunk", vscode = true }, -- lines that contain {},(, vscode = true},[] block. Use to select functions.
    },
    vscode = true,
  },

  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  -- {
  --   "L3MON4D3/LuaSnip",
  --   keys = function()
  --     return {}
  --   end,
  -- },
  -- then: setup supertab in cmp
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     "hrsh7th/cmp-emoji",
  --   },
  --   ---@param opts cmp.ConfigSchema
  --   opts = function(_, opts)
  --     local has_words_before = function()
  --       unpack = unpack or table.unpack
  --       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  --       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  --     end
  --
  --     local luasnip = require("luasnip")
  --     local cmp = require("cmp")
  --
  --     opts.preselect = cmp.PreselectMode.None
  --     opts.completion = {
  --       completeopt = "menu,menuone,noinsert,noselect",
  --     }
  --
  --     opts.mapping = vim.tbl_extend("force", opts.mapping, {
  --       ["<Tab>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           cmp.select_next_item()
  --           -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
  --           -- this way you will only jump inside the snippet region
  --         elseif luasnip.expand_or_jumpable() then
  --           luasnip.expand_or_jump()
  --         elseif has_words_before() then
  --           cmp.complete()
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --       ["<S-Tab>"] = cmp.mapping(function(fallback)
  --         if cmp.visible() then
  --           cmp.select_prev_item()
  --         elseif luasnip.jumpable(-1) then
  --           luasnip.jump(-1)
  --         else
  --           fallback()
  --         end
  --       end, { "i", "s" }),
  --       ["<CR>"] = cmp.mapping(function(fallback)
  --         fallback()
  --       end),
  --       -- ["<CR>"] = cmp.mapping({
  --       --   i = function(fallback)
  --       --     if cmp.visible() and cmp.get_active_entry() then
  --       --       cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
  --       --     else
  --       --       fallback()
  --       --     end
  --       --   end,
  --       --   s = cmp.mapping.confirm({ select = true }),
  --       --   c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
  --       -- }),
  --       -- ["<C-Space>"] = cmp.mapping.confirm({
  --       --   -- TODO remove this C-Space block after TAB completion works how I want
  --       --   -- behavior = cmp.ConfirmBehavior.Replace,
  --       --   select = false,
  --       -- }),
  --     })
  --   end,
  -- },
}

-- helper aliases
cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
g = vim.g      -- a table to access global variables
opt = vim.opt  -- to set options

-- set up vscode-neovim helpers
is_vscode = function() return vim.g.vscode == 1 end
firenvim = function() return vim.g.started_by_firenvim == 1 end
is_nvim = function() return (not is_vscode()) and (not firenvim()) end

-- simplify syntax for plugins incompatible with vscode-neovim
nvim_only = function(plugin) 
  if type(plugin) == 'string' then plugin = {plugin} end
  plugin = vim.tbl_extend('keep', plugin, {cond=is_nvim})
  return plugin
end
nvim = nvim_only

local plugins = {

  -- ------------------------------- essentials ----------------------------------
  'tpope/vim-repeat', 
  'tpope/vim-commentary',              -- gc{motion} gcc gcgc dgc
  'tpope/vim-unimpaired',              -- [space [e
  'tommcdo/vim-lion', 
  'AndrewRadev/splitjoin.vim', 
  'kylechui/nvim-surround',

  {'gbprod/substitute.nvim', opts = {
    on_substitute = function(event)
      require("yanky").init_ring("p", event.register, event.count, event.vmode:match("[vV�]"))
    end},
    keys ={
      { "gr", "<cmd>lua require('substitute').operator()<cr>" },
      { "grr", "<cmd>lua require('substitute').line()<cr>" },
      { "gR", "<cmd>lua require('substitute').eol()<cr>" },
      { "gr", "<cmd>lua require('substitute').visual()<cr>", mode = 'x' },
      { "cx", "<cmd>lua require('substitute.exchange').operator()<cr>" },
      { "cxx", "<cmd>lua require('substitute.exchange').line()<cr>" },
      { "X", "<cmd>lua require('substitute.exchange').visual()<cr>", mode = 'x' },
      { "cxc", "<cmd>lua require('substitute.exchange').cancel()<cr>" },
    },
    dependencies = {
      {'gbprod/yanky.nvim', keys={
        {mode = {"n","x"}, "p", "<Plug>(YankyPutAfter)"},
        {mode = {"n","x"}, "P", "<Plug>(YankyPutBefore)"},
        {mode = {"n","x"}, "gp", "<Plug>(YankyGPutAfter)"},
        {mode = {"n","x"}, "gP", "<Plug>(YankyGPutBefore)"},
        {mode = "n", "<c-n>", "<Plug>(YankyCycleForward)"},
        {mode = "n", "<c-p>", "<Plug>(YankyCycleBackward)"},
      }}
    }
  },

  {'echasnovski/mini.nvim', config= function()
    require('mini.ai').setup()
    require('mini.move').setup()
    if is_nvim() then
      require('mini.cursorword').setup()
      -- require('mini.indentscope').setup{draw = {animation = require('mini.indentscope').gen_animation.none() }} 
      require('mini.pairs').setup()
      require('mini.starter').setup()
      require('mini.statusline').setup()
      require('mini.tabline').setup()
    end
  end},

  nvim 'folke/which-key.nvim', 

  -- --------------------------------- motion ------------------------------------

  -- 'rhysd/clever-f.vim', 
  -- g.clever_f_smart_case = 1

  {
    'ggandor/leap.nvim', 
    config= function() require'leap'.set_default_keymaps() end,
    keys = {
      {'s', function() require'leap'.leap{ target_windows= { vim.fn.win_getid() } } end}
    },
    dependencies = {
      'ggandor/leap-spooky.nvim', 
      {'ggandor/flit.nvim', opts={ labeled_modes= "nv" }},
    }
  },

  -- ------------------------------ text objects ---------------------------------

  {'kana/vim-textobj-user', dependencies = {
    'kana/vim-textobj-entire', -- e - entire
    'kana/vim-textobj-line', -- l - line
    'Julian/vim-textobj-variable-segment', -- v - segment
    'kana/vim-textobj-indent', -- i - indent block, I - same indent (wont select sub indent)
    -- 'pianohacker/vim-textobj-indented-paragraph' -- r - paragraph that won',t go less indent
    -- 'tkhren/vim-textobj-numeral', -- n - number (do you want gn - jump to number)
    'MRAAGH/vim-textobj-chunk', -- lines that contain {},(),[] block. Use to select functions.
  }}, 

  'PeterRincker/vim-argumentative',   -- <, shift argument, [, move argument, , - argument

  {'glts/vim-textobj-comment', -- / - comment
  config = function() g.textobj_comment_no_default_key_mappings = 1 end, 
  keys = {
    {'a/', '<Plug>(textobj-comment-a)', mode='x'},
    {'a/', '<Plug>(textobj-comment-a)', mode='o'},
    {'i/', '<Plug>(textobj-comment-i)', mode='x'},
    {'i/', '<Plug>(textobj-comment-i)', mode='o'},
  }},

  -- 'machakann/vim-sandwich',, config: -> vim.cmd [[runtime macros/sandwich/keymap/surround.vim]]
  -- -- ys{motion}{type}, ds{type}, cs{type}, v_S{type}, yss (line), css (auto), d - auto separator
  -- xmap 'id', '<Plug>(textobj-sandwich-auto-i)'
  -- xmap 'ad', '<Plug>(textobj-sandwich-auto-a)'
  -- omap 'id', '<Plug>(textobj-sandwich-auto-i)'
  -- omap 'ad', '<Plug>(textobj-sandwich-auto-a)'

  -- 'wellle/targets.vim',
  -- -- I - inner inner, A - around space, n l - next & seek multi line, inside separators, a - argument
  -- g.targets_gracious = 1

  {'andymass/vim-matchup', 
  config = function()
    -- % forwards, g% backwards, ]% next surrounding, z% jump inside, % - text object
    g.matchup_matchparen_deferred = 1
    g.matchup_transmute_enabled = 0
    g.matchup_surround_enabled = 1
  end},

  {'monaqa/dial.nvim', keys = {
    {mode="n", "<C-a>", function() require"dial.map".inc_normal() end},
    {mode="n", "<C-x>", function() require"dial.map".dec_normal() end},
    {mode="v", "<C-a>", function() require"dial.map".inc_visual() end},
    {mode="v", "<C-x>", function() require"dial.map".dec_visual() end},
    {mode="v", "g<C-a>", function() require"dial.map".inc_gvisual() end},
    {mode="v", "g<C-x>", function() require"dial.map".dec_gvisual() end},
  }},

  -- --------------------------- syntax and language -----------------------------

  nvim {
    'https://gitlab.com/theol0403/monokai-pro.nvim',
    lazy = false,
    priority = 1000,
    config = function() 
      g.monokaipro_transparent = false
      cmd [[colorscheme monokaipro]]
    end
  },

  {
    'nvim-treesitter/nvim-treesitter', build=':TSUpdate', dependencies={
      'nvim-treesitter/nvim-treesitter-textobjects', 
    },
    opts = {
      textobjects= {
        select= {
          enable= true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead= true,

          keymaps= {
            -- You can use the capture groups defined in textobjects.scm
            ["af"]= "@function.outer",
            ["if"]= "@function.inner",
            ["aC"]= "@class.outer",
            ["iC"]= "@class.inner",
          },
        },
      },
      highlight= {
        enable= is_nvim(),
      }
    }
  },

  nvim {'hrsh7th/nvim-cmp', dependencies={
    'neovim/nvim-lspconfig', 
    'hrsh7th/cmp-nvim-lsp', 
    'hrsh7th/cmp-buffer', 
    'hrsh7th/cmp-path', 
    'hrsh7th/cmp-cmdline', 
  }},

  -- ----------------------------- ui improvements -------------------------------

  nvim 'myusuf3/numbers.vim', -- enable/disable relative based on mode
  nvim 'ethanholz/nvim-lastplace',
  nvim {'inkarkat/vim-CursorLineCurrentWindow', config= function() vim.opt.cursorline = true end },
  'winston0410/cmd-parser.nvim', 
  'winston0410/range-highlight.nvim', 

  -- ---------------------------------- misc -------------------------------------

  nvim 'wakatime/vim-wakatime', 
  nvim 'glacambre/firenvim', 
}

return plugins

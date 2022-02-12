require 'common'

-- ------------------------------- essentials ----------------------------------

use 'tpope/vim-repeat'
use 'tpope/vim-commentary'             -- gc{motion} gcc gcgc dgc
use 'tpope/vim-unimpaired'             -- [space [e
use 'inkarkat/vim-ReplaceWithRegister'
use 'tommcdo/vim-exchange'             -- cx v_X cxc
use 'tommcdo/vim-lion'
-- use 'AndrewRadev/switch.vim'           -- gs switches value
use 'matze/vim-move'                   -- alt-arrows move lines around
use 'AndrewRadev/splitjoin.vim'

-- --------------------------------- motion ------------------------------------

-- use 'rhysd/clever-f.vim'
-- g.clever_f_smart_case = 1
-- nmap {'override'}, ';', '<Plug>(clever-f-repeat-forward)'
-- nmap {'override'}, ',', '<Plug>(clever-f-repeat-back)'
-- nnoremap <silent> <ESC> :call clever_f#_reset_all()<CR><ESC>

-- use 'unblevable/quick-scope' -- guide for f/t
-- g.qs_ignorecase = 1
-- g.qs_max_chars = 200

-- use 'justinmk/vim-sneak' -- <space>s <space>S {operator}z v_s v_Z
-- g["sneak#use_ic_scs"] = 1
-- g["sneak#s_next"] = 1
-- vmap 'z', '<Plug>Sneak_s'
-- omap 'z', '<Plug>Sneak_s'

-- use_nvim 'easymotion/vim-easymotion'
-- use_vscode 'theol0403/vim-easymotion', as:'vsc-easymotion'
-- -- use 'haya14busa/vim-easyoperator-line' -- operator on range of lines {op}<space>l{start}{end}
-- g.EasyMotion_smartcase = 1

-- use 'phaazon/hop.nvim'
-- vim.api.nvim_set_keymap('n', '$', "<cmd>lua require'hop'.hint_words()<cr>", {})

use 'ggandor/lightspeed.nvim'

-- ------------------------------ text objects ---------------------------------

use 'kana/vim-textobj-user'
use 'kana/vim-textobj-entire' -- e - entire
use 'kana/vim-textobj-line' -- l - line
use 'Julian/vim-textobj-variable-segment' -- v - segment
use 'kana/vim-textobj-indent' -- i - indent block, I - same indent (wont select sub indent)
use 'pianohacker/vim-textobj-indented-paragraph' -- r - paragraph that won't go less indent
-- use 'tkhren/vim-textobj-numeral' -- n - number (do you want gn - jump to number)
use 'MRAAGH/vim-textobj-chunk' -- lines that contain {},(),[] block. Use to select functions.

use 'kana/vim-textobj-function' -- f - function
use 'haya14busa/vim-textobj-function-syntax'
use 'PeterRincker/vim-argumentative'   -- <, shift argument, [, move argument, , - argument

use 'glts/vim-textobj-comment' -- / - comment
g.textobj_comment_no_default_key_mappings = 1
xmap 'a/', '<Plug>(textobj-comment-a)'
omap 'a/', '<Plug>(textobj-comment-a)'
xmap 'i/', '<Plug>(textobj-comment-i)'
omap 'i/', '<Plug>(textobj-comment-i)'

use 'machakann/vim-sandwich', config: -> vim.cmd [[runtime macros/sandwich/keymap/surround.vim]]
-- ys{motion}{type}, ds{type}, cs{type}, v_S{type}, yss (line), css (auto), d - auto separator
xmap 'id', '<Plug>(textobj-sandwich-auto-i)'
xmap 'ad', '<Plug>(textobj-sandwich-auto-a)'
omap 'id', '<Plug>(textobj-sandwich-auto-i)'
omap 'ad', '<Plug>(textobj-sandwich-auto-a)'

use 'wellle/targets.vim'
-- I - inner inner, A - around space, n l - next & seek multi line, inside separators, a - argument
g.targets_gracious = 1

use 'andymass/vim-matchup'
-- % forwards, g% backwards, ]% next surrounding, z% jump inside, % - text object
g.matchup_matchparen_deferred = 1
g.matchup_transmute_enabled = 0
g.matchup_surround_enabled = 1

-- --------------------------- syntax and language -----------------------------

use_nvim 'phanviet/vim-monokai-pro'
-- use_nvim 'tanvirtin/monokai.nvim'
use_nvim 'sainnhe/sonokai'
use_nvim 'sheerun/vim-polyglot'
use_nvim 'jackguo380/vim-lsp-cxx-highlight'
use_nvim 'kana/vim-smartinput'
use 'jeetsukumaran/vim-pythonsense'
use 'rhysd/vim-grammarous' -- GrammarousCheck LanguageTool
use_nvim 'leafo/moonscript-vim'

-- ----------------------------- ui improvements -------------------------------

use_nvim 'mhinz/vim-startify'
use_nvim 'myusuf3/numbers.vim' -- enable/disable relative based on mode
use_nvim 'markonm/traces.vim' -- live substitute preview
use_nvim 'dietsche/vim-lastplace'
use_nvim 'inkarkat/vim-CursorLineCurrentWindow', setup: -> vim.opt.cursorline = true
-- use_nvim 'szw/vim-maximizer' -- TODO: assign binding
use_nvim 'karb94/neoscroll.nvim', config: -> require('neoscroll').setup()
use_nvim 'nvim-treesitter/nvim-treesitter', run:':TSUpdate'
-- use_nvim 'folke/which-key.nvim'
use_nvim 'vim-utils/vim-husk' -- boosts command mode
use_nvim 'wfxr/minimap.vim'

use_nvim 'dominikduda/vim_current_word'
g['vim_current_word#highlight_only_in_focused_window'] = 1
g['vim_current_word#highlight_delay'] = 100

-- ---------------------------------- latex ------------------------------------

use_nvim 'lervag/vimtex'
g.vimtex_mappings_override_existing = 1
use 'xuhdev/vim-latex-live-preview'
g.livepreview_previewer = 'okular'
g.livepreview_engine = 'xelatex'

-- ---------------------------------- misc -------------------------------------

use_nvim 'wakatime/vim-wakatime'
use_nvim 'glacambre/firenvim'

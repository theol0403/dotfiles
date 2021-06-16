" PLUGINS
function! Cond(Cond, ...)
  let opts = get(a:000, 0, {})
  return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('~/.vim/plugged')
" essentials
Plug 'tpope/vim-repeat'
Plug 'machakann/vim-sandwich' "ys{motion}{type}, ds{type}, cs{type}, v_S{type}, yss (line), css (auto), d - auto separator
Plug 'tpope/vim-commentary' "gc{motion} gcc gcgc agc
Plug 'inkarkat/vim-ReplaceWithRegister' "gr
Plug 'tommcdo/vim-exchange' "cx v_X cxc
Plug 'PeterRincker/vim-argumentative' "<, shift argument, [, move argument, , - argument
Plug 'wellle/targets.vim' "I - inner inner, A - around space, n l - next & seek multi line, inside separators, a - argument
" Plug 'junegunn/vim-slash' " * - search word without moving, *cgn - change current word and then dot-repeat
Plug 'matze/vim-move' "alt-arrows move lines around
Plug 'AndrewRadev/switch.vim' "gs switches value
Plug 'andymass/vim-matchup' " % forwards, g% backwards, ]% next surrounding, z% jump inside, % - text object
Plug 'rhysd/clever-f.vim'
Plug 'arecarn/vim-crunch' "improved calculator, g=, Crunch
Plug 'arecarn/vim-selection' "needed by crunch
Plug 'airblade/vim-rooter'

" syntax and language
Plug 'neoclide/coc.nvim', Cond(!exists('g:vscode'), {'branch': 'release'}) 
Plug 'sheerun/vim-polyglot', Cond(!exists('g:vscode'))
Plug 'phanviet/vim-monokai-pro', Cond(!exists('g:vscode'))
Plug 'jackguo380/vim-lsp-cxx-highlight', Cond(!exists('g:vscode'))
Plug 'kana/vim-smartinput', Cond(!exists('g:vscode'))
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'rhysd/vim-grammarous' "GrammarousCheck LanguageTool

" visual improvements
Plug 'mhinz/vim-startify', Cond(!exists('g:vscode') && !exists('g:started_by_firenvim'))
Plug 'myusuf3/numbers.vim', Cond(!exists('g:vscode') && !exists('g:started_by_firenvim')) "enable/disable relative based on mode
Plug 'markonm/traces.vim', Cond(!exists('g:vscode')) "live substitute preview
Plug 'dominikduda/vim_current_word', Cond(!exists('g:vscode')) "hl current word
Plug 'machakann/vim-highlightedyank'
Plug 'dietsche/vim-lastplace', Cond(!exists('g:vscode') && !exists('g:started_by_firenvim'))
Plug 'inkarkat/vim-CursorLineCurrentWindow', Cond(!exists('g:vscode') && !exists('g:started_by_firenvim'))
Plug 'szw/vim-maximizer', Cond(!exists('g:vscode') && !exists('g:started_by_firenvim'))
Plug 'ConradIrwin/vim-bracketed-paste', Cond(!exists('g:vscode') && !exists('g:started_by_firenvim'))
Plug 'unblevable/quick-scope' "guide for f/t
Plug 'psliwka/vim-smoothie', Cond(!exists('g:vscode'), {'commit':'6cd5dea1698c0238a6d08eb8fc66696007483640'})

" terminal stuff
Plug 'christoomey/vim-tmux-navigator', Cond(!exists('g:vscode') && !exists('g:started_by_firenvim'))
Plug 'tmux-plugins/vim-tmux-focus-events', Cond(!exists('g:vscode') && !exists('g:started_by_firenvim'))
Plug 'vimlab/split-term.vim' " :Term better term
Plug 'vim-utils/vim-husk' "boosts command mode

" fancy text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire' "e - entire
Plug 'glts/vim-textobj-comment' "/ - comment
Plug 'kana/vim-textobj-line' "l - line
Plug 'Julian/vim-textobj-variable-segment' "v - segment
Plug 'kana/vim-textobj-indent' "i - indent block, I - same indent (wont select sub indent)
Plug 'pianohacker/vim-textobj-indented-paragraph' "r - paragraph that won't go less indent
" Plug 'tkhren/vim-textobj-numeral' "n - number (do you want gn - jump to number)
Plug 'kana/vim-textobj-function' "f - function
Plug 'haya14busa/vim-textobj-function-syntax'
Plug 'MRAAGH/vim-textobj-chunk' "lines that contain {},(),[] block. Use to select functions.
Plug 'landock/vim-expand-region' "+ - expand, _ - shrink
" Plug 'chaoren/vim-wordmotion'
Plug 'AndrewRadev/splitjoin.vim'

" easy motion
Plug 'easymotion/vim-easymotion', Cond(!exists('g:vscode'))
Plug 'theol0403/vim-easymotion', Cond(exists('g:vscode'), { 'as': 'vsc-easymotion' })
Plug 'haya14busa/vim-easyoperator-line' "operator on range of lines {op}<space>l{start}{end}
Plug 'justinmk/vim-sneak' "<space>s <space>S {operator}z v_s v_Z

" latex
Plug 'lervag/vimtex', Cond(!exists('g:vscode'))
" Plug 'xuhdev/vim-latex-live-preview'

Plug 'wakatime/vim-wakatime', Cond(!exists('g:vscode'))
Plug 'glacambre/firenvim', Cond(!exists('g:vscode'), {'do': { _ -> firenvim#install() } }) 

" Plug 'folke/which-key.nvim'

call plug#end()
autocmd FileType vim syntax keyword Function Plug

runtime macros/sandwich/keymap/surround.vim

" PLUGIN SETTINGS
let g:targets_gracious=1
let g:vim_current_word#highlight_only_in_focused_window=1
let g:vim_current_word#highlight_delay = 100
let g:matchup_matchparen_deferred = 1
let g:matchup_transmute_enabled = 0
let g:matchup_surround_enabled = 1

let g:qs_ignorecase = 1
let g:qs_max_chars=200

" latex settings
let g:vimtex_mappings_override_existing=1
let g:livepreview_previewer = 'okular'
let g:livepreview_engine = 'xelatex'

" easymotion settings
let g:EasyMotion_smartcase=1
" map <space> <Plug>(easymotion-prefix)
" map  <space>/ <Plug>(easymotion-sn)
" omap <space>/ <Plug>(easymotion-tn)
" nmap <space><space> <Plug>(easymotion-jumptoanywhere)

let mapleader="\<space>"
nmap <leader>w <c-w>

" sneak and clever-f settings
let g:sneak#use_ic_scs=1
let g:sneak#s_next=1
omap z <Plug>Sneak_s
vmap z <Plug>Sneak_s
let g:clever_f_smart_case=1
nmap ; <Plug>(clever-f-repeat-forward)
nmap , <Plug>(clever-f-repeat-back)
nnoremap <silent> <ESC> :call clever_f#_reset_all()<CR><ESC>

" GENERAL SETTINGS
set confirm
set history=1000
set undolevels=1000
set undoreload=10000
" set timeoutlen=3000
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set shiftwidth=2
set autoindent
set hlsearch
set incsearch
set ignorecase
set smartcase
set gdefault
set showcmd
set textwidth=100
set formatoptions-=t
set formatoptions+=cj
set linebreak
set shortmess+=atT
set nostartofline
set splitbelow
set splitright
set cpoptions+=y

" set proper comment style
autocmd FileType c,cpp,cs,java,json,def setlocal commentstring=//\ %s
" wrap in text files
autocmd Filetype text setlocal wrap linebreak
" kmonad
augroup KMONAD
  au BufRead,BufNewFile *.kbd set filetype=clojure | set syntax=clojure
augroup END

" visual star - select and press enter
xnoremap <silent> <cr> "*y:silent! let searchTerm = '\V'.substitute(escape(@*, '\/'), "\n", '\\n', "g") <bar> let @/ = searchTerm <bar> echo '/'.@/ <bar> call histadd("search", searchTerm) <bar> set hls<cr>
" enter is star without moving
nnoremap <silent> <cr> :let searchTerm = '\v<'.expand("<cword>").'>' <bar> let @/ = searchTerm <bar> echo '/'.@/ <bar> call histadd("search", searchTerm) <bar> set hls<cr>
" auto clear
augroup searchhighlight
    autocmd!
    autocmd CursorHold,CursorHoldI * set nohls
augroup END

if !exists('g:vscode')
  " ordinary neovim
  set hidden
  set ruler
  set number
  set relativenumber
  set visualbell
  set wildmenu
  set wildmode=list:longest,full
  set showmode
  set laststatus=1
  set title
  set mouse=a
  set scrolloff=3
  set autoread
  set undofile
  set expandtab
  set smarttab
  set spell
  set cursorline
  set lazyredraw
  set backupdir=~/.config/nvim/backups

  map j gj
  map k gk

  nnoremap <leader>z :MaximizerToggle<CR>
  vnoremap <leader>z :MaximizerToggle<CR>gv

  "colour scheme
  set termguicolors
  set t_Co=256
  set background=dark
  colorscheme monokai_pro
  hi Normal guibg=NONE ctermbg=NONE
  hi NonText guibg=NONE ctermbg=NONE
  hi LineNr ctermfg=246 ctermbg=NONE cterm=NONE guifg=#959394 guibg=NONE gui=NONE

  " fix c++ number hl
  hi link LspCxxHlGroupEnumConstant Number
  hi link LspCxxHlGroupNamespace Function

  set fillchars=stl:─,stlnc:─,vert:│
  hi StatusLineNC ctermbg=NONE guibg=NONE guifg=#696769 
  hi StatusLine ctermbg=NONE guibg=NONE guifg=#FC9867 gui=NONE cterm=NONE ctermfg=5
  hi VertSplit ctermbg=NONE guibg=NONE,bright

  runtime ./coc-config.vim

  " Resize splits when vim changes size (like with tmux opening/closing)
  augroup auto-resize
    autocmd!
    autocmd VimResized * wincmd =
  augroup END
endif

if exists('g:vscode')
  set nowrap
  set shortmess+=F
  let g:matchup_matchparen_nomode = 'i'

  highlight QuickScopePrimary guifg=NONE guisp='#afff5f' gui=underline ctermfg=NONE cterm=underline
  highlight QuickScopeSecondary guifg=NONE guisp='#5fffff' gui=underline ctermfg=NONE cterm=underline

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * RelativeNumber
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * Number 
augroup END
elseif exists('g:started_by_firenvim')
  start
  " runtime colors/colors.vim
  set laststatus=0
  set norelativenumber
  silent au TextChanged * ++nested silent write
  silent au TextChangedI * ++nested silent write
endif

" MAPPINGS 
" Make Y behave like D, A, I, etc.
nmap Y y$
" Make Q repeat the last recorded macro
nmap Q @@
" clear hl
nnoremap <silent> <leader>k :nohl<CR><C-l>
" save
map <C-S> :wall<CR><ESC>
imap <C-S> <ESC>:wall<CR>
" sudo save
command! W w !sudo tee % > /dev/null
" swap soft eol
noremap 0 ^
noremap ^ 0
" window movements
nmap <Leader>q <C-W>q
nmap <Leader>h <C-W>h
nmap <Leader>j <C-W>j
nmap <Leader>k <C-W>k
nmap <Leader>l <C-W>l
nmap <Leader>p <C-W>p " prev window
nmap <Leader>o :tabonly<CR>
" command shortcuts
nnoremap <Leader><Leader> :
nmap <Leader>s :w<CR>
nmap <Leader>v :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>e :exe ':silent !code-insiders %'<CR>:redraw!<CR>
" replace all instances of word
nnoremap <Leader>c :%s/\<<C-r><C-w>\>/
" " auto correct spelling
" inoremap <C-f> <c-g>u<Esc>[s1z=`]a<c-g>u
" nnoremap <leader>f [s1z=`
" undo delete line
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>
" terminal
tnoremap <Esc> <C-\><C-n>
" arrow key movement
nmap <C-Left> B
nmap <C-Right> W
nmap <S-Left> b
nmap <S-Right> w
nmap <Down> j
nmap <Up> k
" copy to clipboard
vmap <C-Ins> "+y
nmap <C-Ins> "+yy
" better scroll
map <C-Up> <C-U>
map <C-Down> <C-D>
" paste default register
inoremap <C-R><C-R> <C-R>"
inoremap <C-R>' <C-R>+
" delete word
" imap <C-BS> d
" noremap! <C-BS> <C-w>


" PLUGIN MAPPINGS
" a comment text object is / not c
let g:textobj_comment_no_default_key_mappings=1
xmap a/ <Plug>(textobj-comment-a)
omap a/ <Plug>(textobj-comment-a)
xmap i/ <Plug>(textobj-comment-i)
omap i/ <Plug>(textobj-comment-i)

" sandwich config
xmap id <Plug>(textobj-sandwich-auto-i)
xmap ad <Plug>(textobj-sandwich-auto-a)
omap id <Plug>(textobj-sandwich-auto-i)
omap ad <Plug>(textobj-sandwich-auto-a)

" SPECIAL MODE MAPPINGS
if exists('g:vscode')
  nnoremap <silent> gz <Cmd>call VSCodeNotifyRange("git.revertSelectedRanges", line("."), line("."), 0)<CR>
  xnoremap <silent> gz <Cmd>call VSCodeNotifyRange("git.revertSelectedRanges", line("v"), line("."), 0)<CR><ESC>	

  function! s:switchEditor(...) abort
    let count = a:1
    let direction = a:2
    for i in range(1, count ? count : 1)
      call VSCodeCall(direction ==# 'next' ? 'workbench.action.nextEditorInGroup' : 'workbench.action.previousEditorInGroup')
    endfor
  endfunction

  function! s:openWhichkeyInVisual()
    let visualmode = visualmode()
    if visualmode ==# "V"
      let startLine = line("v")
      let endLine = line(".")
      call VSCodeNotifyRange("whichkey.show", startLine, endLine, 1)
    else
      let startPos = getpos("v")
      let endPos = getpos(".")
      call VSCodeNotifyRangePos("whichkey.show", startPos[1], endPos[1], startPos[2], endPos[2] + 1, 1)
    endif
  endfunction

  nnoremap <silent> ' <Cmd>call VSCodeNotify('whichkey.show')<CR>
  xnoremap <silent> ' <Cmd>call <SID>openWhichkeyInVisual()<CR>

  " move tabs
  " nnoremap <silent> ]t <Cmd>call <SID>switchEditor(v:count, 'next')<CR>
  " nnoremap <silent> [t <Cmd>call <SID>switchEditor(v:count, 'prev')<CR>
  " nnoremap <silent> ]T <Cmd>call VSCodeNotify('workbench.action.lastEditorInGroup')<CR>
  " nnoremap <silent> [T <Cmd>call VSCodeNotify('workbench.action.firstEditorInGroup')<CR>

  " nnoremap gt <Cmd>call VSCodeNotify('workbench.action.showAllEditors')<CR>
  " nnoremap gT <Cmd>call VSCodeNotify('workbench.action.showAllEditorsByMostRecentlyUsed')<CR>

  nnoremap <Leader>c <Cmd>call VSCodeNotify('editor.action.rename')<CR>

  nnoremap <leader>a <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>
  nnoremap go <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>

  nnoremap ]c <Cmd>call VSCodeNotify('workbench.action.editor.nextChange')<CR>
  nnoremap [c <Cmd>call VSCodeNotify('workbench.action.editor.previousChange')<CR>
  nnoremap ]e <Cmd>call VSCodeNotify('editor.action.marker.next')<CR>
  nnoremap [e <Cmd>call VSCodeNotify('editor.action.marker.prev')<CR>

  unmap H
  unmap M
  unmap L

  " map <silent> <C-j> <Cmd>call VSCodeNotify('workbench.action.navigateDown')<CR>
  " map <silent> <C-k> <Cmd>call VSCodeNotify('workbench.action.navigateUp')<CR>
  " map <silent> <C-h> <Cmd>call VSCodeNotify('workbench.action.navigateLeft')<CR>
  " map <silent> <C-l> <Cmd>call VSCodeNotify('workbench.action.navigateRight')<CR>

  " au InsertEnter * call VSCodeNotify('settings.cycle.numbering')
  " au InsertLeave * call VSCodeNotify('settings.cycle.numbering')

elseif exists('g:started_by_firenvim')
  nnoremap <Esc><Esc> :call firenvim#focus_page()<CR>
  nnoremap <C-c> :call firenvim#hide_frame()<CR>
  nnoremap <CR> :wq<CR>
  inoremap <S-CR> <Esc>:wq<CR>
endif

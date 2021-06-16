require 'common'

-- -------------------------------- settings -----------------------------------

opt.confirm = true
opt.timeoutlen = 3000
opt.whichwrap\append '<,>,h,l' -- allow movement between end/start of line
opt.shiftwidth = 2
opt.ignorecase = true
opt.smartcase = true
opt.gdefault = true
opt.formatoptions\remove 't'
opt.formatoptions\append 'cj'
opt.linebreak = true -- if text should be wrapped at certain characters
opt.shortmess\append 'a' -- abbreviate messages
opt.splitbelow = true
opt.splitright = true

-- highlightyank
cmd [[au TextYankPost * silent! lua vim.highlight.on_yank{higroup='IncSearch', timeout=500}]]
-- set proper comment style
cmd [[au FileType c,cpp,cs,java,json,def setlocal commentstring=//\ %s]]
-- wrap in text files
cmd [[au Filetype text setlocal wrap linebreak]]
-- auto clear
cmd [[au CursorHold,CursorHoldI * set nohls | set tw=100]]

-- -------------------------------- mappings -----------------------------------

g.mapleader=" "
nmap '<leader>w', '<c-w>'

-- Y behaves like D, A, I, etc.
nmap 'Y', 'y$'
-- swap soft eol
noremap '0', '^'
noremap '^', '0'
-- Q repeats the last recorded macro
nmap 'Q', '@@'
-- save
map '<C-S>', ':wall<CR><ESC>'
imap '<C-S>', '<ESC>:wall<CR>'
-- undo delete line
inoremap {'override'}, '<C-U>', '<C-G>u<C-U>'
inoremap {'override'}, '<C-W>', '<C-G>u<C-W>'
-- terminal
tnoremap '<Esc>', [[<C-\><C-n>]]
-- arrow key movement
nmap '<C-Left>', 'B'
nmap '<C-Right>', 'W'
nmap '<S-Left>', 'b'
nmap '<S-Right>', 'w'
nmap '<Down>', 'j'
nmap '<Up>', 'k'
-- copy to clipboard
vmap '<C-Ins>', '"+y'
nmap '<C-Ins>', '"+yy'
-- paste default register
inoremap '<C-R><C-R>', '<C-R>"'
inoremap '<C-R>\'', '<C-R>+'
-- delete word
imap '<C-BS>', '<C-w>'

-- ------------------------- neovim specific config ----------------------------
if is_nvim!

	-- mappings
	map 'j', 'gj'
	map 'k', 'gk'
	nnoremap '<leader>z', ':MaximizerToggle<CR>'
	vnoremap '<leader>z', ':MaximizerToggle<CR>gv'

	-- settings
	opt.number = true
	opt.relativenumber = true
	opt.wildmode = 'list:longest:lastused,full:lastused'
	opt.mouse = 'ar'
	opt.scrolloff = 3
	opt.undofile = true
	opt.expandtab = true
	opt.spell = true

	-- colour scheme
	opt.termguicolors = true
	opt.fillchars = [[stl:─,stlnc:─,vert:│]]

	cmd [[colorscheme monokai_pro]]
	cmd [[hi Normal guibg=NONE ctermbg=NONE]]
	cmd [[hi NonText guibg=NONE ctermbg=NONE]]
	cmd [[hi LineNr ctermfg=246 ctermbg=NONE cterm=NONE guifg=#959394 guibg=NONE gui=NONE]]

	-- fix c++ number hl
	cmd [[hi link LspCxxHlGroupEnumConstant Number]]
	cmd [[hi link LspCxxHlGroupNamespace Function]]

	cmd [[hi StatusLineNC ctermbg=NONE guibg=NONE guifg=#696769]]
	cmd [[hi StatusLine ctermbg=NONE guibg=NONE guifg=#FC9867 gui=NONE cterm=NONE ctermfg=5]]
	cmd [[hi VertSplit ctermbg=NONE guibg=NONE,bright]]

	-- Resize splits when vim changes size (like with tmux opening/closing)
	cmd [[au VimResized * wincmd =]]
	
-- ------------------------- vscode specific config ----------------------------
elseif is_vscode!

	opt.shortmess\append 'F'
	opt.showmode = false
	g.matchup_matchparen_nomode = 'i'

	cmd [[hi QuickScopePrimary guifg=NONE guisp='#afff5f' gui=underline ctermfg=NONE cterm=underline]]
	cmd [[hi QuickScopeSecondary guifg=NONE guisp='#5fffff' gui=underline ctermfg=NONE cterm=underline]]

	cmd [[
	augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave,WinEnter * RelativeNumber
	autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * Number 
	augroup END
	]]

	nnoremap 'gz', '<Cmd>call VSCodeNotifyRange("git.revertSelectedRanges", line("."), line("."), 0)<CR>'
	xnoremap 'gz', '<Cmd>call VSCodeNotifyRange("git.revertSelectedRanges", line("v"), line("."), 0)<CR><ESC>'

	noremap '\'', '<Cmd>call VSCodeNotifyVisual("whichkey.show", 1)<CR>'

	-- nnoremap 'gt', '<Cmd>call VSCodeNotify("workbench.action.showAllEditors")<CR>'
	-- nnoremap 'gT', '<Cmd>call VSCodeNotify("workbench.action.showAllEditorsByMostRecentlyUsed")<CR>'
	nnoremap 'go', '<Cmd>call VSCodeNotify("workbench.action.quickOpen")<CR>'

	-- nnoremap ']c', '<Cmd>call VSCodeNotify("workbench.action.editor.nextChange")<CR>'
	-- nnoremap '[c', '<Cmd>call VSCodeNotify("workbench.action.editor.previousChange")<CR>'
	-- nnoremap ']e', '<Cmd>call VSCodeNotify("editor.action.marker.next")<CR>'
	-- nnoremap '[e', '<Cmd>call VSCodeNotify("editor.action.marker.prev")<CR>'

	cmd 'unmap H'
	cmd 'unmap M'
	cmd 'unmap L'
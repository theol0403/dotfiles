-- helper aliases
cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
g = vim.g      -- a table to access global variables
opt = vim.opt  -- to set options

-- set up vscode-neovim helpers
is_vscode = function() return vim.g.vscode == 1 end
firenvim = function() return vim.g.started_by_firenvim == 1 end
is_nvim = function() return (not is_vscode()) and (not firenvim()) end

-- map helpers
bind = function (mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, {remap=true}) end 
nobind = function (mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, {remap=false}) end 
map = function(...) bind({'n', 'v', 'o'}, ...) end 
noremap = function(...) nobind({'n', 'v', 'o'}, ...) end 
nmap = function(...) bind('n', ...) end
nnoremap = function(...) nobind('n', ...) end
imap = function(...) bind('i', ...) end
inoremap = function(...) nobind('i', ...) end
omap = function(...) bind('o', ...) end
onoremap = function(...) nobind('o', ...) end
xmap = function(...) bind('x', ...) end
xnoremap = function(...) nobind('x', ...) end
vmap = function(...) bind('v', ...) end
vnoremap = function(...) nobind('v', ...) end
tmap = function(...) bind('t', ...) end
tnoremap = function(...) nobind('t', ...) end

-- -------------------------------- settings -----------------------------------

opt.timeoutlen = 500
opt.whichwrap:append'<,>,h,l' -- allow movement between end/start of line
opt.shiftwidth = 2
opt.ignorecase = true
opt.smartcase = true
opt.gdefault = true
opt.formatoptions:remove't'
opt.formatoptions:append'cj'
opt.linebreak = true -- if text should be wrapped at certain characters
opt.shortmess:append'a' -- abbreviate messages
opt.splitbelow = true
opt.splitright = true
opt.hlsearch = true

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

-- Y behaves like D, A, I, etc.
nmap ('Y', 'y$')
-- swap soft eol
noremap ('0', '^')
noremap ('^', '0')
-- save
map ('<C-S>', ':wall<CR><ESC>')
imap ('<C-S>', '<ESC>:wall<CR>')
-- undo delete line
inoremap ('<C-U>', '<C-G>u<C-U>')
inoremap ('<C-W>', '<C-G>u<C-W>')
-- terminal
tnoremap ('<Esc>', [[<C-\><C-n>]])
-- arrow key movement
-- nmap ('<C-Left>', 'B')
-- nmap ('<C-Right>', 'W')
-- nmap ('<S-Left>', 'b')
-- nmap ('<S-Right>', 'w')
-- nmap ('<Down>', 'j')
-- nmap ('<Up>', 'k')
-- copy to clipboard
vmap ('<C-Ins>', '"+y')
nmap ('<C-Ins>', '"+yy')
-- paste default register
inoremap ('<C-R><C-R>', '<C-R>"')
inoremap ('<C-R>\'', '<C-R>+')
-- delete word
imap ('<C-BS>', '<C-w>')

imap ('jk', '<Esc>')
imap ('kj', '<Esc>')

-- ------------------------- neovim specific config ----------------------------
if is_nvim() then

	-- mappings
	map ('j', 'gj')
	map ('k', 'gk')
	nnoremap ('<leader>z', ':MaximizerToggle<CR>')
	vnoremap ('<leader>z', ':MaximizerToggle<CR>gv')
	nmap ('<leader>w', '<c-w>')

	-- settings
	opt.number = true
	opt.relativenumber = true
	-- opt.wildmode = 'list:longest:lastused,full:lastused'
	opt.mouse = 'ar'
	opt.scrolloff = 3
	opt.undofile = true
	opt.expandtab = true
	opt.spell = true

	-- colour scheme
	opt.termguicolors = true
	opt.fillchars = [[stl:─,stlnc:─,vert:│]]

	-- cmd [[colorscheme monokai_pro]]
	-- cmd [[hi Normal guibg=NONE ctermbg=NONE]]
	-- cmd [[hi NonText guibg=NONE ctermbg=NONE]]
	-- cmd [[hi LineNr ctermfg=246 ctermbg=NONE cterm=NONE guifg=#959394 guibg=NONE gui=NONE]]

	-- -- fix c++ number hl
	-- cmd [[hi link LspCxxHlGroupEnumConstant Number]]
	-- cmd [[hi link LspCxxHlGroupNamespace Function]]

	-- cmd [[hi StatusLineNC ctermbg=NONE guibg=NONE guifg=#696769]]
	-- cmd [[hi StatusLine ctermbg=NONE guibg=NONE guifg=#FC9867 gui=NONE cterm=NONE ctermfg=5]]
	-- cmd [[hi VertSplit ctermbg=NONE guibg=NONE,bright]]

	-- Resize splits when vim changes size (like with tmux opening/closing)
	cmd [[au VimResized * wincmd =]]

-- ------------------------- vscode specific config ----------------------------
elseif is_vscode() then

  opt.shortmess:append'F'
	opt.showmode = false
	g.matchup_matchparen_nomode = 'i'

	-- cmd [[
	-- 	highlight OperatorSandwichBuns guifg='#aa91a0' gui=underline ctermfg=172 cterm=underline 
	-- 	highlight OperatorSandwichChange guifg='#edc41f' gui=underline ctermfg='yellow' cterm=underline
	-- 	highlight OperatorSandwichAdd guibg='#b1fa87' gui=none ctermbg='green' cterm=none
	-- 	highlight OperatorSandwichDelete guibg='#cf5963' gui=none ctermbg='red' cterm=none
	-- 	call operator#sandwich#set('all', 'all', 'highlight', 0)
	-- ]]

	-- cmd [[
	-- augroup numbertoggle
	-- autocmd!
	-- autocmd BufEnter,FocusGained,InsertLeave,WinEnter * RelativeNumber
	-- autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * Number 
	-- augroup END
	-- ]]

	nnoremap ('gz', '<Cmd>call VSCodeNotifyRange("git.revertSelectedRanges", line("."), line("."), 0)<CR>')
	xnoremap ('gz', '<Cmd>call VSCodeNotifyRange("git.revertSelectedRanges", line("v"), line("."), 0)<CR><ESC>')

	noremap ('<leader>', '<Cmd>call VSCodeNotifyVisual("vspacecode.space", 1)<CR>')

	-- nnoremap ('gt', '<Cmd>call VSCodeNotify("workbench.action.showAllEditors")<CR>')
	-- nnoremap ('gT', '<Cmd>call VSCodeNotify("workbench.action.showAllEditorsByMostRecentlyUsed")<CR>')
	nnoremap ('go', '<Cmd>call VSCodeNotify("workbench.action.quickOpen")<CR>')

	-- nnoremap (']c', '<Cmd>call VSCodeNotify("workbench.action.editor.nextChange")<CR>')
	-- nnoremap ('[c', '<Cmd>call VSCodeNotify("workbench.action.editor.previousChange")<CR>')
	-- nnoremap (']e', '<Cmd>call VSCodeNotify("editor.action.marker.next")<CR>')
	-- nnoremap ('[e', '<Cmd>call VSCodeNotify("editor.action.marker.prev")<CR>')

end

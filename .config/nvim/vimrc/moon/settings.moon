require 'common'

-- -------------------------------- settings -----------------------------------

opt.timeoutlen = 500
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
opt.hlsearch = true
opt.clipboard += 'unnamedplus'

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
nmap {'override'}, 'Y', 'y$'
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
-- nmap '<C-Left>', 'B'
-- nmap '<C-Right>', 'W'
-- nmap '<S-Left>', 'b'
-- nmap '<S-Right>', 'w'
-- nmap '<Down>', 'j'
-- nmap '<Up>', 'k'
-- copy to clipboard
vmap '<C-Ins>', '"+y'
nmap '<C-Ins>', '"+yy'
-- paste default register
inoremap '<C-R><C-R>', '<C-R>"'
inoremap '<C-R>\'', '<C-R>+'
-- delete word
imap '<C-BS>', '<C-w>'

imap 'jk', '<Esc>'
imap 'kj', '<Esc>'

-- ------------------------- neovim specific config ----------------------------
if is_nvim!

	-- mappings
	map 'j', 'gj'
	map 'k', 'gk'
	nnoremap '<leader>z', ':MaximizerToggle<CR>'
	vnoremap '<leader>z', ':MaximizerToggle<CR>gv'
	nmap '<leader>w', '<c-w>'

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

	-- monokai = require('monokai')
	-- palette = monokai.pro

	-- monokai.setup {palette: palette, custom_hlgroups: {
	-- 	StatusLine: {
	-- 		fg: palette.orange
	-- 	}}}

	-- cmd [[
	--       let g:sonokai_style = 'shusia'
        -- let g:sonokai_enable_italic = 1
        -- let g:sonokai_disable_italic_comment = 0
        -- colorscheme sonokai
	-- ]]

	-- cmd [[colorscheme minimal-base16]]

	require'kanagawa'.setup {
            overrides: {
                WinSeparator: { fg: "#363646" },
                NeoTreeWinSeparator: { fg: "#16161D", bg: "#16161D" },
                WinBarActive: { fg: "#2A2A37", bg: "#1F1F28" },
                WinBarActiveMuted: { fg: "#666666" },
                WinBarInactiveMuted: { fg: "#444444" },
                WinBarTextActive: { fg: "#7FB4CA", bg: "#2A2A37", bold: true},
                WinBarInactive: { fg: "#2A2A37", bg: "#1F1F28" },
                WinBarTextInactive: { fg: "#7a7a7b", bg: "#2A2A37" },
                Comment: { fg: "#888181" },
                FloatTitle: { fg: "#14141A", bg: "#957FB8", bold: true},
                DressingInputNormalFloat: { bg: "#14141A" },
                DressingInputFloatBorder: { fg: "#14141A", bg: "#14141A" },
                NeoTreeGitUntracked: { link: "NeoTreeGitModified" },
                IndentBlanklineChar: { fg: "#2F2F40" },
                IndentBlanklineContextStart: { bold: true},
                LualineGitAdd: { link: "GitSignsAdd" },
                LualineGitChange: { link: "GitSignsAdd" },
                LualineGitDelete: { link: "GitSignsDelete" },
                NeoTreeNormal: { bg: "#14141A" },
                NeoTreeNormalNC: { bg: "#14141A" },
                TabLine: { fg: "#7a7a7b", bg: "#363646" },
                TabLineFill: { bg: "#1F1F28" },
                TabLineSel: { fg: "#957FB8", bg: "#2A2A37", bold: true},
                TabLineSelSpacing: { fg: "#2A2A37", bg: "#1F1F28"},
                TabLineSpacing: { fg: "#363646", bg: "#1F1F28"},
                TelescopeBorder: { fg: "#1a1a22", bg: "#1a1a22" },
                TelescopeMatching: { underline: true, fg: "#7FB4CA"},
                TelescopeNormal: { bg: "#1a1a22" },
                TelescopePreviewTitle: { fg: "#1a1a22", bg: "#7FB4CA" },
                TelescopePromptBorder: { fg: "#2A2A37", bg: "#2A2A37" },
                TelescopePromptNormal: { fg: "#DCD7BA", bg: "#2A2A37" },
                TelescopePromptPrefix: { fg: "#957FB8", bg: "#2A2A37" },
                TelescopePromptTitle: { fg: "#1a1a22", bg: "#957FB8" },
                TelescopeResultsTitle: { fg: "#1a1a22", bg: "#1a1a22" },
                TelescopeTitle: { bold: true, fg: "#C8C093" },
                Visual: { bg: "#4C566A" },
            },
        }

	cmd [[colorscheme kanagawa]]

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
elseif is_vscode!

	opt.shortmess\append 'F'
	opt.showmode = false
	g.matchup_matchparen_nomode = 'i'

	cmd [[hi QuickScopePrimary guifg=NONE guisp='#afff5f' gui=underline ctermfg=NONE cterm=underline]]
	cmd [[hi QuickScopeSecondary guifg=NONE guisp='#5fffff' gui=underline ctermfg=NONE cterm=underline]]
	
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

	nnoremap 'gz', '<Cmd>call VSCodeNotifyRange("git.revertSelectedRanges", line("."), line("."), 0)<CR>'
	xnoremap 'gz', '<Cmd>call VSCodeNotifyRange("git.revertSelectedRanges", line("v"), line("."), 0)<CR><ESC>'

	noremap '<leader>', '<Cmd>call VSCodeNotifyVisual("vspacecode.space", 1)<CR>'

	-- nnoremap 'gt', '<Cmd>call VSCodeNotify("workbench.action.showAllEditors")<CR>'
	-- nnoremap 'gT', '<Cmd>call VSCodeNotify("workbench.action.showAllEditorsByMostRecentlyUsed")<CR>'
	nnoremap 'go', '<Cmd>call VSCodeNotify("workbench.action.quickOpen")<CR>'

	-- nnoremap ']c', '<Cmd>call VSCodeNotify("workbench.action.editor.nextChange")<CR>'
	-- nnoremap '[c', '<Cmd>call VSCodeNotify("workbench.action.editor.previousChange")<CR>'
	-- nnoremap ']e', '<Cmd>call VSCodeNotify("editor.action.marker.next")<CR>'
	-- nnoremap '[e', '<Cmd>call VSCodeNotify("editor.action.marker.prev")<CR>'

cmd [[
    let g:lightspeed_last_motion = ''
    augroup lightspeed_last_motion
    autocmd!
    autocmd User LightspeedSxEnter let g:lightspeed_last_motion = 'sx'
    autocmd User LightspeedFtEnter let g:lightspeed_last_motion = 'ft'
    augroup end
    " map <expr> ; g:lightspeed_last_motion == 'sx' ? "<Plug>Lightspeed_;_sx" : "<Plug>Lightspeed_;_ft"
    " map <expr> , g:lightspeed_last_motion == 'sx' ? "<Plug>Lightspeed_,_sx" : "<Plug>Lightspeed_,_ft"
    map <expr> ; g:lightspeed_last_motion == 'sx' ? "<Plug>Lightspeed_;_sx" : "<Plug>(clever-f-repeat-forward)"
    map <expr> , g:lightspeed_last_motion == 'sx' ? "<Plug>Lightspeed_,_sx" : "<Plug>(clever-f-repeat-back)"

		map gs <Plug>Lightspeed_omni_s
		]]


vim.keymap.set('n', 'gws', ->
		line_start = vim.fn.line('w0')
		line_end = vim.fn.line('w$')
		print('S:' .. line_start .. ' E:' .. line_end))

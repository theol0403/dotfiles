-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

opt.timeoutlen = 500
opt.whichwrap:append("<>hl[]") -- allow movement between end/start of line
opt.gdefault = true
opt.linebreak = true -- if text should be wrapped at certain characters
opt.clipboard = ""

-- opt.fillchars = [[stl:─,stlnc:─,vert:│]]
-- cmd [[hi StatusLineNC ctermbg=NONE guibg=NONE guifg=#696769]]
-- cmd [[hi StatusLine ctermbg=NONE guibg=NONE guifg=#FC9867 gui=NONE cterm=NONE ctermfg=5]]
-- cmd [[hi VertSplit ctermbg=NONE guibg=NONE,bright]]

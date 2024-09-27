-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.opt.timeoutlen = 500
vim.opt.whichwrap:append("<>hl[]") -- allow movement between end/start of line
vim.opt.gdefault = true
vim.opt.linebreak = true -- if text should be wrapped at certain characters
vim.opt.clipboard = ""
vim.opt.inccommand = "split"

-- opt.fillchars = [[stl:─,stlnc:─,vert:│]]
-- cmd [[hi StatusLineNC ctermbg=NONE guibg=NONE guifg=#696769]]
-- cmd [[hi StatusLine ctermbg=NONE guibg=NONE guifg=#FC9867 gui=NONE cterm=NONE ctermfg=5]]
-- cmd [[hi VertSplit ctermbg=NONE guibg=NONE,bright]]

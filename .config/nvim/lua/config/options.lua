-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.opt.gdefault = true
vim.opt.inccommand = "split"
vim.o.clipboard = ""

vim.o.guifont = "JetBrainsMono Nerd Font:h10"
vim.g.neovide_hide_mouse_when_typing = true
vim.g.experimental_layer_grouping = true
vim.g.neovide_cursor_smooth_blink = true
vim.g.neovide_remember_window_size = true
vim.g.neovide_text_gamma = 0.8
vim.g.neovide_text_contrast = 0.1

vim.opt.guicursor:append("t:ver25")

-- vim.g.lazyvim_blink_main = true

vim.g.ai_cmp = false

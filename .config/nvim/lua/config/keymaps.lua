-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- map helpers
local bind = function(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { remap = true })
end
local nobind = function(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { remap = false })
end
local map = function(...)
  bind({ "n", "v", "o" }, ...)
end
local noremap = function(...)
  nobind({ "n", "v", "o" }, ...)
end
local nmap = function(...)
  bind("n", ...)
end
local nnoremap = function(...)
  nobind("n", ...)
end
local imap = function(...)
  bind("i", ...)
end
local inoremap = function(...)
  nobind("i", ...)
end
local omap = function(...)
  bind("o", ...)
end
local onoremap = function(...)
  nobind("o", ...)
end
local xmap = function(...)
  bind("x", ...)
end
local xnoremap = function(...)
  nobind("x", ...)
end
local vmap = function(...)
  bind("v", ...)
end
local vnoremap = function(...)
  nobind("v", ...)
end
local tmap = function(...)
  bind("t", ...)
end
local tnoremap = function(...)
  nobind("t", ...)
end

-- swap soft eol
noremap("0", "^")
noremap("^", "0")

imap("<C-BS>", "<C-w>")

imap("jk", "<Esc>")
imap("kj", "<Esc>")

map("<C-S>", ":wall<CR><ESC>")
imap("<C-S>", "<ESC>:wall<CR>")

-- -- ------------------------- neovim specific config ----------------------------
if is_nvim() then
  nmap("<leader>w", "<c-w>")

-- ------------------------- vscode specific config ----------------------------
elseif is_vscode() then
  nnoremap("gz", '<Cmd>call VSCodeNotifyRange("git.revertSelectedRanges", line("."), line("."), 0)<CR>')
  xnoremap("gz", '<Cmd>call VSCodeNotifyRange("git.revertSelectedRanges", line("v"), line("."), 0)<CR><ESC>')

  noremap("<leader>", '<Cmd>call VSCodeNotifyVisual("vspacecode.space", 1)<CR>')

  -- nnoremap ('gt', '<Cmd>call VSCodeNotify("workbench.action.showAllEditors")<CR>')
  -- nnoremap ('gT', '<Cmd>call VSCodeNotify("workbench.action.showAllEditorsByMostRecentlyUsed")<CR>')
  nnoremap("go", '<Cmd>call VSCodeNotify("workbench.action.quickOpen")<CR>')

  -- nnoremap (']c', '<Cmd>call VSCodeNotify("workbench.action.editor.nextChange")<CR>')
  -- nnoremap ('[c', '<Cmd>call VSCodeNotify("workbench.action.editor.previousChange")<CR>')
  -- nnoremap (']e', '<Cmd>call VSCodeNotify("editor.action.marker.next")<CR>')
  -- nnoremap ('[e', '<Cmd>call VSCodeNotify("editor.action.marker.prev")<CR>')
end

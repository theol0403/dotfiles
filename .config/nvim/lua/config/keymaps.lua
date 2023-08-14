-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- map helpers
-- stylua: ignore start
local bind = function(mode, lhs, rhs) map(mode, lhs, rhs, { remap = true }) end
local nobind = function(mode, lhs, rhs) map(mode, lhs, rhs, { remap = false }) end
local noremap = function(...) nobind({ "n", "v", "o" }, ...) end
local nmap = function(...) bind("n", ...) end
local nnoremap = function(...) nobind("n", ...) end
local imap = function(...) bind("i", ...) end
local inoremap = function(...) nobind("i", ...) end
local omap = function(...) bind("o", ...) end
local onoremap = function(...) nobind("o", ...) end
local xmap = function(...) bind("x", ...) end
local xnoremap = function(...) nobind("x", ...) end
local vmap = function(...) bind("v", ...) end
local vnoremap = function(...) nobind("v", ...) end
local tmap = function(...) bind("t", ...) end
local tnoremap = function(...) nobind("t", ...) end
-- stylua: ignore end

-- swap soft eol
noremap("0", "^")
noremap("^", "0")

imap("<C-BS>", "<C-w>")

-- imap("jk", "<Esc>")
-- imap("kj", "<Esc>")

nmap("<C-S>", ":wall<CR><ESC>")
imap("<C-S>", "<ESC>:wall<CR>")

-- better indent
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- buffers
if Util.has("bufferline.nvim") then
  map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
  map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
else
  map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
  map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
end
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- windows
nmap("<leader>w", "<C-W>", { desc = "Window" })
map("n", "<C-W>w", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<C-W>d", "<C-W>c", { desc = "Delete window", remap = true })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- -- ------------------------- neovim specific config ----------------------------
if not vim.g.vscode then
  -- better up/down
  map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
  map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

  -- lazy
  map("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

  -- new file
  map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

  map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
  map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

  if not Util.has("trouble.nvim") then
    map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
    map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
  end

  -- lazygit
  map("n", "<leader>gg", function()
    Util.float_term({ "lazygit" }, { cwd = Util.get_root(), esc_esc = false, ctrl_hjkl = false })
  end, { desc = "Lazygit (root dir)" })
  map("n", "<leader>gG", function()
    Util.float_term({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false })
  end, { desc = "Lazygit (cwd)" })

  -- floating terminal
  local lazyterm = function()
    Util.float_term(nil, { cwd = Util.get_root() })
  end
  map("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
  map("n", "<leader>fT", function()
    Util.float_term()
  end, { desc = "Terminal (cwd)" })
  map("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
  map("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

  -- Terminal Mappings
  map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
  map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
  map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
  map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
  map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
  map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
  map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- ------------------------- vscode specific config ----------------------------
else
  nnoremap("gz", '<Cmd>call VSCodeCall("git.revertSelectedRanges")<CR>')
  xnoremap("gz", '<Cmd>call VSCodeCall("git.revertSelectedRanges")<CR><ESC>')

  noremap("\\", '<Cmd>call VSCodeNotify("vspacecode.space", 1)<CR>')

  -- nnoremap ('gt', '<Cmd>call VSCodeNotify("workbench.action.showAllEditors")<CR>')
  -- nnoremap ('gT', '<Cmd>call VSCodeNotify("workbench.action.showAllEditorsByMostRecentlyUsed")<CR>')
  nnoremap("go", '<Cmd>call VSCodeNotify("workbench.action.quickOpen")<CR>')

  -- nnoremap (']c', '<Cmd>call VSCodeNotify("workbench.action.editor.nextChange")<CR>')
  -- nnoremap ('[c', '<Cmd>call VSCodeNotify("workbench.action.editor.previousChange")<CR>')
  -- nnoremap (']e', '<Cmd>call VSCodeNotify("editor.action.marker.next")<CR>')
  -- nnoremap ('[e', '<Cmd>call VSCodeNotify("editor.action.marker.prev")<CR>')
end

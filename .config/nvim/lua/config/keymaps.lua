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

-- save
nmap("<C-S>", ":wall<CR><ESC>")
imap("<C-S>", "<ESC>:wall<CR>")

nmap("<leader>fs", "<cmd>w<cr>", { desc = "Save file" })
nmap("<leader>fa", "<cmd>wall<cr>", { desc = "Save all files" })

nmap("<leader>rr", ":%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>", { desc = "Rename word under cursor" })
vmap(
	"<leader>rr",
	[["sy:<C-u>%s/\<<C-r>=escape(@s, '/\')<CR>\>//gI<Left><Left><Left>]],
	{ noremap = true, silent = true, desc = "Rename selected text" }
)

--TODO: switch to vim.keymap.set and incorporate
-- vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])

-- ------------------------- vscode specific config ----------------------------
if vim.g.vscode then
	-- vim.cmd("set clipboard+=unnamedplus")
	vim.g.clipboard = vim.g.vscode_clipboard
	vim.notify = require("vscode-neovim").notify

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

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
local xnoremap = function(...) nobind("x", ...) end
local vmap = function(...) bind("v", ...) end
-- stylua: ignore end

-- save
nmap("<C-S>", ":wall<CR><ESC>")
imap("<C-S>", "<ESC>:wall<CR>")

--- swap soft eol
noremap("0", "^")
noremap("^", "0")

nmap("<leader>fs", "<cmd>w<cr>", { desc = "Save file" })
nmap("<leader>fa", "<cmd>wall<cr>", { desc = "Save all files" })

nmap("<leader>rr", ":%s/\\<<C-r><C-w>\\>//I<Left><Left>", { desc = "Rename word under cursor" })
vmap(
	"<leader>rr",
	[["sy:<C-u>%s/\<<C-r>=escape(@s, '/\')<CR>\>//I<Left><Left>]],
	{ noremap = true, silent = true, desc = "Rename selected text" }
)

--TODO: switch to vim.keymap.set and incorporate
-- vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.cmd([[nnoremap <silent> - <Cmd>Neotree<CR>]])

-- ------------------------- vscode specific config ----------------------------
if vim.g.vscode then
	local vscode = require("vscode")

	-- vim.cmd("set clipboard+=unnamedplus")
	vim.g.clipboard = vim.g.vscode_clipboard
	vim.notify = require("vscode-neovim").notify

	nnoremap("gz", '<Cmd>call VSCodeCall("git.revertSelectedRanges")<CR>')
	xnoremap("gz", '<Cmd>call VSCodeCall("git.revertSelectedRanges")<CR><ESC>')
	noremap("\\", '<Cmd>call VSCodeNotify("vspacecode.space", 1)<CR>')

	-- nnoremap ('gt', '<Cmd>call VSCodeNotify("workbench.action.showAllEditors")<CR>')
	-- nnoremap ('gT', '<Cmd>call VSCodeNotify("workbench.action.showAllEditorsByMostRecentlyUsed")<CR>')
	nnoremap("go", '<Cmd>call VSCodeNotify("workbench.action.quickOpen")<CR>')

	nnoremap("]h", '<Cmd>call VSCodeNotify("workbench.action.editor.nextChange")<CR>')
	nnoremap("[h", '<Cmd>call VSCodeNotify("workbench.action.editor.previousChange")<CR>')
	nnoremap("]e", '<Cmd>call VSCodeNotify("editor.action.marker.next")<CR>')
	nnoremap("[e", '<Cmd>call VSCodeNotify("editor.action.marker.prev")<CR>')

	vim.keymap.set({ "n", "x", "i" }, "<C-d>", function()
		vscode.with_insert(function()
			vscode.action("editor.action.addSelectionToNextFindMatch")
		end)
	end)

	vim.keymap.set({ "n", "x", "i" }, "<C-S-L>", function()
		vscode.with_insert(function()
			vscode.action("editor.action.selectHighlights")
		end)
	end)

	vim.cmd(
		[[nnoremap <silent> - <Cmd>lua require('vscode-neovim').call('workbench.files.action.showActiveFileInExplorer')<CR>]]
	)

	vim.cmd([[map <leader>w <c-w>]])

	vim.cmd([[unmap u]])
	vim.cmd([[unmap <C-r>]])
end

-- terminal copy/paste
vim.keymap.set("v", "<C-S-c>", '"+y') -- Copy visual mode
vim.keymap.set("n", "<C-S-c>", '"+yy') -- Copy normal mode
vim.keymap.set({ "n", "v" }, "<C-S-v>", '"+P') -- Paste
vim.keymap.set("c", "<C-S-v>", "<C-R>+") -- Paste command mode
vim.keymap.set("i", "<C-S-v>", "<C-R><C-O>+") -- Paste insert mode

-- macos copy/paste
vim.keymap.set("v", "<D-c>", '"+y') -- Copy visual mode
vim.keymap.set("n", "<D-c>", '"+yy') -- Copy normal mode
vim.keymap.set({ "n", "v" }, "<D-v>", '"+P') -- Paste
vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
vim.keymap.set("i", "<D-v>", "<C-R><C-O>+") -- Paste insert mode

if vim.g.neovide then
	vim.keymap.set({ "n", "v" }, "<A-h>", "<C-w>h")
	vim.keymap.set({ "n", "v" }, "<A-l>", "<C-w>l")
	vim.keymap.set({ "n", "v" }, "<A-j>", "<C-w>j")
	vim.keymap.set({ "n", "v" }, "<A-k>", "<C-w>k")

	vim.keymap.set("n", "<D-n>", function()
		vim.fn.jobstart("cd ~ && neovide --fork")
	end, { silent = true })
end

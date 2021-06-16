-- set up packer
export packer = require('packer')

-- helper aliases
export cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
export fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
export g = vim.g      -- a table to access global variables
export opt = vim.opt  -- to set options

-- set up vscode-neovim helpers
export is_vscode = -> vim.g.vscode == 1
export is_nvim = -> vim.g.vscode == nil
export firenvim = -> vim.g.started_by_firenvim == 1

export use = (plugin, args) ->
	plugin = {plugin} if type(plugin) == 'string'
	plugin = vim.tbl_extend('force', plugin, args) if args
	packer.use plugin

export use_vscode = (plugin, args) ->
	plugin = {plugin} if type(plugin) == 'string'
	plugin = vim.tbl_extend('keep', plugin, cond: is_vscode)
	use plugin, args

export use_nvim = (plugin, args) ->
	plugin = {plugin} if type(plugin) == 'string'
	plugin = vim.tbl_extend('keep', plugin, cond: is_nvim)
	use plugin, args

-- map helpers
export map = (...) -> vimp.rbind 'nvo', ...
export noremap = (...) -> vimp.bind 'nvo', ...
export nmap = vimp.nmap
export nnoremap = vimp.nnoremap
export imap = vimp.imap
export inoremap = vimp.inoremap
export omap = vimp.omap
export onoremap = vimp.onoremap
export xmap = vimp.xmap
export xnoremap = vimp.xnoremap
export vmap = vimp.vmap
export vnoremap = vimp.vnoremap
export tmap = vimp.tmap
export tnoremap = vimp.tnoremap


-- helper aliases
cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
g = vim.g -- a table to access global variables
opt = vim.opt -- to set options

-- set up vscode-neovim helpers
is_vscode = function()
  return vim.g.vscode == 1
end
firenvim = function()
  return vim.g.started_by_firenvim == 1
end
is_nvim = function()
  return (not is_vscode()) and (not firenvim())
end

-- simplify syntax for plugins incompatible with vscode-neovim
nvim_only = function(plugin)
  if type(plugin) == "string" then
    plugin = { plugin }
  end
  plugin = vim.tbl_extend("keep", plugin, { cond = is_nvim })
  return plugin
end
nvim = nvim_only

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

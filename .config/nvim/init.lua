-- set up packer
vim.cmd [[packadd packer.nvim]]
local packer = require('packer')

packer.init()

-- plugins
packer.use 'wbthomason/packer.nvim'
packer.use 'svermeulen/vimpeccable'

require('plugins')
require('settings')


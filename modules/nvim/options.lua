

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.clipboard = 'unnamedplus'

vim.o.number = true
vim.o.relativenumber = true

vim.o.signcolumn = 'yes'

vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.updatetime = 250

vim.o.termguicolors = true

vim.o.mouse = 'a'

vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.breakindent = true
vim.opt.showmode = false

vim.opt.list = true
vim.opt.inccommand = 'split'
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.cursorline = true
vim.opt.scrolloff = 10

vim.opt.hlsearch = true
require('mini.surround').setup()
require('mini.pairs').setup()
require('mini.comment').setup()
require('mini.ai').setup()
require('mini.bracketed').setup()



vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
require('which-key').setup()

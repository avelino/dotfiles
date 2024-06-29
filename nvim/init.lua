-- Rafael Bodill's fork Neovim entry-point
-- credit https://github.com/rafi/vim-config

local stdconfig = vim.fn.stdpath('config')
local lazy_override = stdconfig .. '/lua/config/lazy.lua'

vim.uv = vim.uv or vim.loop

require('config.lazy')

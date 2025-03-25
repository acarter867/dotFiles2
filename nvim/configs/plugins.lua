
-- plugins.lua

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Use a protected call to avoid errors
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Let packer manage itself
  use 'catppuccin/nvim' -- Catppuccin theme
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-buffer' -- Buffer completions
  use 'hrsh7th/cmp-path' -- Path completions
  use 'hrsh7th/cmp-cmdline' -- Command-line completions
  use 'saadparwaiz1/cmp_luasnip' -- Snippet completions
  use 'L3MON4D3/LuaSnip' -- Snippet engine
  use 'rafamadriz/friendly-snippets' -- Snippets collection
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use 'williamboman/mason.nvim' -- LSP server manager
  use 'williamboman/mason-lspconfig.nvim' -- Bridges mason and lspconfig
  use 'vim-airline/vim-airline'
  use 'preservim/nerdtree'
  use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end}
  use 'junegunn/fzf.vim'
  use 'xiyaowong/transparent.nvim'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use 'ThePrimeagen/harpoon'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Setup nvim-autopairs
require('nvim-autopairs').setup{}

-- Integrate nvim-autopairs with nvim-cmp
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

-- Automatically set filetype to javascriptreact for .js files
vim.cmd([[
  autocmd BufRead,BufNewFile *.js set filetype=javascriptreact
]])

  -- Setup nvim-ts-autotag
  require('nvim-ts-autotag').setup()

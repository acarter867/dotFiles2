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

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Let packer manage itself
  
-- Example themes
use 'morhetz/gruvbox'
use 'joshdick/onedark.vim'
use 'sainnhe/everforest'
  -- Your plugins go here
  use {'neoclide/coc.nvim', branch = 'release'}
  use 'vim-airline/vim-airline'
  use 'preservim/nerdtree'
  use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end}
  use 'junegunn/fzf.vim'
  use 'xiyaowong/transparent.nvim'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'dracula/vim' -- Adding Dracula theme
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'windwp/nvim-autopairs' -- Adding nvim-autopairs
  use 'ThePrimeagen/harpoon' -- Adding Harpoon

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- General settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.clipboard = 'unnamedplus'
vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')
if vim.fn.has('termguicolors') then
  vim.o.termguicolors = true
end

-- Key mappings for vim-mode
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<leader>w', ':w!<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>q', ':q!<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>x', ':x!<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>f', ':Files<CR>', {silent = true})

-- Buffer navigation
vim.api.nvim_set_keymap('n', '<S-h>', ':bprevious<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<S-l>', ':bnext<CR>', {silent = true})

-- Split navigation
vim.api.nvim_set_keymap('n', '<leader>v', ':vsplit<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>s', ':split<CR>', {silent = true})

-- Pane navigation
vim.api.nvim_set_keymap('n', '<leader>h', ':wincmd h<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>j', ':wincmd j<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>k', ':wincmd k<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>l', ':wincmd l<CR>', {silent = true})

-- Close pane
vim.api.nvim_set_keymap('n', '<C-q>', ':q<CR>', { noremap = true, silent = true })

-- Move lines
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", {silent = true})
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", {silent = true})

-- Comment lines
vim.api.nvim_set_keymap('n', '<leader>c', ':Commentary<CR>', {silent = true})
vim.api.nvim_set_keymap('v', '<leader>c', ':Commentary<CR>', {silent = true})

-- Fuzzy Finder key mappings
vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-f>', ':Rg<CR>', {silent = true})

-- NERDTree settings
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>n', ':NERDTreeFind<CR>', {silent = true})

-- Close vim if the only window left is a NERDTree
vim.api.nvim_exec([[
    autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | q | endif
]], false)

-- Coc.nvim configuration
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {silent = true, expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {silent = true, expr = true})
vim.api.nvim_set_keymap('i', '<CR>', [[coc#pum#visible() ? coc#pum#confirm() : "\<CR>"]], {silent = true, expr = true, noremap = true})

-- Coc extensions
vim.g.coc_global_extensions = {'coc-tsserver', 'coc-json', 'coc-html', 'coc-css'}

-- Key mappings for Coc.nvim
vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', {})
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', {})
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', {})
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', {})

-- Enable transparent background
vim.g.transparent_enabled = true

-- List of groups that should be transparent
vim.g.transparent_groups = {
  'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier', 'Statement',
  'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function', 'Conditional',
  'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText', 'SignColumn', 'CursorLineNr',
  'EndOfBuffer'
}

-- Additional settings to customize transparency
vim.api.nvim_exec([[
  autocmd VimEnter * hi Normal guibg=NONE ctermbg=NONE
]], false)

-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  ensure_installed = {"bash", "c", "cpp", "css", "html", "javascript", "json", "lua", "python", "typescript", "vim"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- Set Dracula colorscheme
vim.cmd('colorscheme dracula')

-- Telescope key mappings
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { noremap = true, silent = true })

-- Copy to system clipboard
vim.opt.clipboard:append("unnamedplus")
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true })

-- Telescope configuration
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-d>"] = require('telescope.actions').select_vertical,
        ["<C-s>"] = require('telescope.actions').select_horizontal,
      },
      n = {
        ["<C-d>"] = require('telescope.actions').select_vertical,
        ["<C-s>"] = require('telescope.actions').select_horizontal,
      },
    },
  },
}

-- nvim-autopairs configuration
require('nvim-autopairs').setup{}

-- Harpoon configuration
require("harpoon").setup({
  menu = {
    width = vim.api.nvim_win_get_width(0) - 4,
  }
})

-- Harpoon key mappings
vim.api.nvim_set_keymap('n', '<leader>a', ':lua require("harpoon.mark").add_file()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>e', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>1', ':lua require("harpoon.ui").nav_file(1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>2', ':lua require("harpoon.ui").nav_file(2)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>3', ':lua require("harpoon.ui").nav_file(3)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>4', ':lua require("harpoon.ui").nav_file(4)<CR>', { noremap = true, silent = true })
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

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Let packer manage itself
  
  -- Your plugins go here
  use {'neoclide/coc.nvim', branch = 'release'}
  use 'vim-airline/vim-airline'
  use 'preservim/nerdtree'
  use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end}
  use 'junegunn/fzf.vim'
  use 'xiyaowong/transparent.nvim'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'dracula/vim' -- Adding Dracula theme
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'windwp/nvim-autopairs' -- Adding nvim-autopairs
  use 'ThePrimeagen/harpoon' -- Adding Harpoon

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- General settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.clipboard = 'unnamedplus'
vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')
if vim.fn.has('termguicolors') then
  vim.o.termguicolors = true
end

-- Key mappings for vim-mode
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<leader>w', ':w!<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>q', ':q!<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>x', ':x!<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>f', ':Files<CR>', {silent = true})

-- Buffer navigation
vim.api.nvim_set_keymap('n', '<S-h>', ':bprevious<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<S-l>', ':bnext<CR>', {silent = true})

-- Split navigation
vim.api.nvim_set_keymap('n', '<leader>v', ':vsplit<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>s', ':split<CR>', {silent = true})

-- Pane navigation
vim.api.nvim_set_keymap('n', '<leader>h', ':wincmd h<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>j', ':wincmd j<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>k', ':wincmd k<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>l', ':wincmd l<CR>', {silent = true})

-- Close pane
vim.api.nvim_set_keymap('n', '<C-q>', ':q<CR>', { noremap = true, silent = true })

-- Move lines
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", {silent = true})
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", {silent = true})

-- Comment lines
vim.api.nvim_set_keymap('n', '<leader>c', ':Commentary<CR>', {silent = true})
vim.api.nvim_set_keymap('v', '<leader>c', ':Commentary<CR>', {silent = true})

-- JSON formatter

-- Fuzzy Finder key mappings
vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-f>', ':Rg<CR>', {silent = true})

-- NERDTree settings
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>n', ':NERDTreeFind<CR>', {silent = true})

-- Close vim if the only window left is a NERDTree
vim.api.nvim_exec([[
  autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | q | endif
]], false)

-- Coc.nvim configuration
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {silent = true, expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {silent = true, expr = true})
vim.api.nvim_set_keymap('i', '<CR>', [[coc#pum#visible() ? coc#pum#confirm() : "\<CR>"]], {silent = true, expr = true, noremap = true})

-- Coc extensions
vim.g.coc_global_extensions = {'coc-tsserver', 'coc-json', 'coc-html', 'coc-css'}

-- Key mappings for Coc.nvim
vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', {})
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', {})
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', {})
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', {})

-- Enable transparent background
vim.g.transparent_enabled = true

-- List of groups that should be transparent
vim.g.transparent_groups = {
  'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier', 'Statement',
  'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function', 'Conditional',
  'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText', 'SignColumn', 'CursorLineNr',
  'EndOfBuffer'
}

-- Additional settings to customize transparency
vim.api.nvim_exec([[
  autocmd VimEnter * hi Normal guibg=NONE ctermbg=NONE
]], false)

-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  ensure_installed = {"bash", "c", "cpp", "css", "html", "javascript", "json", "lua", "python", "typescript", "vim"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- Set Dracula colorscheme
vim.cmd('colorscheme dracula')

-- Telescope key mappings
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { noremap = true, silent = true })

-- Copy to system clipboard
vim.opt.clipboard:append("unnamedplus")
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true })

-- Telescope configuration
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-d>"] = require('telescope.actions').select_vertical,
        ["<C-s>"] = require('telescope.actions').select_horizontal,
      },
      n = {
        ["<C-d>"] = require('telescope.actions').select_vertical,
        ["<C-s>"] = require('telescope.actions').select_horizontal,
      },
    },
  },
}

-- nvim-autopairs configuration
require('nvim-autopairs').setup{}

-- Harpoon configuration
require("harpoon").setup({
  menu = {
    width = vim.api.nvim_win_get_width(0) - 4,
  }
})

-- Harpoon key mappings
vim.api.nvim_set_keymap('n', '<leader>a', ':lua require("harpoon.mark").add_file()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>e', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>1', ':lua require("harpoon.ui").nav_file(1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>2', ':lua require("harpoon.ui").nav_file(2)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>3', ':lua require("harpoon.ui").nav_file(3)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>4', ':lua require("harpoon.ui").nav_file(4)<CR>', { noremap = true, silent = true })

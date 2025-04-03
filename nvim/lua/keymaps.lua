-- lua/keymaps.lua

-- Set leader to space
vim.g.mapleader = ' '

-- Write, quit, save-quit
vim.api.nvim_set_keymap('n', '<leader>w', ':w!<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':q!<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>x', ':x!<CR>', { silent = true })

-- Buffer navigation
vim.api.nvim_set_keymap('n', '<S-h>', ':bprevious<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<S-l>', ':bnext<CR>', { silent = true })

-- Splits
vim.api.nvim_set_keymap('n', '<leader>v', ':vsplit<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>s', ':split<CR>', { silent = true })

-- Pane navigation
vim.api.nvim_set_keymap('n', '<leader>h', ':wincmd h<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>j', ':wincmd j<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', ':wincmd k<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', ':wincmd l<CR>', { silent = true })

-- Close pane
vim.api.nvim_set_keymap('n', '<C-q>', ':q<CR>', { noremap = true, silent = true })

-- Move lines (visual mode)
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })

-- Comment lines
vim.api.nvim_set_keymap('n', '<leader>c', ':Commentary<CR>', { silent = true })
vim.api.nvim_set_keymap('v', '<leader>c', ':Commentary<CR>', { silent = true })

-- Fuzzy Finder (fzf) key mappings
vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<C-f>', ':Rg<CR>', { silent = true })

-- nvim-tree toggle & find file
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFile<CR>', { silent = true })


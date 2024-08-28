-- telescope.lua

require('telescope').setup{
  defaults = {
    file_ignore_patterns = {"node_modules", "build"},
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

-- Telescope key mappings
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { noremap = true, silent = true })

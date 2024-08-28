-- settings.lua

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

-- Additional settings to customize transparency
vim.api.nvim_exec([[
  autocmd VimEnter * hi Normal guibg=NONE ctermbg=NONE
]], false)

vim.g.transparent_enabled = true
vim.g.transparent_groups = {
  'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier', 'Statement',
  'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function', 'Conditional',
  'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText', 'SignColumn', 'CursorLineNr',
  'EndOfBuffer'
}

-- Copy to system clipboard
vim.opt.clipboard:append("unnamedplus")

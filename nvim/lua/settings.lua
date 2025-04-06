-- lua/settings.lua

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- Set each "tab" to be 4 spaces
vim.opt.tabstop = 4

-- Indentation amount for auto-indents
vim.opt.shiftwidth = 4

-- Number of spaces that <Tab> inserts
vim.opt.softtabstop = 4


vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

-- Add any other settings you want:
-- vim.opt.ignorecase = true
-- vim.opt.smartcase = true
-- etc.

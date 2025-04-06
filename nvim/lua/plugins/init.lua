-- lua/plugins/init.lua

return {
	-- Pull in the specs from each separate file:
	require("plugins.catppuccin"), -- Catppuccin theme
	require("plugins.nvim-tree"), -- nvim-tree
	unpack(require("plugins.fzf")), -- fzf returns a table with 2 specs
	require("plugins.vim-commentary"), -- commentary###
	require("plugins.lualine"),
	require("plugins.harpoon"),

	require("plugins.lsp_and_cmp"),
	require("plugins.treesitter"),
}

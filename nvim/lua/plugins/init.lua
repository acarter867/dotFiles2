-- lua/plugins/init.lua

return {
  -- Pull in the specs from each separate file:
  require("plugins.catppuccin"),     -- Catppuccin theme
  require("plugins.nvim-tree"),      -- nvim-tree
  unpack(require("plugins.fzf")),    -- fzf returns a table with 2 specs
  require("plugins.vim-commentary"), -- commentary
}


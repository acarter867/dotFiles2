-- lua/plugins/catppuccin.lua

return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = true,
    })
    vim.cmd("colorscheme catppuccin")
    -- True color support recommended
    vim.opt.termguicolors = true
  end,
}


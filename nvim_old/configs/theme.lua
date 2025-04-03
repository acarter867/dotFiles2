-- theme.lua

local catppuccin_ok, catppuccin = pcall(require, "catppuccin")
if catppuccin_ok then
  catppuccin.setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = {
      light = "latte",
      dark = "mocha",
    },
    transparent_background = true,
    show_end_of_buffer = false,
    term_colors = true,
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    no_italic = false,
    no_bold = false,
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
    },
    integrations = {
      treesitter = true,
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      telescope = true,
      notify = false,
      mini = false,
    },
  })
  vim.cmd([[colorscheme catppuccin]])
else
  print("Error loading Catppuccin: " .. catppuccin)
end

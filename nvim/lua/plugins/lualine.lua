-- lua/plugins/lualine.lua

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    -- OPTIONAL: if you want file icons alongside filenames
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("lualine").setup({
      options = {
        -- Pick a theme. "catppuccin" is built-in with catppuccin/nvim >= 2.0
        -- If that doesn't work, you may need to 'require("catppuccin.palettes")'
        -- or check https://github.com/catppuccin/nvim#lualine-integration
        theme = "catppuccin",
        section_separators = { left = "", right = "" }, -- optional
        component_separators = { left = "", right = "" }, -- optional
        icons_enabled = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } }, -- path=1 shows relative path
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      -- You can tweak other sections or tabline if you want
    })
  end,
}


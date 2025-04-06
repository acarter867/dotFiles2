-- lua/plugins/harpoon.lua

return {
  "ThePrimeagen/harpoon",
  dependencies = { "nvim-lua/plenary.nvim" }, -- required dependency
  config = function()
    require("harpoon").setup({
      -- default settings
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
    })
  end,

  -- Optional: define some handy keymaps right here
  keys = {
    {
      "<leader>a",
      function() require("harpoon.mark").add_file() end,
      desc = "Harpoon: Mark this file"
    },
    {
      "<leader>e",
      function() require("harpoon.ui").toggle_quick_menu() end,
      desc = "Harpoon: Toggle quick menu"
    },
    -- For fast navigation to specific marks:
    {
      "<leader>1",
      function() require("harpoon.ui").nav_file(1) end,
      desc = "Harpoon: Go to mark 1"
    },
    {
      "<leader>2",
      function() require("harpoon.ui").nav_file(2) end,
      desc = "Harpoon: Go to mark 2"
    },
    {
      "<leader>3",
      function() require("harpoon.ui").nav_file(3) end,
      desc = "Harpoon: Go to mark 3"
    },
    {
      "<leader>4",
      function() require("harpoon.ui").nav_file(4) end,
      desc = "Harpoon: Go to mark 4"
    },
  },
}



require('nvim-treesitter.configs').setup {
  ensure_installed = {"bash", "c", "cpp", "css", "html", "javascript", "json", "lua", "python", "typescript", "vim"}, -- List of languages you want to ensure are installed
  sync_install = false,  -- Install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "" }, -- List of parsers to ignore installing
  auto_install = true, -- Automatically install missing parsers when entering buffer

  highlight = {
    enable = true, -- false will disable the whole extension
    additional_vim_regex_highlighting = false, -- Set this to true if you have `syntax` enabled in addition to `tree-sitter`
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  indent = {
    enable = true, -- Enable automatic indentation
  },
}

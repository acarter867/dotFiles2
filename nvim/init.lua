
-- Ensure Packer is installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Use a protected call to avoid errors
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Plugins setup
packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Let packer manage itself
  use 'catppuccin/nvim' -- Catppuccin theme

use 'jose-elias-alvarez/null-ls.nvim'

  -- Autocompletion plugins
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-buffer' -- Buffer completions
  use 'hrsh7th/cmp-path' -- Path completions
  use 'hrsh7th/cmp-cmdline' -- Command-line completions
  use 'saadparwaiz1/cmp_luasnip' -- Snippet completions

  -- Snippet engine
  use 'L3MON4D3/LuaSnip' -- Snippet engine
  use 'rafamadriz/friendly-snippets' -- Snippets collection

  -- LSP and other plugins
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use 'williamboman/mason.nvim' -- LSP server manager
  use 'williamboman/mason-lspconfig.nvim' -- Bridges mason and lspconfig

  -- Other plugins
  use 'vim-airline/vim-airline'
  use 'preservim/nerdtree'
  use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end}
  use 'junegunn/fzf.vim'
  use 'xiyaowong/transparent.nvim'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'windwp/nvim-autopairs'
  use 'ThePrimeagen/harpoon'

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Load Catppuccin theme
local catppuccin_ok, catppuccin = pcall(require, "catppuccin")
if catppuccin_ok then
  catppuccin.setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = {
      light = "latte",
      dark = "mocha",
    },
    transparent_background = false,
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





local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier.with({
        extra_args = { "--print-width", "115", "--tab-width", "4", "--single-quote", "--jsx-single-quote" },
    }),
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})



-- General settings
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

-- Key mappings for vim-mode
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<leader>w', ':w!<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>q', ':q!<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>x', ':x!<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>f', ':Files<CR>', {silent = true})

-- Buffer navigation
vim.api.nvim_set_keymap('n', '<S-h>', ':bprevious<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<S-l>', ':bnext<CR>', {silent = true})

-- Split navigation
vim.api.nvim_set_keymap('n', '<leader>v', ':vsplit<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>s', ':split<CR>', {silent = true})

-- Pane navigation
vim.api.nvim_set_keymap('n', '<leader>h', ':wincmd h<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>j', ':wincmd j<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>k', ':wincmd k<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>l', ':wincmd l<CR>', {silent = true})

-- Close pane
vim.api.nvim_set_keymap('n', '<C-q>', ':q<CR>', { noremap = true, silent = true })

-- Move lines
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", {silent = true})
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", {silent = true})

-- Comment lines
vim.api.nvim_set_keymap('n', '<leader>c', ':Commentary<CR>', {silent = true})
vim.api.nvim_set_keymap('v', '<leader>c', ':Commentary<CR>', {silent = true})

-- Fuzzy Finder key mappings
vim.api.nvim_set_keymap('n', '<C-p>', ':Files<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-f>', ':Rg<CR>', {silent = true})

-- NERDTree settings
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<leader>n', ':NERDTreeFind<CR>', {silent = true})

-- nvim-cmp setup
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require('luasnip').expand_or_jumpable() then
        require('luasnip').expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require('luasnip').jumpable(-1) then
        require('luasnip').jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  })
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Setup for lua_ls instead of sumneko_lua
require('lspconfig')['lua_ls'].setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,  -- Disable third-party plugin warnings
      },
    },
  },
}

-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "tsserver", "pyright", "html", "cssls" },  -- Replace sumneko_lua with lua_ls
  automatic_installation = true,
})

-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  ensure_installed = {"bash", "c", "cpp", "css", "html", "javascript", "json", "lua", "python", "typescript", "vim"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- Telescope configuration
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

-- nvim-autopairs configuration
require('nvim-autopairs').setup{}

-- Harpoon configuration
require("harpoon").setup({
  menu = {
    width = vim.api.nvim_win_get_width(0) - 4,
  }
})

-- Harpoon key mappings
vim.api.nvim_set_keymap('n', '<leader>a', ':lua require("harpoon.mark").add_file()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>e', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>1', ':lua require("harpoon.ui").nav_file(1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>2', ':lua require("harpoon.ui").nav_file(2)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>3', ':lua require("harpoon.ui").nav_file(3)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>4', ':lua require("harpoon.ui").nav_file(4)<CR>', { noremap = true, silent = true })

-- Enable transparent background
vim.g.transparent_enabled = true
vim.g.transparent_groups = {
  'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier', 'Statement',
  'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function', 'Conditional',
  'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText', 'SignColumn', 'CursorLineNr',
  'EndOfBuffer'
}

-- Additional settings to customize transparency
vim.api.nvim_exec([[
  autocmd VimEnter * hi Normal guibg=NONE ctermbg=NONE
]], false)

-- Copy to system clipboard
vim.opt.clipboard:append("unnamedplus")
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true })


-- Telescope key mappings
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { noremap = true, silent = true })

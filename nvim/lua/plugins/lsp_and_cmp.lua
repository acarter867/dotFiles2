-- lua/plugins/lsp_and_cmp.lua

return {

  -- 1) Mason: Installs and manages external LSP servers, DAP servers, linters, etc.
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },

  -- 2) mason-lspconfig: Bridges mason and nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        -- ensure_installed = { "lua_ls", "pyright", "rust_analyzer" }, -- for example
      })
    end
  },

  -- 3) nvim-lspconfig: Configures Neovim's built-in LSP client
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-lspconfig.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- When mason-lspconfig is ready, set up servers
      require("mason-lspconfig").setup_handlers({
        function(server_name) 
          require("lspconfig")[server_name].setup({})
        end,
        -- Example: tweak the Lua language server for neovim
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
                workspace = { checkThirdParty = false },
              },
            },
          })
        end,
      })
    end
  },

  -- 4) nvim-cmp: Completion engine
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",  -- load cmp when you enter insert mode
    dependencies = {
      -- nvim-cmp sources
      "hrsh7th/cmp-nvim-lsp",     -- LSP source for nvim-cmp
      "hrsh7th/cmp-buffer",       -- buffer words
      "hrsh7th/cmp-path",         -- file paths
      "hrsh7th/cmp-cmdline",      -- cmdline completions
      -- Snippet engine & its source
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip"
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Load any VSCode-style snippets (optional)
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
          ["<C-e>"] = cmp.mapping.abort(),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })

      -- (Optional) Setup cmdline completion
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end
  },
}


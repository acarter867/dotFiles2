
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier.with({
      extra_args = { "--print-width", "115", "--tab-width", "4", "--single-quote", "--jsx-single-quote" },
    }),
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.goimports,
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

-- Mason and Mason-LSPConfig
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "tsserver", "pyright", "html", "cssls", "gopls" },
  automatic_installation = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

-- Lua LSP setup
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    },
  },
})

-- TS/JS LSP setup
lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- Disable built-in formatting if you want to use prettier in null-ls
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
})

lspconfig.gopls.setup({
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
})

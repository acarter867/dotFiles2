-- lsp.lua

-- Null-ls setup
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

-- LSP setup
local capabilities = require('cmp_nvim_lsp').default_capabilities()

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

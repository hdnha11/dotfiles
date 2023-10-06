local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not status_ok then
  return
end

local lspconfig = require('lspconfig')

local servers = {
  'asm_lsp', -- Assembly (GAS/NASM, GO)
  'clangd', -- C/C++
  'clojure_lsp', -- Clojure
  'cssls', -- CSS
  'dartls', -- Dart
  'fsautocomplete', -- F#
  'gopls', -- Go
  'graphql', -- GraphQL
  'hls', -- Haskell
  'html', -- HTML
  'jdtls', -- Java
  'jsonls', -- JSON
  'lua_ls', -- Lua
  'ocamllsp', -- OCaml
  'pyright', -- Python
  'rust_analyzer', -- Rust
  'solargraph', -- Ruby
  'sqlls', -- SQL
  'svelte', -- Svelte
  'tailwindcss', -- Tailwind CSS
  'tsserver', -- JavaScript/TypeScript
}

lsp_installer.setup {
  ensure_installed = servers
}

for _, server in pairs(servers) do
  local opts = {
    on_attach = require('user.lsp.handlers').on_attach,
    capabilities = require('user.lsp.handlers').capabilities,
  }
  local has_custom_opts, server_custom_opts = pcall(require, 'user.lsp.settings.' .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend('force', server_custom_opts, opts)
  end
  lspconfig[server].setup(opts)
end

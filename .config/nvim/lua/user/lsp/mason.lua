local status_ok, mason = pcall(require, 'mason')
if not status_ok then
  return
end

local mason_lspconfig = require('mason-lspconfig')
local lspconfig = require('lspconfig')

local function merge(tbl1, tbl2)
  local result = {}
  for _, item in pairs(tbl1) do
    table.insert(result, item)
  end
  for _, item in pairs(tbl2) do
    table.insert(result, item)
  end
  return result
end


local auto_install_servers = {
  'asm_lsp',        -- Assembly (GAS/NASM, GO)
  'clangd',         -- C/C++
  'clojure_lsp',    -- Clojure
  'cssls',          -- CSS
  'eslint',         -- ESLint
  'fsautocomplete', -- F#
  'gopls',          -- Go
  'graphql',        -- GraphQL
  'hls',            -- Haskell
  'html',           -- HTML
  'jdtls',          -- Java
  'jsonls',         -- JSON
  'lua_ls',         -- Lua
  'ocamllsp',       -- OCaml
  'pyright',        -- Python
  'rust_analyzer',  -- Rust
  'solargraph',     -- Ruby
  'sqlls',          -- SQL
  'svelte',         -- Svelte
  'tailwindcss',    -- Tailwind CSS
  'tsserver',       -- JavaScript/TypeScript
  'zls',            -- Zig
}

local no_auto_install_servers = {
  'dartls',            -- Dart
  'racket_langserver', -- Racket
}

local servers = merge(auto_install_servers, no_auto_install_servers)

mason.setup {
  ui = {
    border = 'rounded',
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗'
    },
  },
}

mason_lspconfig.setup {
  ensure_installed = auto_install_servers,
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

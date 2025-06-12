local servers = {
  'asm_lsp', -- Assembly (GAS/NASM, GO)
  'bashls', -- Bash
  'clangd', -- C/C++
  'clojure_lsp', -- Clojure
  'cssls', -- CSS
  'dartls', -- Dart
  'dockerls', -- Dockerfile
  'eslint', -- ESLint
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
  'racket_langserver', -- Racket
  'rust_analyzer', -- Rust
  'solargraph', -- Ruby
  'sqlls', -- SQL
  'svelte', -- Svelte
  'tailwindcss', -- Tailwind CSS
  'ts_ls', -- JavaScript/TypeScript
  'yamlls', -- YAML
  'zls', -- Zig
}

for _, server in pairs(servers) do
  vim.lsp.enable(server)
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    -- Buffer-local key mappings
    vim.keymap.set(
      'n',
      'grt',
      '<Cmd>lua vim.lsp.buf.type_definition()<CR>',
      { buffer = args.luf, desc = 'vim.lsp.buf.type_definition()' }
    )
  end,
})

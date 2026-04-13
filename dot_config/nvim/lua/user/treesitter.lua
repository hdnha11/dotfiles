local status_ok, mgr = pcall(require, 'tree-sitter-manager')
if not status_ok then
  return
end

mgr.setup {
  -- Default Options
  ensure_installed = {
    'asm',
    'bash',
    'awk',
    'c',
    'c_sharp',
    'clojure',
    'cmake',
    'cpp',
    'css',
    'csv',
    'dart',
    'diff',
    'dockerfile',
    'fsharp',
    'go',
    'gomod',
    'gosum',
    'gotmpl',
    'gowork',
    'graphql',
    'haskell',
    'hcl',
    'helm',
    'html',
    'java',
    'javadoc',
    'javascript',
    'jq',
    'jsdoc',
    'json',
    'json5',
    'jsx',
    'kitty',
    'latex',
    'llvm',
    'lua',
    'luadoc',
    'make',
    'markdown',
    'mermaid',
    'nasm',
    'nginx',
    'ocaml',
    'php',
    'proto',
    'python',
    'r',
    'racket',
    'regex',
    'ruby',
    'rust',
    'scheme',
    'sql',
    'tmux',
    'toml',
    'typescript',
    'vim',
    'vimdoc',
    'xml',
    'yaml',
    'zig',
    'zsh',
  }, -- list of parsers to install at the start of a neovim session
  border = 'rounded', -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
  auto_install = true, -- if enabled, install missing parsers when editing a new file
  highlight = true, -- treesitter highlighting is enabled by default
  -- languages = {}, -- override or add new parser sources
  -- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
  -- query_dir = vim.fn.stdpath("data") .. "/site/queries",
}

require('ts_context_commentstring').setup {
  enable_autocmd = false,
}

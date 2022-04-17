local status_ok, toggleterm = pcall(require, 'toggleterm')
if not status_ok then
  return
end

toggleterm.setup {
  size = 20,
  open_mapping = [[<C-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = 'float',
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = 'curved',
    winblend = 0,
    highlights = {
      border = 'Normal',
      background = 'Normal',
    },
  },
}

function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(0, 't', '<Esc>', [[<C-\><C-n>]], opts)
end

vim.cmd [[autocmd! TermOpen term://* lua set_terminal_keymaps()]]

local Terminal = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new { cmd = 'lazygit', hidden = true }

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

local tig = Terminal:new { cmd = 'tig', hidden = true }

function _TIG_TOGGLE()
  tig:toggle()
end

local htop = Terminal:new { cmd = 'htop', hidden = true }

function _HTOP_TOGGLE()
  htop:toggle()
end

local node = Terminal:new {
  cmd = 'node',
  count = 2,
  direction = 'horizontal',
}

function _NODE_TOGGLE()
  node:toggle()
end

local python = Terminal:new {
  cmd = 'python3',
  count = 3,
  direction = 'horizontal',
}

function _PYTHON_TOGGLE()
  python:toggle()
end

local ruby = Terminal:new {
  cmd = 'irb',
  count = 4,
  direction = 'horizontal',
}

function _RUBY_TOGGLE()
  ruby:toggle()
end

local java = Terminal:new {
  cmd = 'jshell',
  count = 5,
  direction = 'horizontal',
}

function _JAVA_TOGGLE()
  java:toggle()
end

local fsharp = Terminal:new {
  cmd = 'dotnet fsi',
  count = 6,
  direction = 'horizontal',
}

function _FSHARP_TOGGLE()
  fsharp:toggle()
end

local racket = Terminal:new {
  cmd = 'racket',
  count = 7,
  direction = 'horizontal',
}

function _RACKET_TOGGLE()
  racket:toggle()
end

local scheme = Terminal:new {
  cmd = 'guile',
  count = 8,
  direction = 'horizontal',
}

function _SCHEME_TOGGLE()
  scheme:toggle()
end

local sml = Terminal:new {
  cmd = 'sml',
  count = 9,
  direction = 'horizontal',
}

function _SML_TOGGLE()
  sml:toggle()
end

local haskell = Terminal:new {
  cmd = 'stack ghci',
  count = 10,
  direction = 'horizontal',
}

function _HASKELL_TOGGLE()
  haskell:toggle()
end

local lua = Terminal:new {
  cmd = 'lua',
  count = 11,
  direction = 'horizontal',
}

function _LUA_TOGGLE()
  lua:toggle()
end

local postscript = Terminal:new {
  cmd = 'gs',
  count = 12,
  direction = 'horizontal',
}

function _POSTSCRIPT_TOGGLE()
  postscript:toggle()
end

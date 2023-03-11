local status_ok, indent_blankline = pcall(require, 'indent_blankline')
if not status_ok then
  return
end

indent_blankline.setup {
  enabled = true,
  char = '▏',
  show_trailing_blankline_indent = false,
  show_first_indent_level = true,
  use_treesitter = true,
  show_current_context = true,
  filetype_exclude = {
    '',
    'NvimTree',
    'Trouble',
    'alpha',
    'checkhealth',
    'dashboard',
    'help',
    'lspinfo',
    'man',
    'neogitstatus',
    'packer',
    'startify',
  },
  context_patterns = {
    '^func',
    '^if',
    '^import',
    'argument_list',
    'arguments',
    'block',
    'catch',
    'class',
    'const_declaration',
    'dictionary',
    'element',
    'else',
    'except',
    'for',
    'jsx_element',
    'jsx_self_closing_element',
    'composite_literal',
    'method',
    'object',
    'operation_type',
    'return',
    'table',
    'try',
    'tuple',
    'type_declaration',
    'var_declaration',
    'while',
    'with',
  },
}
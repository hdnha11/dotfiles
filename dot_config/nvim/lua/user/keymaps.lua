-- Modes
--   normal_mode = 'n'
--   insert_mode = 'i'
--   visual_mode = 'v'
--   visual_block_mode = 'x'
--   term_mode = 't'
--   command_mode = 'c'

local keymap = vim.api.nvim_set_keymap
local function opts(desc)
  return { desc = desc, noremap = true, silent = true }
end

-- Map leader key
keymap('', '<Space>', '<Nop>', opts())
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Normal --
-- Resize with arrows
keymap('n', '<C-Up>', ':resize -2<CR>', opts 'Resize: Up')
keymap('n', '<C-Down>', ':resize +2<CR>', opts 'Resize: Down')
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts 'Resize: Left')
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts 'Resize: Right')

-- Diagnostic
keymap('n', '<Leader>d', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts 'Open Diagnostic Float')
keymap('n', '<Leader>q', '<Cmd>lua vim.diagnostic.setloclist()<CR>', opts 'Show Diagnostic Location List')
keymap(
  'n',
  ']d',
  '<Cmd>lua vim.diagnostic.jump { count = 1, float = true }<CR>',
  opts 'Jump to the next diagnostic in the current buffer'
)
keymap(
  'n',
  '[d',
  '<Cmd>lua vim.diagnostic.jump { count = -1, float = true }<CR>',
  opts 'Jump to the previous diagnostic in the current buffer'
)

-- Navigate buffers
keymap('n', ']b', ':bnext<CR>', opts 'bnext')
keymap('n', '[b', ':bprevious<CR>', opts 'bprevious')

-- Find
keymap('n', '<C-p>', '<Cmd>Telescope find_files<CR>', opts 'Telescope: Find Files')
keymap('n', '<C-n>', '<Cmd>Telescope live_grep<CR>', opts 'Telescope: Live Grep')

-- LSP
-- Workaround: Ruby ftplugin's <C-]> conflicts with Neovim LSP.
-- Preempt `runtime/ftplugin/ruby.vim` by mapping <C-]> to itself *before* ftplugins load.
-- Ref: https://github.com/neovim/neovim/issues/30160
keymap('n', '<C-]>', '<C-]>', opts())

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv', opts 'Indent: Left')
keymap('v', '>', '>gv', opts 'Indent: Right')

-- Move text up and down
keymap('v', '<A-j>', ':m .+1<CR>==', opts 'Move: Down')
keymap('v', '<A-k>', ':m .-2<CR>==', opts 'Move: Up')

-- Visual Block --
-- Move text up and down
keymap('x', 'J', ":move '>+1<CR>gv-gv", opts 'Move: Down')
keymap('x', 'K', ":move '<-2<CR>gv-gv", opts 'Move: Up')
keymap('x', '<A-j>', ":move '>+1<CR>gv-gv", opts 'Move: Down')
keymap('x', '<A-k>', ":move '<-2<CR>gv-gv", opts 'Move: Up')

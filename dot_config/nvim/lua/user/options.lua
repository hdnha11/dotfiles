local options = {
  fileencoding = 'utf-8', -- the encoding written to a file
  backup = false, -- don't create a backup file
  swapfile = false, -- don't create a swapfile
  writebackup = false, -- don't make a backup before overwriting a file
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  incsearch = true, -- show where the pattern when typing
  smartcase = true, -- override 'ignorecase' if pattern contains upper case
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  -- clipboard = 'unnamedplus', -- allows neovim to access the system clipboard
  mouse = 'a', -- allow the mouse to be used in neovim
  undofile = true, -- enable persistent undo
  completeopt = { 'menuone', 'noselect' }, -- mostly just for cmp
  updatetime = 300, -- faster completion (4000ms default)
  timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
  termguicolors = true, -- set term gui colors (most terminals support this)
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  relativenumber = false, -- don't set relative numbered lines
  signcolumn = 'yes', -- always show the sign column, otherwise it would shift the text each time
  scrolloff = 8, -- make some context visible around vertically
  sidescrolloff = 8, -- make some context visible around horizontally
  pumheight = 10, -- pop up menu height
  showmode = false, -- we don't want to see things like -- TERMINAL --
  showtabline = 2, -- always show tabs
  conceallevel = 0, -- so that `` is visible in markdown files
  wrap = true, -- wrap lines longer than the window width
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append 'c'
vim.opt.whichwrap:append '<,>,[,],h,l'
vim.opt.iskeyword:append '-'

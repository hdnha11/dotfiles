local status_ok, which_key = pcall(require, 'which-key')
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true,       -- shows a list of your marks on ' and `
    registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- The presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false,   -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true,      -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true,      -- default bindings on <C-w>
      nav = true,          -- misc bindings to work with windows
      z = true,            -- bindings for folds, spelling and others prefixed with z
      g = true,            -- bindings for prefixed with g
    },
  },
  -- Add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- Override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<Space>"] = "SPC",
    -- ["<CR>"] = "RET",
    -- ["<Tab>"] = "TAB",
  },
  icons = {
    breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
    separator = '➜', -- symbol used between a key and it's label
    group = '+', -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = '<C-d>', -- binding to scroll down inside the popup
    scroll_up = '<C-u>',   -- binding to scroll up inside the popup
  },
  window = {
    border = 'single',        -- none, single, double, shadow
    position = 'bottom',      -- bottom, top
    margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3,                    -- spacing between columns
    align = 'left',                 -- align columns left, center or right
  },
  ignore_missing = true,            -- enable this to hide mappings for which you didn't specify a label
  hidden = {
    '<silent>',
    '<cmd>',
    '<Cmd>',
    '<CR>',
    'call',
    'lua',
    '^:',
    '^ ',
  },                 -- hide mapping boilerplate
  show_help = true,  -- show help message on the command line when the popup is visible
  triggers = 'auto', -- automatically setup triggers
  -- triggers = {"<Leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- List of mode / prefixes that should never be hooked by WhichKey
    -- This is mostly relevant for key maps that start with a native binding
    -- Most people should not need to change this
    i = { 'j', 'k' },
    v = { 'j', 'k' },
  },
}

local mappings = {
  {
    '<Leader>F',
    "<Cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<CR>",
    desc = 'Find Files',
  },
  {
    '<Leader>P',
    "<Cmd>lua require('telescope').extensions.projects.projects()<CR>",
    desc = 'Projects',
  },
  { '<Leader>T', '<Cmd>Telescope live_grep theme=ivy<CR>', desc = 'Find Text' },
  { '<Leader>a', '<Cmd>Alpha<CR>',                         desc = 'Alpha' },
  {
    '<Leader>b',
    "<Cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>",
    desc = 'Buffers',
  },
  { '<Leader>e',  '<Cmd>NvimTreeFindFileToggle<CR>',                         desc = 'Explorer' },
  { '<Leader>h',  '<Cmd>nohlsearch<CR>',                                     desc = 'No Highlight' },
  { '<Leader>q',  '<Cmd>q!<CR>',                                             desc = 'Quit' },
  { '<Leader>w',  '<Cmd>w!<CR>',                                             desc = 'Save' },
  { '<Leader>x',  '<Cmd>Bdelete!<CR>',                                       desc = 'Close Buffer' },

  { '<Leader>g',  group = 'Git' },
  { '<Leader>gR', "<Cmd>lua require 'gitsigns'.reset_buffer()<CR>",          desc = 'Reset Buffer' },
  { '<Leader>gb', '<Cmd>Telescope git_branches<CR>',                         desc = 'Checkout Branch' },
  { '<Leader>gc', '<Cmd>Telescope git_commits<CR>',                          desc = 'Checkout Commit' },
  { '<Leader>gd', '<Cmd>Gitsigns diffthis HEAD<CR>',                         desc = 'Diff' },
  { '<Leader>gg', '<Cmd>lua _LAZYGIT_TOGGLE()<CR>',                          desc = 'Lazygit' },
  { '<Leader>gj', "<Cmd>lua require 'gitsigns'.next_hunk()<CR>",             desc = 'Next Hunk' },
  { '<Leader>gk', "<Cmd>lua require 'gitsigns'.prev_hunk()<CR>",             desc = 'Prev Hunk' },
  { '<Leader>gl', "<Cmd>lua require 'gitsigns'.blame_line()<CR>",            desc = 'Blame' },
  { '<Leader>go', '<Cmd>Telescope git_status<CR>',                           desc = 'Open Changed File' },
  { '<Leader>gp', "<Cmd>lua require 'gitsigns'.preview_hunk()<CR>",          desc = 'Preview Hunk' },
  { '<Leader>gr', "<Cmd>lua require 'gitsigns'.reset_hunk()<CR>",            desc = 'Reset Hunk' },
  { '<Leader>gs', "<Cmd>lua require 'gitsigns'.stage_hunk()<CR>",            desc = 'Stage Hunk' },
  { '<Leader>gu', "<Cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>",       desc = 'Undo Stage Hunk' },

  { '<Leader>l',  group = 'LSP' },
  { '<Leader>lS', '<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>',        desc = 'Workspace Symbols' },
  { '<Leader>la', '<Cmd>lua vim.lsp.buf.code_action()<CR>',                  desc = 'Code Action' },
  { '<Leader>ld', '<Cmd>Telescope lsp_document_diagnostics<CR>',             desc = 'Document Diagnostics' },
  { '<Leader>le', '<Cmd>Telescope quickfix<CR>',                             desc = 'Telescope Quickfix' },
  { '<Leader>lf', '<Cmd>lua vim.lsp.buf.format { async = true }<CR>',        desc = 'Format' },
  { '<Leader>li', '<Cmd>LspInfo<CR>',                                        desc = 'Info' },
  { '<Leader>lj', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>',             desc = 'Next Diagnostic' },
  { '<Leader>lk', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',             desc = 'Prev Diagnostic' },
  { '<Leader>ll', '<Cmd>lua vim.lsp.codelens.run()<CR>',                     desc = 'CodeLens Action' },
  { '<Leader>lm', '<Cmd>Mason<CR>',                                          desc = 'Mason Info' },
  { '<Leader>lq', '<Cmd>lua vim.diagnostic.setloclist()<CR>',                desc = 'Quickfix' },
  { '<Leader>lr', '<Cmd>lua vim.lsp.buf.rename()<CR>',                       desc = 'Rename' },
  { '<Leader>ls', '<Cmd>Telescope lsp_document_symbols<CR>',                 desc = 'Document Symbols' },
  { '<Leader>lw', '<Cmd>Telescope lsp_workspace_diagnostics<CR>',            desc = 'Workspace Diagnostics' },

  { '<Leader>p',  group = 'Packer' },
  { '<Leader>pS', '<Cmd>PackerStatus<CR>',                                   desc = 'Status' },
  { '<Leader>pc', '<Cmd>PackerCompile<CR>',                                  desc = 'Compile' },
  { '<Leader>pi', '<Cmd>PackerInstall<CR>',                                  desc = 'Install' },
  { '<Leader>ps', '<Cmd>PackerSync<CR>',                                     desc = 'Sync' },
  { '<Leader>pu', '<Cmd>PackerUpdate<CR>',                                   desc = 'Update' },

  { '<Leader>s',  group = 'Search' },
  { '<Leader>sC', '<Cmd>Telescope commands<CR>',                             desc = 'Commands' },
  { '<Leader>sM', '<Cmd>Telescope man_pages<CR>',                            desc = 'Man Pages' },
  { '<Leader>sR', '<Cmd>Telescope registers<CR>',                            desc = 'Registers' },
  { '<Leader>sb', '<Cmd>Telescope git_branches<CR>',                         desc = 'Checkout Branch' },
  { '<Leader>sc', '<Cmd>Telescope colorscheme<CR>',                          desc = 'Colorscheme' },
  { '<Leader>sh', '<Cmd>Telescope help_tags<CR>',                            desc = 'Find Help' },
  { '<Leader>sk', '<Cmd>Telescope keymaps<CR>',                              desc = 'Keymaps' },
  { '<Leader>sr', '<Cmd>Telescope oldfiles<CR>',                             desc = 'Open Recent File' },
  { '<Leader>sw', "<Cmd>lua require('telescope.builtin').grep_string()<CR>", desc = 'Word Under Cursor' },

  { '<Leader>t',  group = 'Terminal' },
  { '<Leader>tF', '<Cmd>lua _FSHARP_TOGGLE()<CR>',                           desc = 'F#' },
  { '<Leader>tH', '<Cmd>lua _HASKELL_TOGGLE()<CR>',                          desc = 'Haskell' },
  { '<Leader>tP', '<Cmd>lua _POSTSCRIPT_TOGGLE()<CR>',                       desc = 'Postscript' },
  { '<Leader>tR', '<Cmd>lua _RACKET_TOGGLE()<CR>',                           desc = 'Racket' },
  { '<Leader>tS', '<Cmd>lua _SML_TOGGLE()<CR>',                              desc = 'Standard ML' },
  { '<Leader>tc', '<Cmd>lua _CLOJURE_TOGGLE()<CR>',                          desc = 'Clojure' },
  { '<Leader>tf', '<Cmd>ToggleTerm direction=float<CR>',                     desc = 'Float' },
  { '<Leader>tg', '<Cmd>lua _LAZYGIT_TOGGLE()<CR>',                          desc = 'Lazygit' },
  { '<Leader>th', '<Cmd>ToggleTerm size=10 direction=horizontal<CR>',        desc = 'Horizontal' },
  { '<Leader>tj', '<Cmd>lua _JAVA_TOGGLE()<CR>',                             desc = 'Java' },
  { '<Leader>tl', '<Cmd>lua _LUA_TOGGLE()<CR>',                              desc = 'Lua' },
  { '<Leader>tn', '<Cmd>lua _NODE_TOGGLE()<CR>',                             desc = 'Node' },
  { '<Leader>tp', '<Cmd>lua _PYTHON_TOGGLE()<CR>',                           desc = 'Python' },
  { '<Leader>tr', '<Cmd>lua _RUBY_TOGGLE()<CR>',                             desc = 'Ruby' },
  { '<Leader>ts', '<Cmd>lua _SCHEME_TOGGLE()<CR>',                           desc = 'Scheme' },
  { '<Leader>tt', '<Cmd>lua _HTOP_TOGGLE()<CR>',                             desc = 'Htop' },
  { '<Leader>tv', '<Cmd>ToggleTerm size=80 direction=vertical<CR>',          desc = 'Vertical' },
}

which_key.setup(setup)
which_key.add {
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
  mappings,
}

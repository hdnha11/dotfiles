local status_ok, which_key = pcall(require, 'which-key')
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- The presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <C-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
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
    scroll_up = '<C-u>', -- binding to scroll up inside the popup
  },
  window = {
    border = 'single', -- none, single, double, shadow
    position = 'bottom', -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = 'left', -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
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

local opts = {
  mode = 'n', -- NORMAL mode
  -- prefix: use "<Leader>f" for example for mapping everything related to finding files
  -- the prefix is prepended to every mapping part of `mappings`
  prefix = '<Leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ['a'] = { '<Cmd>Alpha<CR>', 'Alpha' },
  ['b'] = {
    "<Cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>",
    'Buffers',
  },
  ['e'] = { '<Cmd>NvimTreeFindFileToggle<CR>', 'Explorer' },
  ['w'] = { '<Cmd>w!<CR>', 'Save' },
  ['q'] = { '<Cmd>q!<CR>', 'Quit' },
  ['x'] = { '<Cmd>Bdelete!<CR>', 'Close Buffer' },
  ['h'] = { '<Cmd>nohlsearch<CR>', 'No Highlight' },
  ['F'] = {
    "<Cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<CR>",
    'Find Files',
  },
  ['T'] = { '<Cmd>Telescope live_grep theme=ivy<CR>', 'Find Text' },
  ['P'] = { "<Cmd>lua require('telescope').extensions.projects.projects()<CR>", 'Projects' },

  p = {
    name = 'Packer',
    c = { '<Cmd>PackerCompile<CR>', 'Compile' },
    i = { '<Cmd>PackerInstall<CR>', 'Install' },
    s = { '<Cmd>PackerSync<CR>', 'Sync' },
    S = { '<Cmd>PackerStatus<CR>', 'Status' },
    u = { '<Cmd>PackerUpdate<CR>', 'Update' },
  },

  g = {
    name = 'Git',
    g = { '<Cmd>lua _LAZYGIT_TOGGLE()<CR>', 'Lazygit' },
    j = { "<Cmd>lua require 'gitsigns'.next_hunk()<CR>", 'Next Hunk' },
    k = { "<Cmd>lua require 'gitsigns'.prev_hunk()<CR>", 'Prev Hunk' },
    l = { "<Cmd>lua require 'gitsigns'.blame_line()<CR>", 'Blame' },
    p = { "<Cmd>lua require 'gitsigns'.preview_hunk()<CR>", 'Preview Hunk' },
    r = { "<Cmd>lua require 'gitsigns'.reset_hunk()<CR>", 'Reset Hunk' },
    R = { "<Cmd>lua require 'gitsigns'.reset_buffer()<CR>", 'Reset Buffer' },
    s = { "<Cmd>lua require 'gitsigns'.stage_hunk()<CR>", 'Stage Hunk' },
    u = {
      "<Cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>",
      'Undo Stage Hunk',
    },
    o = { '<Cmd>Telescope git_status<CR>', 'Open Changed File' },
    b = { '<Cmd>Telescope git_branches<CR>', 'Checkout Branch' },
    c = { '<Cmd>Telescope git_commits<CR>', 'Checkout Commit' },
    d = {
      '<Cmd>Gitsigns diffthis HEAD<CR>',
      'Diff',
    },
  },

  l = {
    name = 'LSP',
    a = { '<Cmd>lua vim.lsp.buf.code_action()<CR>', 'Code Action' },
    d = {
      '<Cmd>Telescope lsp_document_diagnostics<CR>',
      'Document Diagnostics',
    },
    w = {
      '<Cmd>Telescope lsp_workspace_diagnostics<CR>',
      'Workspace Diagnostics',
    },
    f = { '<Cmd>lua vim.lsp.buf.format { async = true }<CR>', 'Format' },
    i = { '<Cmd>LspInfo<CR>', 'Info' },
    m = { '<Cmd>Mason<CR>', 'Mason Info' },
    j = {
      '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
      'Next Diagnostic',
    },
    k = {
      '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',
      'Prev Diagnostic',
    },
    l = { '<Cmd>lua vim.lsp.codelens.run()<CR>', 'CodeLens Action' },
    q = { '<Cmd>lua vim.diagnostic.setloclist()<CR>', 'Quickfix' },
    r = { '<Cmd>lua vim.lsp.buf.rename()<CR>', 'Rename' },
    s = { '<Cmd>Telescope lsp_document_symbols<CR>', 'Document Symbols' },
    S = {
      '<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>',
      'Workspace Symbols',
    },
    e = { '<Cmd>Telescope quickfix<CR>', 'Telescope Quickfix' },
  },

  s = {
    name = 'Search',
    b = { '<Cmd>Telescope git_branches<CR>', 'Checkout Branch' },
    c = { '<Cmd>Telescope colorscheme<CR>', 'Colorscheme' },
    h = { '<Cmd>Telescope help_tags<CR>', 'Find Help' },
    M = { '<Cmd>Telescope man_pages<CR>', 'Man Pages' },
    r = { '<Cmd>Telescope oldfiles<CR>', 'Open Recent File' },
    R = { '<Cmd>Telescope registers<CR>', 'Registers' },
    k = { '<Cmd>Telescope keymaps<CR>', 'Keymaps' },
    C = { '<Cmd>Telescope commands<CR>', 'Commands' },
    w = { "<Cmd>lua require('telescope.builtin').grep_string()<CR>", 'Word Under Cursor', },
  },

  t = {
    name = 'Terminal',
    f = { '<Cmd>ToggleTerm direction=float<CR>', 'Float' },
    h = { '<Cmd>ToggleTerm size=10 direction=horizontal<CR>', 'Horizontal' },
    v = { '<Cmd>ToggleTerm size=80 direction=vertical<CR>', 'Vertical' },
    t = { '<Cmd>lua _HTOP_TOGGLE()<CR>', 'Htop' },
    g = { '<Cmd>lua _LAZYGIT_TOGGLE()<CR>', 'Lazygit' },
    n = { '<Cmd>lua _NODE_TOGGLE()<CR>', 'Node' },
    p = { '<Cmd>lua _PYTHON_TOGGLE()<CR>', 'Python' },
    r = { '<Cmd>lua _RUBY_TOGGLE()<CR>', 'Ruby' },
    j = { '<Cmd>lua _JAVA_TOGGLE()<CR>', 'Java' },
    F = { '<Cmd>lua _FSHARP_TOGGLE()<CR>', 'F#' },
    R = { '<Cmd>lua _RACKET_TOGGLE()<CR>', 'Racket' },
    s = { '<Cmd>lua _SCHEME_TOGGLE()<CR>', 'Scheme' },
    S = { '<Cmd>lua _SML_TOGGLE()<CR>', 'Standard ML' },
    H = { '<Cmd>lua _HASKELL_TOGGLE()<CR>', 'Haskell' },
    l = { '<Cmd>lua _LUA_TOGGLE()<CR>', 'Lua' },
    P = { '<Cmd>lua _POSTSCRIPT_TOGGLE()<CR>', 'Postscript' },
    c = { '<Cmd>lua _CLOJURE_TOGGLE()<CR>', 'Clojure' },
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)

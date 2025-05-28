local status_ok, wk = pcall(require, 'which-key')
if not status_ok then
  return
end

local setup = {
  -- false | "classic" | "modern" | "helix"
  preset = 'helix',
  -- Delay before showing the popup. Can be a number or a function that returns a number.
  -- number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
  delay = function(ctx)
    return ctx.plugin and 0 or 200
  end,
  -- mapping wk.Mapping
  filter = function(mapping)
    -- example to exclude mappings without a description
    return mapping.desc and mapping.desc ~= ''
  end,
  --- You can add any mappings here, or use `require('which-key').add()` later
  -- wk.Spec
  spec = {},
  -- show a warning when issues were detected with your mappings
  notify = true,
  -- Which-key automatically sets up triggers for your mappings.
  -- But you can disable this and setup the triggers manually.
  -- Check the docs for more info.
  -- wk.Spec
  triggers = {
    { '<auto>', mode = 'nxso' },
  },
  -- Start hidden and wait for a key to be pressed before showing the popup
  -- Only used by enabled xo mapping modes.
  -- ctx { mode: string, operator: string }
  defer = function(ctx)
    return ctx.mode == 'V' or ctx.mode == '<C-V>'
  end,
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    presets = {
      operators = true, -- adds help for operators like d, y, ...
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- wk.Win.opts
  win = {
    -- don't allow the popup to overlap with the cursor
    no_overlap = true,
    -- width = 1,
    -- height = { min = 4, max = 25 },
    -- col = 0,
    -- row = math.huge,
    border = 'none',
    padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
    title = true,
    title_pos = 'center',
    zindex = 1000,
    -- Additional vim.wo and vim.bo options
    bo = {},
    wo = {
      -- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
    },
  },
  layout = {
    width = { min = 20 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
  },
  keys = {
    scroll_down = '<c-d>', -- binding to scroll down inside the popup
    scroll_up = '<c-u>', -- binding to scroll up inside the popup
  },
  -- (string|wk.Sorter)[]
  --- Mappings are sorted using configured sorters and natural sort of the keys
  --- Available sorters:
  --- * local: buffer-local mappings first
  --- * order: order of the items (Used by plugins like marks / registers)
  --- * group: groups last
  --- * alphanum: alpha-numerical first
  --- * mod: special modifier keys last
  --- * manual: the order the mappings were added
  --- * case: lower-case first
  sort = { 'local', 'order', 'group', 'alphanum', 'mod' },
  -- number|fun(node: wk.Node):boolean?
  expand = 0, -- expand groups when <= n mappings
  -- expand = function(node)
  --   return not node.desc -- expand all nodes without a description
  -- end,
  -- Functions/Lua Patterns for formatting the labels
  -- table<string, ({[1]:string, [2]:string}|fun(str:string):string)[]>
  replace = {
    key = {
      function(key)
        return require('which-key.view').format(key)
      end,
      -- { "<Space>", "SPC" },
    },
    desc = {
      { '<Plug>%(?(.*)%)?', '%1' },
      { '^%+', '' },
      { '<[cC]md>', '' },
      { '<[cC][rR]>', '' },
      { '<[sS]ilent>', '' },
      { '^lua%s+', '' },
      { '^call%s+', '' },
      { '^:%s*', '' },
    },
  },
  icons = {
    breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
    separator = '➜', -- symbol used between a key and it's label
    group = '+', -- symbol prepended to a group
    ellipsis = '…',
    -- set to false to disable all mapping icons,
    -- both those explicitly added in a mapping
    -- and those from rules
    mappings = true,
    --- See `lua/which-key/icons.lua` for more details
    --- Set to `false` to disable keymap icons from rules
    -- wk.IconRule[]|false
    rules = {},
    -- use the highlights from mini.icons
    -- When `false`, it will use `WhichKeyIcon` instead
    colors = true,
    -- used by key format
    keys = {
      Up = ' ',
      Down = ' ',
      Left = ' ',
      Right = ' ',
      C = '󰘴 ',
      M = '󰘵 ',
      D = '󰘳 ',
      S = '󰘶 ',
      CR = '󰌑 ',
      Esc = '󱊷 ',
      ScrollWheelDown = '󱕐 ',
      ScrollWheelUp = '󱕑 ',
      NL = '󰌑 ',
      BS = '󰁮',
      Space = '󱁐 ',
      Tab = '󰌒 ',
      F1 = '󱊫',
      F2 = '󱊬',
      F3 = '󱊭',
      F4 = '󱊮',
      F5 = '󱊯',
      F6 = '󱊰',
      F7 = '󱊱',
      F8 = '󱊲',
      F9 = '󱊳',
      F10 = '󱊴',
      F11 = '󱊵',
      F12 = '󱊶',
    },
  },
  show_help = true, -- show a help message in the command line for using WhichKey
  show_keys = true, -- show the currently pressed key and its label as a message in the command line
  -- disable WhichKey for certain buf types and file types.
  disable = {
    ft = {},
    bt = {},
  },
  debug = false, -- enable wk.log in the current directory
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
  { '<Leader>a', '<Cmd>Alpha<CR>', desc = 'Alpha' },
  {
    '<Leader>b',
    "<Cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>",
    desc = 'Buffers',
  },
  { '<Leader>e', '<Cmd>NvimTreeFindFileToggle<CR>', desc = 'Explorer' },
  { '<Leader>h', '<Cmd>nohlsearch<CR>', desc = 'No Highlight' },
  { '<Leader>x', '<Cmd>Bdelete!<CR>', desc = 'Close Buffer' },

  { '<Leader>g', group = 'Git' },
  { '<Leader>gR', "<Cmd>lua require 'gitsigns'.reset_buffer()<CR>", desc = 'Reset Buffer' },
  { '<Leader>gb', '<Cmd>Telescope git_branches<CR>', desc = 'Checkout Branch' },
  { '<Leader>gc', '<Cmd>Telescope git_commits<CR>', desc = 'Checkout Commit' },
  { '<Leader>gd', '<Cmd>Gitsigns diffthis HEAD<CR>', desc = 'Diff' },
  { '<Leader>gg', '<Cmd>lua _LAZYGIT_TOGGLE()<CR>', desc = 'Lazygit' },
  { '<Leader>gj', "<Cmd>lua require 'gitsigns'.next_hunk()<CR>", desc = 'Next Hunk' },
  { '<Leader>gk', "<Cmd>lua require 'gitsigns'.prev_hunk()<CR>", desc = 'Prev Hunk' },
  { '<Leader>gl', "<Cmd>lua require 'gitsigns'.blame_line()<CR>", desc = 'Blame' },
  { '<Leader>go', '<Cmd>Telescope git_status<CR>', desc = 'Open Changed File' },
  { '<Leader>gp', "<Cmd>lua require 'gitsigns'.preview_hunk()<CR>", desc = 'Preview Hunk' },
  { '<Leader>gr', "<Cmd>lua require 'gitsigns'.reset_hunk()<CR>", desc = 'Reset Hunk' },
  { '<Leader>gs', "<Cmd>lua require 'gitsigns'.stage_hunk()<CR>", desc = 'Stage Hunk' },
  { '<Leader>gu', "<Cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>", desc = 'Undo Stage Hunk' },

  { '<Leader>l', group = 'LSP' },
  { '<Leader>lS', '<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>', desc = 'Workspace Symbols' },
  { '<Leader>la', '<Cmd>lua vim.lsp.buf.code_action()<CR>', desc = 'Code Action' },
  { '<Leader>ld', '<Cmd>Telescope lsp_document_diagnostics<CR>', desc = 'Document Diagnostics' },
  { '<Leader>le', '<Cmd>Telescope quickfix<CR>', desc = 'Telescope Quickfix' },
  { '<Leader>lf', '<Cmd>lua vim.lsp.buf.format { async = true }<CR>', desc = 'Format' },
  { '<Leader>li', '<Cmd>LspInfo<CR>', desc = 'Info' },
  { '<Leader>ll', '<Cmd>lua vim.lsp.codelens.run()<CR>', desc = 'CodeLens Action' },
  { '<Leader>lm', '<Cmd>Mason<CR>', desc = 'Mason Info' },
  { '<Leader>lr', '<Cmd>lua vim.lsp.buf.rename()<CR>', desc = 'Rename' },
  { '<Leader>ls', '<Cmd>Telescope lsp_document_symbols<CR>', desc = 'Document Symbols' },
  { '<Leader>lw', '<Cmd>Telescope lsp_workspace_diagnostics<CR>', desc = 'Workspace Diagnostics' },

  { '<Leader>p', group = 'Packer' },
  { '<Leader>pS', '<Cmd>PackerStatus<CR>', desc = 'Status' },
  { '<Leader>pc', '<Cmd>PackerCompile<CR>', desc = 'Compile' },
  { '<Leader>pi', '<Cmd>PackerInstall<CR>', desc = 'Install' },
  { '<Leader>ps', '<Cmd>PackerSync<CR>', desc = 'Sync' },
  { '<Leader>pu', '<Cmd>PackerUpdate<CR>', desc = 'Update' },

  { '<Leader>s', group = 'Search' },
  { '<Leader>sC', '<Cmd>Telescope commands<CR>', desc = 'Commands' },
  { '<Leader>sM', '<Cmd>Telescope man_pages<CR>', desc = 'Man Pages' },
  { '<Leader>sR', '<Cmd>Telescope registers<CR>', desc = 'Registers' },
  { '<Leader>sb', '<Cmd>Telescope git_branches<CR>', desc = 'Checkout Branch' },
  { '<Leader>sc', '<Cmd>Telescope colorscheme<CR>', desc = 'Colorscheme' },
  { '<Leader>sh', '<Cmd>Telescope help_tags<CR>', desc = 'Find Help' },
  { '<Leader>sk', '<Cmd>Telescope keymaps<CR>', desc = 'Keymaps' },
  { '<Leader>sr', '<Cmd>Telescope oldfiles<CR>', desc = 'Open Recent File' },
  { '<Leader>sw', "<Cmd>lua require('telescope.builtin').grep_string()<CR>", desc = 'Word Under Cursor' },

  { '<Leader>t', group = 'Terminal' },
  { '<Leader>tF', '<Cmd>lua _FSHARP_TOGGLE()<CR>', desc = 'F#' },
  { '<Leader>tH', '<Cmd>lua _HASKELL_TOGGLE()<CR>', desc = 'Haskell' },
  { '<Leader>tP', '<Cmd>lua _POSTSCRIPT_TOGGLE()<CR>', desc = 'Postscript' },
  { '<Leader>tR', '<Cmd>lua _RACKET_TOGGLE()<CR>', desc = 'Racket' },
  { '<Leader>tS', '<Cmd>lua _SML_TOGGLE()<CR>', desc = 'Standard ML' },
  { '<Leader>tc', '<Cmd>lua _CLOJURE_TOGGLE()<CR>', desc = 'Clojure' },
  { '<Leader>tf', '<Cmd>ToggleTerm direction=float<CR>', desc = 'Float' },
  { '<Leader>tg', '<Cmd>lua _LAZYGIT_TOGGLE()<CR>', desc = 'Lazygit' },
  { '<Leader>th', '<Cmd>ToggleTerm size=10 direction=horizontal<CR>', desc = 'Horizontal' },
  { '<Leader>tj', '<Cmd>lua _JAVA_TOGGLE()<CR>', desc = 'Java' },
  { '<Leader>tl', '<Cmd>lua _LUA_TOGGLE()<CR>', desc = 'Lua' },
  { '<Leader>tn', '<Cmd>lua _NODE_TOGGLE()<CR>', desc = 'Node' },
  { '<Leader>tp', '<Cmd>lua _PYTHON_TOGGLE()<CR>', desc = 'Python' },
  { '<Leader>tr', '<Cmd>lua _RUBY_TOGGLE()<CR>', desc = 'Ruby' },
  { '<Leader>ts', '<Cmd>lua _SCHEME_TOGGLE()<CR>', desc = 'Scheme' },
  { '<Leader>tt', '<Cmd>lua _HTOP_TOGGLE()<CR>', desc = 'Htop' },
  { '<Leader>tv', '<Cmd>ToggleTerm size=80 direction=vertical<CR>', desc = 'Vertical' },
}

wk.setup(setup)
wk.add {
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
  mappings,
}

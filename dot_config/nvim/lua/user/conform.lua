local conform_status_ok, conform = pcall(require, 'conform')
if not conform_status_ok then
  return
end

conform.setup {
  -- Conform will run multiple formatters sequentially
  formatters_by_ft = {
    c = { 'clang-format' },
    cpp = { 'clang-format' },
    go = { 'gofmt' },
    java = { 'clang-format' },
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
    lua = { 'stylua' },
    python = { 'isort', 'black' },
    ruby = { 'rubyfmt', 'rubocop', stop_after_first = true },
    rust = { 'rustfmt' },
    sh = { 'shfmt' },
    sql = { 'sleek' },
    typescript = { 'prettierd', 'prettier', stop_after_first = true },
  },
}

-- Define a command to run async formatting
vim.api.nvim_create_user_command('Format', function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end
  conform.format { async = true, lsp_format = 'fallback', range = range }
end, { range = true })

-- Key mappings

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap('n', '<Leader>f', '<Cmd>Format<CR>', opts)

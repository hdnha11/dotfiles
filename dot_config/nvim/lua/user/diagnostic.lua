vim.diagnostic.config {
  -- Disable virtual text
  virtual_text = false,
  -- Show signs
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '󰋼',
      [vim.diagnostic.severity.HINT] = '󰌵',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.HINT] = '',
      [vim.diagnostic.severity.INFO] = '',
    },
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    source = true,
    header = '',
    prefix = '',
    border = 'rounded',
  },
}

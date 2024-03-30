local status_ok, ibl = pcall(require, 'ibl')
if not status_ok then
  return
end

ibl.setup {
  enabled = true,
  indent = { char = '▏' },
  whitespace = {
    highlight = { 'Whitespace', 'NonText' },
    remove_blankline_trail = false,
  },
  scope = {
    enabled = true,
    show_start = false,
    show_end = false,
  },
  exclude = {
    filetypes = {
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
  },
}

local status_ok, tabby = pcall(require, 'tabby')
if not status_ok then
  return
end

local filename = require('tabby.filename')

local cwd = function()
  return '  ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t') .. ' '
end

local line = {
  hl = 'TabLineFill',
  layout = 'active_wins_at_tail',
  head = {
    { cwd,   hl = 'UserTLHead' },
    { '', hl = 'UserTLHeadSep' },
  },
  active_tab = {
    label = function(tabid)
      return {
        '  ' .. tabid .. ' ',
        hl = 'UserTLActive',
      }
    end,
    left_sep = { '', hl = 'UserTLActiveSep' },
    right_sep = { '', hl = 'UserTLActiveSep' },
  },
  inactive_tab = {
    label = function(tabid)
      return {
        '  ' .. tabid .. ' ',
        hl = 'UserTLBoldLine',
      }
    end,
    left_sep = { '', hl = 'UserTLLineSep' },
    right_sep = { '', hl = 'UserTLLineSep' },
  },
  top_win = {
    label = function(winid)
      return {
        '  ' .. filename.unique(winid) .. ' ',
        hl = 'TabLine',
      }
    end,
    left_sep = { '', hl = 'UserTLLineSep' },
    right_sep = { '', hl = 'UserTLLineSep' },
  },
  win = {
    label = function(winid)
      return {
        '  ' .. filename.unique(winid) .. ' ',
        hl = 'TabLine',
      }
    end,
    left_sep = { '', hl = 'UserTLLineSep' },
    right_sep = { '', hl = 'UserTLLineSep' },
  },
  tail = {
    { '',   hl = 'UserTLHeadSep' },
    { '  ', hl = 'UserTLHead' },
  },
}

tabby.setup {
  tabline = line,
}

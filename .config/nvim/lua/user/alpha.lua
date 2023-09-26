local status_ok, alpha = pcall(require, 'alpha')
if not status_ok then
  return
end

local function longest_line(tbl)
  local longest = 0
  for _, v in pairs(tbl) do
    local width = vim.fn.strdisplaywidth(v)
    if width > longest then
      longest = width
    end
  end
  return longest
end

local function get_fortune()
  local fortune_status_ok, fortune = pcall(require, 'alpha.fortune')
  if not fortune_status_ok then
    return {}
  end
  return fortune()
end

local function footer()
  local v = vim.version()
  local footer_tbl = get_fortune()

  -- Align center
  local semver = string.format('v%d.%d.%d', v.major, v.minor, v.patch)
  local left = math.floor(longest_line(footer_tbl) / 2) - math.floor(vim.fn.strdisplaywidth(semver) / 2)
  local padding = string.rep(' ', left)
  local centered = padding .. semver

  -- Prepend three empty lines
  for _ = 1, 3 do
    table.insert(footer_tbl, 1, '')
  end

  table.insert(footer_tbl, 2, centered)
  return footer_tbl
end

local dashboard = require('alpha.themes.dashboard')

dashboard.section.header.val = {
  [[                                                     ]],
  [[  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
  [[  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
  [[  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
  [[  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
  [[  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
  [[  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
  [[                                                     ]],
}

dashboard.section.buttons.val = {
  dashboard.button('e', '  Find file', ':Telescope find_files<CR>'),
  dashboard.button('n', '  New file', ':ene <BAR> startinsert<CR>'),
  dashboard.button('p', '  Find project', ':Telescope projects<CR>'),
  dashboard.button('r', '  Recently used files', ':Telescope oldfiles<CR>'),
  dashboard.button('f', '󱎸  Find text', ':Telescope live_grep<CR>'),
  dashboard.button('u', '󰚰  Update plugins', ':PackerSync<CR> :TSUpdate<CR>'),
  dashboard.button('s', '  Language servers', ':LspInstallInfo<CR>'),
  dashboard.button('c', '  Configuration', ':edit ~/.config/nvim/init.lua<CR>'),
  dashboard.button('q', '  Quit Neovim', ':qa<CR>'),
}

dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = 'Type'
dashboard.section.header.opts.hl = 'Include'
dashboard.section.buttons.opts.hl = 'Keyword'
dashboard.opts.opts.noautocmd = true

alpha.setup(dashboard.opts)

local status_ok, bufferline = pcall(require, 'bufferline')
if not status_ok then
  return
end

bufferline.setup {
  options = {
    mode = 'buffers', -- set to "tabs" to only show tabpages instead
    numbers = 'none', -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    close_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
    right_mouse_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
    left_mouse_command = 'buffer %d', -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = false, -- | "nvim_lsp" | "coc",
    diagnostics_update_in_insert = false,
    offsets = { { filetype = 'NvimTree', text = 'Explorer', highlight = 'PannelHeading', padding = 1 } },
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    separator_style = 'thin', -- "slant" | "padded_slant" | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = false,
    always_show_bufferline = false,
    sort_by = 'id',
  },
  highlights = {
    fill                  = {
      guifg = { attribute = 'fg', highlight = '#ff0000' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },
    background            = {
      guifg = { attribute = 'fg', highlight = 'Normal' },
      guibg = { attribute = 'bg', highlight = 'Normal' },
    },
    tab                   = {
      guifg = { attribute = 'fg', highlight = 'Normal' },
      guibg = { attribute = 'bg', highlight = 'Normal' },
    },
    tab_selected          = {
      guifg = { attribute = 'fg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },
    tab_close             = {
      guifg = { attribute = 'fg', highlight = 'TabLineSel' },
      guibg = { attribute = 'bg', highlight = 'Normal' },
    },
    close_button          = {
      guifg = { attribute = 'fg', highlight = 'Normal' },
      guibg = { attribute = 'bg', highlight = 'Normal' },
    },
    close_button_visible  = {
      guifg = { attribute = 'fg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },
    close_button_selected = {
      guifg = { attribute = 'fg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },
    buffer                = {
      guifg = { attribute = 'fg', highlight = 'Normal' },
      guibg = { attribute = 'bg', highlight = 'Normal' },
    },
    buffer_visible        = {
      guifg = { attribute = 'fg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },
    buffer_selected       = {
      guifg = { attribute = 'fg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },
    diagnostic            = {
      guifg = { attribute = 'fg', highlight = 'Normal' },
      guibg = { attribute = 'bg', highlight = 'Normal' },
    },
    diagnostic_visible    = {
      guifg = { attribute = 'fg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },
    diagnostic_selected   = {
      guifg = { attribute = 'fg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },
    modified              = {
      guifg = { attribute = 'fg', highlight = 'Normal' },
      guibg = { attribute = 'bg', highlight = 'Normal' },
    },
    modified_visible      = {
      guifg = { attribute = 'fg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },
    modified_selected     = {
      guifg = { attribute = 'fg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },
    duplicate_selected    = {
      guifg = { attribute = 'fg', highlight = 'TabLineSel' },
      guibg = { attribute = 'bg', highlight = 'TabLineSel' },
      gui = 'italic',
    },
    duplicate_visible     = {
      guifg = { attribute = 'fg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
      gui = 'italic',
    },
    duplicate             = {
      guifg = { attribute = 'fg', highlight = 'Normal' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
      gui = 'italic',
    },
    separator_selected    = {
      guifg = { attribute = 'bg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },
    separator_visible     = {
      guifg = { attribute = 'bg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },
    separator             = {
      guifg = { attribute = 'bg', highlight = 'Normal' },
      guibg = { attribute = 'bg', highlight = 'Normal' },
    },
    pick_selected         = {
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },
    pick_visible          = {
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },
    pick                  = {
      guibg = { attribute = 'bg', highlight = 'Normal' },
    },
    indicator_selected    = {
      guifg = { attribute = 'fg', highlight = 'TabLine' },
      guibg = { attribute = 'bg', highlight = 'TabLine' },
    },
  },
}

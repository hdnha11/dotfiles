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
    indicator_icon = '▐',
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
  highlights = (function()
    local normal_bg = { highlight = 'Normal', attribute = 'bg' }
    local selected_bg = { highlight = 'StatusLineNC', attribute = 'bg' }
    local highlight_bg = { highlight = 'LspDiagnosticsDefaultHint', attribute = 'fg' }

    return {
      background = {
        guibg = normal_bg,
      },
      tab = {
        guibg = normal_bg,
      },
      tab_selected = {
        guibg = selected_bg,
      },
      tab_close = {
        guibg = normal_bg,
      },
      close_button = {
        guibg = normal_bg,
      },
      close_button_visible = {
        guibg = selected_bg,
      },
      close_button_selected = {
        guibg = selected_bg,
      },
      buffer = {
        guibg = normal_bg,
      },
      buffer_visible = {
        guibg = selected_bg,
      },
      buffer_selected = {
        guibg = selected_bg,
      },
      duplicate = {
        guibg = normal_bg,
      },
      duplicate_selected = {
        guibg = selected_bg,
      },
      duplicate_visible = {
        guibg = selected_bg,
      },
      modified = {
        guibg = normal_bg,
      },
      modified_visible = {
        guibg = selected_bg,
      },
      modified_selected = {
        guibg = selected_bg,
      },
      pick = {
        guibg = normal_bg,
      },
      pick_selected = {
        guibg = selected_bg,
      },
      pick_visible = {
        guibg = selected_bg,
      },
      separator = {
        guifg = normal_bg,
        guibg = normal_bg,
      },
      separator_selected = {
        guifg = normal_bg,
        guibg = selected_bg,
      },
      separator_visible = {
        guifg = normal_bg,
        guibg = selected_bg,
      },
      indicator_selected = {
        guifg = highlight_bg,
        guibg = normal_bg,
      },
    }
  end)(),
}

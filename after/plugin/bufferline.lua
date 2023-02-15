require('bufferline').setup({
  options = {
    diagnostics = 'nvim_lsp',
    diagnostics_update_in_insert = false,
    show_buffer_close_icons = false,
    separator_style = 'slant',
    hover = { enabled = false }
  }
})

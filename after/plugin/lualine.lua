-- Set lualine as statusline
-- See `:help lualine.txt`
local vscode = require 'lualine.themes.vscode'
-- local gruvbox = require 'lualine.themes.gruvbox'

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = vscode,
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { {
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 1 -- 1 = just filename, 1 = relative path, 2 = absolute path
    } },
    lualine_x = {
      { 'diagnostics', sources = { "nvim_diagnostic" }, symbols = { error = ' ', warn = ' ', info = ' ',
        hint = ' ' } },
      'encoding',
      'filetype'
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  tabline = {},
  extensions = { 'fugitive' }
}

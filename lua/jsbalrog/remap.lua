vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.keymap.set({'', 'i', 'n', 'v'}, '<Leader>d', '<Esc>') -- Comma + d is escape

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex) -- Netrw directory tree open

-- Capital H goes to start of line, capital L goes to end of line
vim.keymap.set({ 'n' }, 'L', '$')
vim.keymap.set({ 'v' }, 'L', '$h')
vim.keymap.set({ 'n', 'v' }, 'H', '^')

-- Close diff/results/whatever window
vim.keymap.set('n', '<leader>bd', ':wincmd h<CR>:q<CR>')

-- [[ Plugin Remappings ]] --

-- Telescope --
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>?', builtin.oldfiles, {})
vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>fw', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

-- UndoTree --
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Fugitive --
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set('n', '<leader>gw', ':Gwrite<CR>')
vim.keymap.set('n', '<leader>gc', ':Gcommit -v<CR>')
vim.keymap.set('n', '<leader>gp', ':Git push<CR>')
vim.keymap.set('n', '<leader>gu', ':Git pull<CR>')
vim.keymap.set('n', '<leader>gd', ':Gdiff<CR>')
vim.keymap.set('n', '<leader>gpb', ':execute ":Git push origin " . fugitive#head(0)<CR>')
vim.keymap.set('n', '<leader>gub', ':execute ":Git pull --rebase origin " . fugitive#head(0)<CR>')
vim.keymap.set('n', '<leader>gx', ':execute ":Git checkout %"<CR>')

-- Bufferline -- 
-- cycling through buffers/tabs
vim.keymap.set('n', 'th', ':bprev<CR>')
vim.keymap.set('n', 'tl', ':bnext<CR>')
-- moving tabs
vim.keymap.set('n', '<leader>th', ':BufferLineMovePrev<CR>')
vim.keymap.set('n', '<leader>tl', ':BufferLineMoveNext<CR>')

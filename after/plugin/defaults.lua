-- Let's make escape better, together.
vim.keymap.set('', '<Leader>d', '<Esc>')
vim.keymap.set('i', '<Leader>d', '<Esc>')
vim.keymap.set('n', '<Leader>d', '<Esc>')
vim.keymap.set('v', '<Leader>d', '<Esc>')

-- Split window vertically or horizontally *and* switch to the new split!
vim.keymap.set('', '<leader>vs', ':split<Bar>:wincmd j<CR>')
vim.keymap.set('', '<leader>hs', ':vsplit<Bar>:wincmd l<CR>')
-- Window split movements
-- " Here's a visual guide for moving between window splits.
--  4 Window Splits
--  --------
--  g1 | g2
--  ---|----
--  g3 | g4
--  -------
--
--  6 Window Splits
--  -------------
--  g1 | gt | g2
--  ---|----|----
--  g3 | gb | g4
--  -------------
--  Move to window to the left
vim.keymap.set('', 'gh', ':wincmd h<CR>')
-- Move to window below
vim.keymap.set('', 'gj', ':wincmd j<CR>')
-- Move to window above
vim.keymap.set('', 'gk', ':wincmd k<CR>')
-- Move to window to the right
vim.keymap.set('', 'gl', ':wincmd l<CR>')
-- Upper left window
vim.keymap.set('', 'g1', ':wincmd t<CR>')
-- Upper right window
vim.keymap.set('', 'g2', ':wincmd b<Bar>:wincmd k<CR>')
-- Lower left window
vim.keymap.set('', 'g3', ':wincmd t<Bar>:wincmd j<CR>')
-- Lower right window
vim.keymap.set('', 'g4',  ':wincmd b<CR>')
-- Top Middle
vim.keymap.set('', 'gt', 'g2<Bar>:wincmd h<CR>')
-- Bottom Middle
vim.keymap.set('', 'gb', 'g3<Bar>:wincmd l<CR>')

-- Previous Window
vim.keymap.set('', 'gp', ':wincmd p<CR>')
-- Equal Size Windows
vim.keymap.set('', 'g=', ':wincmd =<CR>')
-- Swap Windows
vim.keymap.set('', 'gx', ':wincmd x<CR>')

-- Close the current split
vim.keymap.set('', '<leader>sc', ':hide<CR>')
-- Close the current buffer
vim.keymap.set('', '<leader>x', ':bw<CR>')
-- Go to next buffer
vim.keymap.set('', '<leader>n', ':bnext<CR>')
-- Go to previous buffer
vim.keymap.set('', '<leader>p', ':bprevious<CR>')
-- Moving lines
vim.keymap.set('', '∆', ':m+<CR>==')
vim.keymap.set('', '˚', ':m-2<CR>==')
-- Duplicate current line
vim.keymap.set('i', '<c-d>', '<esc>yypi')
vim.keymap.set('n', '<c-d>', 'yyp')

-- Open the vim explorer to rename/move a file
vim.keymap.set('', '<leader>m', ':Explore<CR>')

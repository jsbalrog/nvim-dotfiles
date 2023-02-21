vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex) -- Netrw directory tree open

vim.keymap.set({ '', 'i', 'n', 'v' }, '<Leader>d', '<Esc>') -- Comma + d is escape

-- [[ Moving ]] --
-- Capital H goes to start of line, capital L goes to end of line
vim.keymap.set({ 'n', 'v' }, 'L', 'g_') -- jump to last non-blank character of the line (use $ to jump to last char, blank or not)
vim.keymap.set({ 'n', 'v' }, 'H', '^')
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- move half window down and up
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- while keeping cursor in same place

-- [[ Editing - Moving lines around, copying/pasting words and stuff ]] --
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- visual mode - move selection down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- visual mode - move selection up
vim.keymap.set("n", "J", "mzJ`z") -- append the line below to current line
vim.keymap.set("x", "<leader>p", "\"_dP") -- retain the initial yank
vim.keymap.set("n", "<leader>y", "\"+y") -- yank into system clipboard
vim.keymap.set("v", "<leader>y", "\"+y") -- "
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("i", "<S-CR>", "<Esc>j$a") -- Shift+Enter moves cursor down to end of next line
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>") -- rename every instance of the word you're on

-- [[ Window Stuff ]] --
-- Prettier format current buffer
vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format()
end)
-- Close diff/results/whatever window
vim.keymap.set('n', '<leader>bd', ':wincmd h<CR>:q<CR>')
-- Close current buffer
vim.keymap.set('n', '<leader>x', ':bw<CR>')
-- Split window vertically or horizontally *and* switch to the new split!
vim.keymap.set('', '<leader>-', ':split<Bar>:wincmd j<CR>')
vim.keymap.set('', '<leader>|', ':vsplit<Bar>:wincmd l<CR>')
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
vim.keymap.set('', 'g4', ':wincmd b<CR>')
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

-- Copy/paste to/from clipboard
-- CTRL-c is copy
vim.keymap.set({ 'v', 'i' }, '<C-c>', '"+y')
-- CTRL-x is cut
vim.keymap.set({ 'v', 'i' }, '<C-x>', '"+x')
-- CTRL-v is paste
vim.keymap.set({ 'v', 'n' }, '<C-v>', '"+gP')
vim.keymap.set({ 'i' }, '<C-v>', '<esc>"+gPa')


-- [[ Plugin Remappings ]] --

-- Telescope --
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>?', builtin.oldfiles, {})
vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
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
vim.keymap.set('n', '<leader>gl', builtin.git_commits, { desc = '[ ] List git commits with diff preview' })
-- UndoTree --
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Fugitive --
vim.keymap.set("n", "<leader>gs", ':below Git<CR>')
vim.keymap.set('n', '<leader>gw', ':Git add %<CR>')
vim.keymap.set('n', '<leader>gc', ':below Git commit -v<CR>')
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

-- Neotree toggle keymaps --
vim.keymap.set({ 'n', 'v' }, '<leader>`', ':Neotree toggle<CR>')
vim.keymap.set({ 'i' }, '<leader>`', '<ESC>:Neotree toggle<CR>')

-- Unimpaired mappings --
-- Bubble single lines is [e and]e
-- Bubble multiple lines
vim.keymap.set('v', '<C-k>', '[egv', { remap = true })
vim.keymap.set('v', '<C-j>', ']egv', { remap = true })

vim.keymap.set("n", "<leader>tt", "<cmd>TroubleToggle<cr>",
	{ silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
	{ silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>",
	{ silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>tl", "<cmd>TroubleToggle loclist<cr>",
	{ silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>tq", "<cmd>TroubleToggle quickfix<cr>",
	{ silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>tr", "<cmd>TroubleToggle lsp_references<cr>",
	{ silent = true, noremap = true }
)

local lsp = require('lsp-zero').preset({
	name = 'recommended',
	set_lsp_keymaps = true,
	manage_nvim_cmp = true,
	suggest_lsp_servers = true,
})

lsp.ensure_installed({
	'clangd',
	'pyright',
	'tsserver',
	'eslint',
	'lua_ls',
	'rust_analyzer',
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	['<C-Space>'] = cmp.mapping.complete(),
})

-- local cmp_kinds = {
-- 	Text = '  ',
-- 	Method = '  ',
-- 	Function = '  ',
-- 	Constructor = '  ',
-- 	Field = '  ',
-- 	Variable = '  ',
-- 	Class = '  ',
-- 	Interface = '  ',
-- 	Module = '  ',
-- 	Property = '  ',
-- 	Unit = '  ',
-- 	Value = '  ',
-- 	Enum = '  ',
-- 	Keyword = '  ',
-- 	Snippet = '  ',
-- 	Color = '  ',
-- 	File = '  ',
-- 	Reference = '  ',
-- 	Folder = '  ',
-- 	EnumMember = '  ',
-- 	Constant = '  ',
-- 	Struct = '  ',
-- 	Event = '  ',
-- 	Operator = '  ',
-- 	TypeParameter = '  ',
-- }

-- ------------------------------------------------- --
-- [[ Autocomplete stuff, including jump mappings ]] --
-- ------------------------------------------------- --
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
keymap("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
	preselect = 'none',
	completion = {
		completeopt = 'menu,menuone,noinsert,noselect',
		-- autocomplete = false
	},
	window = {
		completion = {
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
		},
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. (strings[1] or "") .. " "
			kind.menu = "    (" .. (strings[2] or "") .. ")"

			return kind
		end,
	},
})

-- ---------------------------------------------- --
-- [[ lsp intellisense-type stuff and mappings ]] --
-- ---------------------------------------------- --
lsp.on_attach(function(client)
	vim.keymap.set("n", '<leader>rn', function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
	vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set('n', '<leader>q', ':cclose<CR>,') -- close quickfix window, which is where multiple files show
end)


-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

-- ------------------------------------------------------ --
-- [[ This section contains diagnostics customizations ]] --
-- ------------------------------------------------------ --

lsp.set_preferences({
	sign_icons = { Error = " ", Warn = " ", Hint = " ", Info = " " }
})

-- Customize the Diagnostic symbols in the sign column (gutter) --
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Call setup() last --
lsp.setup()


-- Show line diagnostics automatically on same line, four spaces to the right --
-- (Call after lsp.setup()) --
-- vim.diagnostic.config({
-- 	underline = true,
-- 	virtual_text = {
-- 		prefix = '●',
-- 		spacing = 4,
-- 	},
-- 	update_in_insert = false,
-- 	float = {
-- 		source = "always", -- Or "if_many"
-- 		header = '',
-- 		prefix = ''
-- 	},
-- })

-- Show line diagnostics in a popup --
vim.diagnostic.config({
  virtual_text = false
})

vim.o.updatetime = 1500
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]


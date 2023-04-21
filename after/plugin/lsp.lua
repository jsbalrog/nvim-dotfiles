local lsp = require('lsp-zero').preset({
	-- name = 'recommended',
	-- set_lsp_keymaps = true,
	-- manage_nvim_cmp = true,
	-- suggest_lsp_servers = true,
})

lsp.ensure_installed({
	'clangd',
	'pyright',
	'tsserver',
	'eslint',
	'lua_ls',
	'rust_analyzer',
})

-- ----------------------------------------------------------------- --
-- [[ This section is Autocomplete stuff, including jump mappings ]] --
-- ----------------------------------------------------------------- --
local opts = { noremap = true, silent = true }

-- -------------------------------------------------------------- --
-- [[ This section is lsp intellisense-type stuff and mappings ]] --
-- -------------------------------------------------------------- --
lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
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


-- Call setup() last --
lsp.setup()

-- ------------------------------------------------------ --
-- [[           This section is to set up cmp          ]] --
-- ------------------------------------------------------ --
local present, cmp = pcall(require, "cmp")

local lspkind = require("lspkind")
lspkind.init({
	symbol_map = {
		Copilot = "",
		Text = '  ',
		Method = '  ',
		Function = '  ',
		Constructor = '  ',
		Field = '  ',
		Variable = '  ',
		Class = '  ',
		Interface = '  ',
		Module = '  ',
		Property = '  ',
		Unit = '  ',
		Value = '  ',
		Enum = '  ',
		Keyword = '  ',
		Snippet = '  ',
		Color = '  ',
		File = '  ',
		Reference = '  ',
		Folder = '  ',
		EnumMember = '  ',
		Constant = '  ',
		Struct = '  ',
		Event = '  ',
		Operator = '  ',
		TypeParameter = '  ',
	},
})

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local luasnip = require("luasnip")

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
vim.opt.completeopt = "menuone,noselect"
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	completion = {
		autocomplete = false,
	},
	style = {
		winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
	},
	formatting = {
		format = lspkind.cmp_format({ with_text = false, maxwidth = 50 }),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
				-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
				-- they way you will only jump inside the snippet region
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	experimental = {
		native_menu = false,
		ghost_text = true,
	},
	sources = {
		{ name = "nvim_lsp", group_index = 2 },
		{ name = "copilot",  group_index = 2 },
		{ name = "path",     group_index = 2 },
		{ name = 'orgmode',  group_index = 2 },
		{ name = 'neorg',    group_index = 2 },
		{ name = "nvim_lua", group_index = 2 },
		{ name = "luasnip",  group_index = 2 },
		{ name = "buffer",   group_index = 5 },
	},
	sorting = {
		comparators = {
			cmp.config.compare.recently_used,
			cmp.config.compare.offset,
			cmp.config.compare.score,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	preselect = cmp.PreselectMode.Item,
})

--set max height of items
vim.cmd([[ set pumheight=6 ]])
vim.cmd [[
	set completeopt=menuone,noinsert,noselect
	highlight! default link CmpItemKind CmpItemMenuDefault
]]
-- ------------------------------------------------------ --
-- [[ This section contains diagnostics customizations ]] --
-- ------------------------------------------------------ --
-- Customize the Diagnostic symbols in the sign column (gutter) --
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
--- Show line diagnostics automatically on same line, four spaces to the right --
-- (Call after lsp.setup()) --
-- vim.diagnostic.config({
-- 	underline = true,
-- 	virtual_text = {
-- 		prefix = '●',
-- 		spacing = 8,
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
	virtual_text = false,
	update_in_insert = false,
})
vim.o.updatetime = 2000
vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]]

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
-- local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
-- keymap("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
-- keymap("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
-- keymap("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
-- keymap("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

-- lsp.setup_nvim_cmp({
-- 	mapping = cmp_mappings,
-- 	preselect = 'none',
-- 	completion = {
-- 		completeopt = 'menu,menuone,noinsert,noselect',
-- 		-- autocomplete = false
-- 	},
-- 	window = {
-- 		completion = {
-- 			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
-- 			col_offset = -3,
-- 			side_padding = 0,
-- 		},
-- 	},
-- 	formatting = {
-- 		fields = { "kind", "abbr", "menu" },
-- 		format = function(entry, vim_item)
-- 			local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry,
-- 				vim_item)
-- 			local strings = vim.split(kind.kind, "%s", { trimempty = true })
-- 			kind.kind = " " .. (strings[1] or "") .. " "
-- 			kind.menu = "    (" .. (strings[2] or "") .. ")"
--
-- 			return kind
-- 		end,
-- 	},
-- })

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
-- lsp.nvim_workspace()


-- Call setup() last --
lsp.setup()

-- ------------------------------------------------------ --
-- [[           This section is to set up cmp          ]] --
-- ------------------------------------------------------ --
local cmp_kinds = {
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
}

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require('cmp')
local luasnip = require("luasnip")
local lspkind = require("lspkind")

cmp.setup({
	snippet = {
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body)   -- For `vsnip` users.
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	completion = {
		autocomplete = true,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true
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
	-- mapping = {
	-- 	-- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
	-- 	-- ['<C-f>'] = cmp.mapping.scroll_docs(4),
	-- 	-- ['<C-Space>'] = cmp.mapping.complete(),
	-- 	-- ['<C-e>'] = cmp.mapping.abort(),
	-- 	['<CR>'] = cmp.mapping.confirm({ select = true }),
	-- },

	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		-- { name = 'vsnip' }, -- For vsnip users.
		{ name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
		{ name = 'buffer' },
	}),
	formatting = {
		fields = { "kind", "abbr" },
		format = function(_, vim_item)
			vim_item.kind = cmp_kinds[vim_item.kind] or ""
			return vim_item
		end,
	},
})

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
	virtual_text = false,
	update_in_insert = false,
})
vim.o.updatetime = 2000
vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]]

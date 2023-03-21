-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		-- or                            , branch = '0.1.x',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}

	use 'Mofiqul/vscode.nvim'

	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
	use('nvim-treesitter/playground')

	use 'theprimeagen/harpoon'

	use 'mbbill/undotree'

	use 'tpope/vim-fugitive'
	use 'tpope/vim-rhubarb'
	use 'lewis6991/gitsigns.nvim'

	use 'nvim-lualine/lualine.nvim'          -- Fancier statusline

	use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines

	use 'tpope/vim-sleuth'                   -- Detect tabstop and shiftwidth automatically

	use 'norcalli/nvim-colorizer.lua'        -- colorize css

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' },          -- Required
			{ 'williamboman/mason.nvim' },        -- Optional
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional
			{ 'ray-x/lsp_signature.nvim' },       -- Optional; cool signature hover-ness

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' },      -- Required
			{ 'hrsh7th/cmp-nvim-lsp' },  -- Required
			{ 'hrsh7th/cmp-buffer' },    -- Optional
			{ 'hrsh7th/cmp-path' },      -- Optional
			{ 'saadparwaiz1/cmp_luasnip' }, -- Optional
			{ 'hrsh7th/cmp-nvim-lua' },  -- Optional
			{ 'onsails/lspkind.nvim' },  --Icons
			{ 'mortepau/codicons.nvim' },
			{ 'hrsh7th/cmp-nvim-lsp-signature-help' },

			-- Snippets
			{ 'L3MON4D3/LuaSnip' },          -- Required
			{ 'rafamadriz/friendly-snippets' }, -- Optional
			{ 'hrsh7th/cmp-vsnip' },
			{ 'hrsh7th/vim-vsnip' },
		}
	}

	-- See your buffers as tabs
	use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }

	use { "echasnovski/mini.nvim", branch = "stable" } -- So I can use mini.cursorword

	use 'j-hui/fidget.nvim'                           -- useful status updates for LSP

	use {
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		}
	}

	-- This mirrors tmux panes plugin
	use 'christoomey/vim-tmux-navigator'

	use 'tpope/vim-unimpaired' -- used for bubbling lines up, down, around...

	use 'tpope/vim-surround'  -- surround things with things

	use 'windwp/nvim-autopairs'

	use 'windwp/nvim-ts-autotag'

	-- Comment-related plugins
	use 'numToStr/Comment.nvim'
	use 'JoosepAlviste/nvim-ts-context-commentstring'

	-- Prettier-related plugins (along with nvim-lspconfig, already required above)
	use 'MunifTanjim/prettier.nvim'
	use 'jose-elias-alvarez/null-ls.nvim'

	-- Extra functionality over rust analyzer
	use("simrat39/rust-tools.nvim")

	-- Let's play!
	use 'ThePrimeagen/vim-be-good'
end)

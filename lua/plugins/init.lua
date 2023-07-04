return {
	-- Colorscheme
	--
	-- https://github.com/navarasu/onedark.nvim
	{
		'navarasu/onedark.nvim',
		priority = 1000,
		config = function()
			vim.cmd.colorscheme 'onedark'
		end,
	},

	-- Status line
	--
	-- https://github.com/nvim-lualine/lualine.nvim
	{
		'nvim-lualine/lualine.nvim',
		opts = {
			options = {
				icons_enabled = true,
				theme = 'onedark',
				component_separators = '|',
				section_separators = '',
			},
		},
	},

	-- Detect tabstop and shiftwidth automatically
	'tpope/vim-sleuth',

	-- Magit for Neovim
	-- https://github.com/TimUntersberger/neogit
	{ 'TimUntersberger/neogit', dependencies = 'nvim-lua/plenary.nvim' },

	-- Useful plugin to show you pending keybinds.
	{ 'folke/which-key.nvim',   opts = {} },

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',

			-- Adds LSP completion capabilities
			'hrsh7th/cmp-nvim-lsp',

			-- Adds a number of user-friendly snippets
			'rafamadriz/friendly-snippets',
		},
	},

	-- Highlight, edit, and navigate code
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
	},

	-- LSP Configuration & Plugins
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ 'williamboman/mason.nvim', config = true },
			'williamboman/mason-lspconfig.nvim',
			{ 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

			'folke/neodev.nvim',
		},
	},

	-- Fuzzy Finder (files, lsp, etc)
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		config = function()
			-- Load fzf native
			pcall(require('telescope').load_extension, 'fzf')
		end,
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = vim.fn.executable 'make' == 1
			},
		},
	},
}

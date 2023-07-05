-- This file contains plugins that require minimal to
-- no custom configuration. This file will be required by lazy when
-- starting up. The files in this directory
-- outline other plugins and more custom configuration.
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

    -- Start Menu
    --
    -- https://github.com/glepnir/dashboard-nvim
    {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                theme = 'hyper',
                shortcut_type = 'number',
            }
        end,
        dependencies = { 'nvim-tree/nvim-web-devicons' }
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
    --
    -- https://github.com/tpope/vim-sleuth
    'tpope/vim-sleuth',

    -- Gitsigns
    --
    -- https://github.com/lewis6991/gitsigns.nvim
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
                on_attach = require('config.keymaps').gitsigns_keybindings
            }
        end
    },

    -- Useful plugin to show you pending keybinds.
    --
    -- https://github.com/folke/which-key.nvim
    { 'folke/which-key.nvim', opts = {} },

    -- Fast Refactoring
    --
    -- https://github.com/theprimeagen/refactoring.nvim
    {
        'theprimeagen/refactoring.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter'
        }
    },

    -- Better undoing
    --
    -- https://github.com/mbbill/undotree
    'mbbill/undotree',

    -- Fuzzy Finder (files, lsp, etc)
    --
    -- https://github.com/nvim-telescope/telescope.nvim
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

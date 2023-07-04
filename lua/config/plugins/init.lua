-- This file contains plugins that require minimal to
-- no custom configuration. The files in this directory
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
                -- config
            }
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
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

    -- Useful plugin to show you pending keybinds.
    --
    -- https://github.com/folke/which-key.nvim
    { 'folke/which-key.nvim', opts = {} },

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

-- Neogit a Neovim Magit
--
-- https://github.com/NeogitOrg/neogit
return {
    'NeogitOrg/neogit',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
        require('neogit').setup {
            auto_refresh = true
        }
    end
}

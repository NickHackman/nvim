-- Highlight, edit, and navigate code
--
-- https://github.com/nvim-treesitter/nvim-treesitter
return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Supported Treesitter languages
        --
        -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
        ensure_installed = "all",
        auto_install = true,
        sync_install = false,
        -- https://github.com/nvim-orgmode/orgmode?tab=readme-ov-file#installation
        ignore_install = { "org" },
        modules = {},
        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },
}

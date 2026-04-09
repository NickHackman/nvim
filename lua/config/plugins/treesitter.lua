-- Highlight, edit, and navigate code
--
-- https://github.com/nvim-treesitter/nvim-treesitter
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    -- https://www.reddit.com/r/neovim/comments/1s9y00d/for_anyone_experiencing_treesitter_issues_after/?rdt=56370
    branch = "main",
    build = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter")

      -- Supported Treesitter languages
      --
      -- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
      treesitter.install({
            -- work
        "kotlin",
        "markdown",
        "groovy",
        "java",
        "graphql",
        "toml",
        "yaml",
        "json",
        "tsv",
        "csv",

        -- personal
        "kitty",
        "zsh",
        "bash",
        "python",
        "lua",
        "vim",

        -- git
        "gitcommit",
        "gitignore",
        "git_rebase",
        "gitattributes",
        "git_config"
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "<filetype>" },
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
}

-- This file contains plugins that require minimal to
-- no custom configuration. This file will be required by lazy when
-- starting up. The files in this directory
-- outline other plugins and more custom configuration.
return {
  -- Colorscheme
  --
  -- https://github.com/navarasu/onedark.nvim
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("onedark")
    end,
  },

  -- Start Menu
  --
  -- https://github.com/glepnir/dashboard-nvim
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require("dashboard").setup({
        theme = "hyper",
        shortcut_type = "number",
      })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({})
      require("telescope").load_extension("projects")
    end,
  },

  -- Status line
  --
  -- https://github.com/nvim-lualine/lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = true,
        theme = "onedark",
        component_separators = "|",
        section_separators = "",
      },
    },
  },

  -- Detect tabstop and shiftwidth automatically
  --
  -- https://github.com/tpope/vim-sleuth
  "tpope/vim-sleuth",

  -- camelCase to snake_case
  --
  -- https://github.com/johmsalas/text-case.nvim
  {
    "johmsalas/text-case.nvim",
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
    end,
  },

  -- Gitsigns
  --
  -- https://github.com/lewis6991/gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = require("config.keymaps").gitsigns_keybindings,
      })
    end,
  },

  -- Neogit a Neovim Magit
  --
  -- https://github.com/NeogitOrg/neogit
  {
    "NeogitOrg/neogit",
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
    config = function()
      require("neogit").setup({
        auto_refresh = true,
        integrations = {
          diffview = true,
        },
      })
    end,
  },

  -- Filesystem Tree
  --
  -- https://github.com/nvim-neo-tree/neo-tree.nvim
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({})
    end,
  },

  -- Improved diagnostics
  --
  -- https://github.com/folke/trouble.nvim
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  -- Useful plugin to show you pending keybinds.
  --
  -- https://github.com/folke/which-key.nvim
  { "folke/which-key.nvim", opts = {} },

  -- Fast Refactoring
  --
  -- https://github.com/theprimeagen/refactoring.nvim
  {
    "theprimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- Comment
  --
  -- https://github.com/numToStr/Comment.nvim
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        mappings = { basic = false, extra = false },
      })
    end,
  },

  -- Better undoing
  --
  -- https://github.com/mbbill/undotree
  "mbbill/undotree",

  -- Fuzzy Finder (files, lsp, etc)
  --
  -- https://github.com/nvim-telescope/telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    config = function()
      -- Load fzf native
      pcall(require("telescope").load_extension, "fzf")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = vim.fn.executable("make") == 1,
      },
    },
  },
}

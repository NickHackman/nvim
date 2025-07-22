require("config.keymaps")

local opt = vim.opt

-------------------------------------------
-- General
-------------------------------------------
opt.number = true -- show line numbers
opt.mouse = "a" -- enable mouse
opt.swapfile = false -- disable vim swapfiles
opt.completeopt = "menuone,noinsert,noselect" -- better autocomplete
opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.
opt.termguicolors = true -- 24-bit color
opt.showmatch = true -- show matching paren
opt.undofile = true -- undofile for use with undotree
opt.signcolumn = "yes"
opt.relativenumber = true
opt.cursorline = true

-- Use https://github.com/BurntSushi/ripgrep over grep
if vim.fn.executable("rg") == 1 then
  opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
  opt.grepprg = "rg --vimgrep --no-heading --smart-case"
end

-------------------------------------------
-- Case Insensitive Search
-------------------------------------------
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.completeopt = "menuone,noselect,fuzzy"

-------------------------------------------
-- Performance
-------------------------------------------
opt.updatetime = 250
opt.timeout = true
opt.timeoutlen = 300
opt.lazyredraw = true

-------------------------------------------
-- Indentation
-------------------------------------------
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

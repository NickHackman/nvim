local telescope = require('telescope.builtin')
local keymap = vim.keymap

-- <leader>
keymap.set('n', '<leader>/', telescope.live_grep, { desc = '[S]earch by [G]rep' })
keymap.set('n', '<leader><leader>', telescope.find_files, { desc = 'Search [G]it [F]iles' })

-- <leader>w
keymap.set('n', '<leader>wv', '<c-w>v', { desc = "Vertical Split" })
keymap.set('n', '<leader>ws', '<c-w>s', { desc = "Horizontal Split" })
keymap.set('n', '<leader>wl', '<c-w>l', { desc = "Window Right" })
keymap.set('n', '<leader>wh', '<c-w>h', { desc = "Window Left" })
keymap.set('n', '<leader>wj', '<c-w>j', { desc = "Window Down" })
keymap.set('n', '<leader>wk', '<c-w>k', { desc = "Window Up" })
keymap.set('n', '<leader>wq', ':wq<CR>', { desc = "Close Window" })

-- <leader>b
keymap.set('n', '<leader>bs', telescope.buffers, { desc = 'Find existing [b]uffer[s]' })
keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = "Next Buffer" })
keymap.set('n', '<leader>bp', ':bprev<CR>', { desc = "Previous Buffer" })

-- <leader>g
keymap.set('n', '<leader>g', ':Neogit<CR>', { desc = "Launch Magit" })

-- <leader>p
keymap.set('n', '<leader>p', ':Neotree toggle<CR>', { desc = "Open Project" })

-- <leader>e
keymap.set("n", "<leader>ex", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
keymap.set("n", "<leader>ew", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
keymap.set("n", "<leader>ed", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
keymap.set("n", "<leader>el", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
keymap.set("n", "<leader>eq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })

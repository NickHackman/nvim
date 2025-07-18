local harpoon = require("harpoon")
local telescope = require("telescope.builtin")
local wk = require("which-key")

local keymap = require("core.keymap")

local M = {}
local default_options = { noremap = true, silent = true }

local nmap = keymap.map("n", default_options)
local vmap = keymap.map("v", default_options)
local cmd = keymap.cmd
local opts = keymap.opts

-- Add keymaps in which-key
wk.add({
  { "<leader>b", group = "Buffer" },
  { "<leader>c", group = "Code" },
  { "<leader>d", group = "Diagnostics" },
  { "<leader>g", group = "Git" },
  { "<leader>o", group = "Open" },
  { "<leader>t", group = "Test" },
})

nmap({
  -- <leader>
  { "<leader>/", telescope.live_grep, opts("Search by Grep") },
  { "<leader>?", telescope.resume, opts("Resumes previous Telescope window") },
  { "<leader><leader>", telescope.find_files, opts("Search [G]it [F]iles") },

  -- <leader>[b]uffer
  { "<leader>bs", telescope.buffers, opts("[B]uffer [S]earch") },
  { "<leader>bn", cmd("bnext"), opts("[B]uffer [N]ext") },
  { "<leader>bp", cmd("bprev"), opts("[B]uffer [P]revious") },
  {
    "<leader>ba",
    function()
      harpoon:list():add()
    end,
    opts("Harpoon [B]uffer [A]dd"),
  },
  {
    "<leader>bd",
    function()
      harpoon:list():remove()
    end,
    opts("Harpoon [B]uffer [D]elete"),
  },
  {
    "<leader>bc",
    function()
      harpoon:list():clear()
    end,
    opts("Harpoon [B]uffer [C]lear"),
  },
  {
    "<leader>b1",
    function()
      harpoon:list():select(1)
    end,
    opts("Harpoon [B]uffer [1]"),
  },
  {
    "<leader>b2",
    function()
      harpoon:list():select(2)
    end,
    opts("Harpoon [B]uffer [2]"),
  },
  {
    "<leader>b3",
    function()
      harpoon:list():select(3)
    end,
    opts("Harpoon [B]uffer [3]"),
  },
  {
    "<leader>b4",
    function()
      harpoon:list():select(4)
    end,
    opts("Harpoon [B]uffer [4]"),
  },

  -- <leader>d
  { "<leader>ds", telescope.diagnostics, opts("[D]iagnostics [S]earch") },
  {
    "<leader>dn",
    function()
      vim.diagnostic.jump({ count = 1 })
    end,
    opts("[D]iagnostics [N]ext"),
  },
  {
    "<leader>dp",
    function()
      vim.diagnostic.jump({ count = -1 })
    end,
    opts("[D]iagnostics [P]revious"),
  },

  -- <leader>[o]pen
  { "<leader>of", cmd("Neotree toggle"), opts("[O]pen [F]inder") },
  {
    "<leader>op",
    function()
      require("telescope").extensions.projects.projects({})
    end,
    opts("[O]pen [P]roject"),
  },
  { "<leader>og", cmd("Neogit"), opts("[O]pen Ma[g]it") },
  {
    "<leader>od",
    cmd("Trouble diagnostics toggle"),
    opts("[O]pen [D]iagnostics"),
  },
  { "<leader>ou", cmd("UndotreeToggle"), opts("[O]pen Undotree") },

  -- open terminal on the bottom with no line numbers
  {
    "<leader>ot",
    "<cmd>sp<bar>term<cr><c-w>J:resize10<cr>:setlocal nonumber<cr>i",
    opts("[O]pen [T]erminal"),
  },

  -- Center search results
  { "n", "nzz" },
  { "N", "Nzz" },
})

vmap({
  -- Improved indentation
  { "<", "<gv" },
  { ">", ">gv" },
})

--- Configure LSP keybindings for on_attach
function M.lsp_keybindings()
  nmap({
    -- [G]oto
    { "gd", vim.lsp.buf.definition, opts("[G]oto [D]efinition") },
    { "gr", telescope.lsp_references, opts("[G]oto [R]eferences") },
    { "gI", vim.lsp.buf.implementation, opts("[G]oto [I]mplementation") },
    { "gD", vim.lsp.buf.type_definition, opts("Type [D]efinition") },

    { "K", vim.lsp.buf.hover, opts("Hover Documentation") },
    { "<C-k>", vim.lsp.buf.signature_help, opts("Signature Documentation") },

    -- [C]ode
    { "<leader>cr", vim.lsp.buf.rename, opts("[C]ode [R]ename") },
    { "<leader>ca", vim.lsp.buf.code_action, opts("[C]ode [A]ction") },
    { "<leader>cc", vim.lsp.codelens.run, opts("[C]ode lens") },
    { "<leader>cC", vim.lsp.codelens.refresh, opts("[C]ode lens refresh") },
    {
      "<leader>cf",
      function()
        vim.lsp.buf.format({
          filter = function(format_client)
            -- By default, ignore any formatters provider by other LSPs
            return format_client.name == "null-ls"
          end,
        })
      end,
      opts("[C]ode [F]ormat"),
    },

    {
      "<leader>cR",
      cmd("TextCaseOpenTelescope"),
      opts("[C]ode [R]ename Case"),
    },

    -- [T]est
    {
      "<leader>tr",
      function()
        require("neotest").run.run()
      end,
      opts("[T]est [R]un"),
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      opts("[T]est run [F]ile"),
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      opts("[T]est [S]ummary"),
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open({ enter = true })
      end,
      opts("[T]est [O]utput"),
    },
  })

  vmap({
    {
      "<leader>cR",
      require("refactoring").select_refactor,
      opts("[C]ode [R]efactor"),
    },
    { "<leader>/", "<Plug>(comment_toggle_linewise_visual)", opts("Comment") },
    {
      "<leader>cB",
      "<Plug>(comment_toggle_blockwise_visual)",
      opts("[C]ode [B]lockwise"),
    },
  })
end

-- Configure GitSigns keybindings for on_attach
--
-- https://github.com/lewis6991/gitsigns.nvim#keymaps
function M.gitsigns_keybindings(_)
  local gs = package.loaded.gitsigns

  nmap({
    {
      "<leader>gn",
      function()
        if not vim.wo.diff then
          vim.schedule(function()
            gs.next_hunk()
          end)
        end

        return "<Ignore>"
      end,
      opts("[G]it [N]ext Hunk"),
    },

    {
      "<leader>gp",
      function()
        if not vim.wo.diff then
          vim.schedule(function()
            gs.prev_hunk()
          end)
        end

        return "<Ignore>"
      end,
      opts("[G]it [P]revious Hunk"),
    },

    { "<leader>gg", cmd("Neogit"), opts("[O]pen Ma[g]it") },
    { "<leader>gs", gs.stage_hunk, opts("[G]it [S]tage Hunk") },
    { "<leader>gr", gs.reset_hunk, opts("[G]it [R]eset Hunk") },
    { "<leader>gS", gs.stage_buffer, opts("[G]it [S]tage Buffer") },
    { "<leader>gR", gs.reset_buffer, opts("[G]it [R]eset Buffer") },
    { "<leader>gb", gs.toggle_current_line_blame, opts("[G]it [B]lame Line") },
    {
      "<leader>gB",
      function()
        gs.blame_line({ full = true })
      end,
      opts("[G]it [B]lame Hunk"),
    },
  })
end

return M

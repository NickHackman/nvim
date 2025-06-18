local telescope = require("telescope.builtin")
local wk = require("which-key")

local keymap = require("core.keymap")

local M = {}
local default_options = { noremap = true, silent = true }

local nmap = keymap.map("n", default_options)
local vmap = keymap.map("v", default_options)
local cmd = keymap.cmd
local opts = keymap.opts

-- Reigster keymaps in which-key
wk.register({
	["<leader>"] = {
		w = { name = "Window" },
		b = { name = "Buffer" },
		o = { name = "Open" },
		c = { name = "Code" },
		d = { name = "Diagnostics" },
		g = { name = "Git" },
	},
})

nmap({
	-- <leader>
	{ "<leader>/", telescope.live_grep, opts("Search by Grep") },
	{ "<leader>?", telescope.resume, opts("Resumes previous Telescope window") },
	{ "<leader><leader>", telescope.find_files, opts("Search [G]it [F]iles") },

	-- <leader>[w]indow
	{ "<leader>wv", "<c-w>v", opts("[W]indow [V]ertical Split") },
	{ "<leader>ws", "<c-w>s", opts("[W]indow [S]plit") },
	{ "<leader>wl", "<c-w>l", opts("[W]indow Right") },
	{ "<leader>wh", "<c-w>h", opts("[W]indow Left") },
	{ "<leader>wj", "<c-w>j", opts("[W]indow Down") },
	{ "<leader>wk", "<c-w>k", opts("[W]indow Up") },
	{ "<leader>wq", ":wq<CR>", opts("[W]indow [Q]uit") },
	{ "<leader>wH", cmd("vertical resize +5"), opts("[W]indow Resize Left") },
	{ "<leader>wL", cmd("vertical resize -5"), opts("[W]indow Resize Right") },
	{ "<leader>wJ", cmd("resize -5"), opts("[W]indow Resize Down") },
	{ "<leader>wK", cmd("resize +5"), opts("[W]indow Resize Up") },

	-- <leader>[b]uffer
	{ "<leader>bs", telescope.buffers, opts("[B]uffer [S]earch") },
	{ "<leader>bn", cmd("bnext"), opts("[B]uffer [N]ext") },
	{ "<leader>bp", cmd("bprev"), opts("[B]uffer [P]revious") },

	-- <leader>d
	{ "<leader>dt", cmd("Trouble diagnostics"), opts("[D]iagnostics [T]oggle") },
	{ "<leader>ds", telescope.diagnostics, opts("[D]iagnostics [S]earch") },

	-- <leader>[o]pen
	{ "<leader>op", cmd("Neotree toggle"), opts("[O]pen [P]roject") },
	{ "<leader>og", cmd("Neogit"), opts("[O]pen Ma[g]it") },
	{ "<leader>ou", cmd("UndotreeToggle"), opts("[O]pen Undotree") },

	-- open terminal on the bottom with no line numbers
	{ "<leader>ot", "<cmd>sp<bar>term<cr><c-w>J:resize10<cr>:setlocal nonumber<cr>i", opts("[O]pen [T]erminal") },

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

		{ "<leader>cr", vim.lsp.buf.rename, opts("[C]ode [R]ename") },
		{ "<leader>ca", vim.lsp.buf.code_action, opts("[C]ode [A]ction") },
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
			cmd("TextCaseOpenTelescopeLSPChange"),
			opts("[C]ode [R]ename Case"),
		},
	})

	vmap({
		{ "<leader>cR", require("refactoring").select_refactor, opts("[C]ode [R]efactor") },
		{ "<leader>/", "<Plug>(comment_toggle_linewise_visual)", opts("Comment") },
		{ "<leader>cB", "<Plug>(comment_toggle_blockwise_visual)", opts("[C]ode [B]lockwise") },
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

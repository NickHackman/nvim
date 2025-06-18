-- Neovim builtin LSP support
--
-- https://github.com/neovim/nvim-lspconfig
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs to stdpath for neovim
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",

		-- LSP progress
		{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },

		"folke/neodev.nvim",
	},
	config = function()
		local mason_lspconfig = require("mason-lspconfig")
		local servers = require("config.lsp-servers")

		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		local mason_installable_servers = vim.deepcopy(servers)
		-- removes kotlin_lsp because that lsp isn't installable via Mason
		mason_installable_servers["kotlin_lsp"] = nil

		-- Ensure all LSPs are installed
		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(mason_installable_servers),
		})

		for name, server in pairs(servers) do
			vim.lsp.enable(name)

			vim.lsp.config(name, {
				capabilities = capabilities,
				on_attach = require("config.keymaps").lsp_keybindings,
				settings = server.settings or {},
			})
		end
	end,
}

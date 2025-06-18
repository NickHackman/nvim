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
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local servers = require("config.lsp-servers")

		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		-- Ensure all LSPs are installed
		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers),
		})

		for name, server in pairs(servers) do
			lspconfig[name].setup({
				capabilities = capabilities,
				on_attach = require("config.keymaps").lsp_keybindings,
				settings = server.settings or {},
			})
		end

		local configs = require("lspconfig.configs")

		-- Kotlin LSP
		--
		-- Upstream: https://github.com/Kotlin/kotlin-lsp
		-- configuration: https://github.com/neovim/nvim-lspconfig/pull/3867
		configs.kotlin_lsp = {
			default_config = {
				cmd = { "kotlin-lsp", "--stdio" },
				filetypes = { "kotlin", "kotlin_script", "gradle.kts" },
				root_dir = lspconfig.util.root_pattern("settings.gradle.kts", "build.gradle.kts", ".git"),
				settings = {},
			},
		}

		lspconfig.kotlin_lsp.setup({
			capabilities = capabilities,
			on_attach = require("config.keymaps").lsp_keybindings,
			settings = {},
		})
	end,
}

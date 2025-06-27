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
			automatic_enable = {},
			ensure_installed = vim.tbl_keys(mason_installable_servers),
		})

		for name, server in pairs(servers) do
			vim.lsp.enable(name)

			vim.lsp.config(name, {
				capabilities = capabilities,
				---@param client vim.lsp.Client
				---@param bufnr integer
				on_attach = function(client, bufnr)
					if client:supports_method("textDocument/inlayHint") then
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					end

					if client:supports_method("textDocument/codeLens") then
						vim.lsp.codelens.refresh()
						vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
							buffer = bufnr,
							callback = vim.lsp.codelens.refresh,
						})
					end

					require("config.keymaps").lsp_keybindings()
				end,
				settings = server.settings or {},
			})
		end
	end,
}

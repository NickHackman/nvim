local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local function on_attach(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({
					bufnr = bufnr,
					filter = function(format_client)
						-- By default, ignore any formatters provider by other LSPs
						return format_client.name == "null-ls"
					end,
				})
			end,
		})
	end
end

-- Fill in the gaps with Neovim's builtin LSP
--
-- https://github.com/jose-elias-alvarez/null-ls.nvim
return {
	"jose-elias-alvarez/null-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local servers = require("config.lsp-servers")
		local null_ls = require("null-ls")

		-- Builtin to null-ls
		--
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
		local sources = {
			null_ls.builtins.completion.spell,
		}

		for _, server in pairs(servers) do
			vim.list_extend(
				sources,
				vim.tbl_map(function(value)
					return null_ls.builtins.diagnostics[value]
				end, server.diagnostics or {})
			)

			vim.list_extend(
				sources,
				vim.tbl_map(function(value)
					return null_ls.builtins.formatting[value]
				end, server.formatters or {})
			)
		end

		null_ls.setup({ sources = sources, on_attach = on_attach })
	end,
}

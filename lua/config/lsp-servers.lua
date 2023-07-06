-- This should include all LSPs by name provided in nvim-lspconfig and their respected settings
-- and null-ls formatters and diagnostics tools.
--
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
return {
	-- Markdowns
	--
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#marksman
	marksman = {
		diagnostics = { "proselint", "write_good" },
		formatters = { "prettier" },
	},

	-- Kotlin
	--
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#kotlin_language_server
	kotlin_language_server = {
		formatters = { "ktlint" },
	},

	-- Rust
	--
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
	rust_analyzer = {
		formatters = { "rustfmt" },
	},

	-- Typescript
	--
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
	tsserver = {
		diagnostics = { "eslint" },
		formatters = { "prettier" },
	},

	-- JSON
	--
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
	jsonls = {
		diagnostics = { "jsonlint" },
		formatters = { "prettier" },
	},

	-- Python
	--
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright
	pyright = {
		formatters = { "autopep8", "isort" },
		diagnostics = { "mypy", "pylint" },
	},

	-- Go
	--
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
	gopls = {
		formatters = { "goimports", "gofumpt" },
		diagnostics = { "golangci_lint" },
	},

	-- Lua
	--
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
	lua_ls = {
		formatters = { "stylua" },
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
		},
	},

	-- Bash
	--
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
	bashls = {
		formatters = { "beautysh" },
		diagnostics = { "zsh" },
	},
}

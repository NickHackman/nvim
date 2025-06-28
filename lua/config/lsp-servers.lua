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

	-- Rust
	--
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
	rust_analyzer = {
		formatters = { "rustfmt" },
		settings = {
			["rust-analyzer"] = {
				inlayHints = {
					bindingModeHints = {
						enable = false,
					},
					chainingHints = {
						enable = true,
					},
					closingBraceHints = {
						enable = true,
						minLines = 25,
					},
					closureReturnTypeHints = {
						enable = "never",
					},
					lifetimeElisionHints = {
						enable = "never",
						useParameterNames = false,
					},
					maxLength = 25,
					parameterHints = {
						enable = true,
					},
					reborrowHints = {
						enable = "never",
					},
					renderColons = true,
					typeHints = {
						enable = true,
						hideClosureInitialization = false,
						hideNamedConstructor = false,
					},
				},
			},
		},
	},

	-- Kotlin LSP
	--
	-- Upstream: https://github.com/Kotlin/kotlin-lsp
	-- configuration: https://github.com/neovim/nvim-lspconfig/pull/3867
	kotlin_lsp = {
		settings = {
			single_file_support = false,
		},
	},

	-- Typescript
	--
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ts_ls
	ts_ls = {
		diagnostics = { "eslint" },
		formatters = { "prettier" },
		settings = {
			tsserver_file_preferences = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = false,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},

	-- Tailwindcss
	--
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tailwindcss
	tailwindcss = {},

	-- JSON
	--
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
	jsonls = {
		diagnostics = { "jsonlint", "spectral" },
		formatters = { "prettier" },
	},

	-- YAML
	--
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls
	yamlls = {
		formatters = { "prettier" },
		diagnostics = { "spectral" },
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
		settings = {
			gopls = {
				hints = {
					rangeVariableTypes = true,
					parameterNames = true,
					constantValues = true,
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					functionTypeParameters = true,
				},
			},
		},
	},

	-- Lua
	--
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
	lua_ls = {
		formatters = { "stylua" },
		settings = {
			Lua = {
				hint = {
					enable = true,
				},
				-- codeLens = {
				-- 	enable = true,
				-- },
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

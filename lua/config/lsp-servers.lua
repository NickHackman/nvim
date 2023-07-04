-- Neovim LSPs:
--
-- This should include all LSPs by name provided in nvim-lspconfig and their respected settings.
--
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
return {
    -- Kotlin
    --
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#kotlin_language_server
    kotlin_language_server = {},

    -- Rust
    --
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    rust_analyzer = {},

    -- Typescript
    --
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
    tsserver = {},

    -- JSON
    --
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
    jsonls = {},

    -- Python
    --
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright
    pyright = {},

    -- Go
    --
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
    gopls = {},

    -- Lua
    --
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
    lua_ls = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
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

    -- Bash
    --
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
    bashls = {},
}

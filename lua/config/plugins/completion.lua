-- Improved autocompletion
--
-- https://github.com/saghen/blink.cmp
return {
	"saghen/blink.cmp",
	version = "1.*",
	dependencies = {
		-- Adds a number of user-friendly snippets
		"rafamadriz/friendly-snippets",
		{ "L3MON4D3/LuaSnip", version = "v2.*" },
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		snippets = { preset = "luasnip" },
		keymap = {
			preset = "default",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<CR>"] = { "accept", "fallback" },
		},
		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},
		completion = { documentation = { auto_show = true } },
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
}

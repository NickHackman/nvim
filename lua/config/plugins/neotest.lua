-- Neovim Test Support
--
-- https://github.com/nvim-neotest/neotest
return {
	{
		"nvim-neotest/neotest",
		event = "VeryLazy",
		config = function()
			require("neotest").setup({
				adapters = {
					-- Kotlin support (specifically KoTest)
					--
					-- https://github.com/codymikol/neotest-kotlin
					require("neotest-kotlin"),

					-- Golang support
					--
					-- https://github.com/fredrikaverpil/neotest-golang
					require("neotest-golang")({}),

					-- Jest support
					--
					-- https://github.com/nvim-neotest/neotest-jest
					require("neotest-jest")({})
				},
			})
		end,
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			-- Kotlin
			--
			-- Local clone of https://github.com/codymikol/neotest-kotlin with minor modifications
			{ dir = "~/GitHub/neotest-kotlin" },
			-- Golang
			{ "fredrikaverpil/neotest-golang", version = "*" },
			-- Typescript/Javascript Jest
			"nvim-neotest/neotest-jest"
		},
	},
}

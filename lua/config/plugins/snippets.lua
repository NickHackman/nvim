return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local luasnip = require("luasnip")

		local s, sn = luasnip.snippet, luasnip.snippet_node
		local t, i, d = luasnip.text_node, luasnip.insert_node, luasnip.dynamic_node

		local function uuid()
			local id, _ = vim.fn.system("uuidgen"):gsub("\n", "")
			return id
		end

		luasnip.add_snippets("all", {
			s({
				trig = "uuid",
				name = "UUID",
				dscr = "Generate a unique UUID",
			}, {
				d(1, function()
					return sn(nil, i(1, uuid()))
				end),
			}),
		})
	end,
}

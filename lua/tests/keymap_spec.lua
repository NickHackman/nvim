local keymap = require("core.keymap")

describe("keymap", function()
	it("has required methods", function()
		assert.is_function(keymap.silent)
		assert.is_function(keymap.nowait)
		assert.is_function(keymap.noremap)
		assert.is_function(keymap.expr)
		assert.is_function(keymap.opts)
		assert.is_function(keymap.map)
		assert.is_function(keymap.cmd)
	end)

	describe("cmd", function()
		it("unsupported not string", function()
			assert.error_matches(function()
				keymap.cmd(1)
			end, "str: expected string, got number")
		end)

		it("valid", function()
			assert.is_equal("<cmd>example<CR>", keymap.cmd("example"))
		end)
	end)

	it("silent", function()
		local options = {}
		keymap.silent()(options)

		assert.is_true(options.silent)
	end)

	it("expr", function()
		local options = {}
		keymap.expr()(options)

		assert.is_true(options.expr)
	end)

	it("noremap", function()
		local options = {}
		keymap.noremap()(options)

		assert.is_true(options.noremap)
	end)

	it("nowait", function()
		local options = {}
		keymap.nowait()(options)

		assert.is_true(options.nowait)
	end)

	describe("opts", function()
		it("two descriptions throws", function()
			assert.error_matches(function()
				keymap.opts("description one", "description two")
			end, "expected only a single description, but got two. First `description one` then `description two`")
		end)

		it("unsupported vararg", function()
			assert.error_matches(function()
				keymap.opts(1, 2, 3)
			end, "expected option to be a string or function, but got `1` at index `1`")
		end)

		it("valid", function()
			local actual = keymap.opts("description", keymap.noremap(), keymap.nowait(), keymap.expr())

			assert.is_true(actual.noremap)
			assert.is_true(actual.nowait)
			assert.is_true(actual.expr)
			assert.is_equal("description", actual.desc)
		end)
	end)
end)

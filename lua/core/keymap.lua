--- Keymap Helpers
--
-- Based on https://github.com/nvimdev/dope/blob/d7ed25abf2a5395b34e1b2a01049c704fc5cff46/lua/core/keymap.lua
local M = {}

--- Performs |assert|ions on a mapping.
--
-- { <key combination> <action> [options] }
--
-- key combination: string
-- action: string|function
-- options: table
--
-- Examples:
--
-- { "<leader>e", function() end }
-- { "<leader>e", "gg" }
-- { "<leader>e", function() end, {} }
-- { "<leader>e", "gg", {} }
---@param mapping table
local function mapping_validation(mapping)
	assert(vim.tbl_islist(mapping), string.format("mapping %q expected a list", vim.inspect(mapping)))

	local len = #mapping
	assert(
		len == 2 or len == 3,
		string.format(
			"mapping `%s` expected either 2 arguments or 3 { mapping, expr, [opts] }, but got %d",
			vim.inspect(mapping),
			len
		)
	)

	assert(
		type(mapping[1]) == "string",
		string.format(
			"mapping `%s` first argument must be a string key combination, but got %s",
			vim.inspect(mapping),
			type(mapping[1])
		)
	)

	assert(
		type(mapping[2]) == "string" or type(mapping[2]) == "function",
		string.format(
			"mapping `%s` second argument must be a string or function action, but got %s",
			vim.inspect(mapping),
			type(mapping[2])
		)
	)

	if len == 2 then
		return
	end

	assert(
		type(mapping[3]) == "table",
		string.format(
			"mapping `%s` optional third argument must be a table of options, but got %s",
			mapping,
			type(mapping[3])
		)
	)
end

--- Constructs a custom |mapping| function that calls |vim.keymap| on provided mappings
--
-- Each mapping must follow the format
--
-- { <key combination> <action> [options] }
--
-- key combination: string
-- action: string|function
-- options: table
--
-- Full Example:
--
-- map("n", { noremap = true, expr = true })({
--   { "<leader>e", function() end },
--   { "<leader>e", "gg" },
--   { "<leader>e", function() end, {} },
--   { "<leader>e", "gg", {} }
-- })
--
---@param mode string|table mode provided to |vim.keymap.set|
---@param opts ?table default options provided to |vim.keymap.set| unless overidden
---@return function mapping
function M.map(mode, opts)
	vim.validate({
		mode = { mode, { "table", "string" } },
	})

	return function(mappings)
		vim.validate({
			mappings = { mappings, "table" },
		})

		for _, mapping in ipairs(mappings) do
			mapping_validation(mapping)

			local key_combination = mapping[1]
			local action = mapping[2]
			local options = vim.tbl_extend("force", opts or {}, mapping[3] or {})

			vim.keymap.set(mode, key_combination, action, options)
		end
	end
end

--- Constructs a command
--
-- Example:
--
-- cmd("Example") --> "<cmd>Example<CR>"
--
-- Suggested to provide silent as an option for every <action>
-- that uses this method.
--
---@param str string
---@return string command
function M.cmd(str)
	vim.validate({
		str = { str, "string" },
	})

	return "<cmd>" .. str .. "<CR>"
end

---Create options to pass to |vim.keymap.set| via |map|.
--
-- Example:
--
-- opts("description", noremap, silent, expr, nowait)
--
---@param ... function|string
function M.opts(...)
	local options = {}
	local varargs = { ... }

	for i, value in ipairs(varargs) do
		assert(
			type(value) == "string" or type(value) == "function",
			string.format(
				"expected option to be a string or function, but got `%s` at index `%d`",
				vim.inspect(value),
				i
			)
		)

		if type(value) == "string" then
			assert(
				options.desc == nil,
				string.format(
					"expected only a single description, but got two. First `%s` then `%s`",
					options.desc,
					value
				)
			)

			options.desc = value
		else
			value(options)
		end
	end

	return options
end

--- Excutes the command silently
--
-- :help silent
--
---@return function setter
function M.silent()
	return function(options)
		options.silent = true
	end
end

--- Evalute the <action> as an expression
--
-- :help expr
--
---@return function setter
function M.expr()
	return function(options)
		options.expr = true
	end
end

--- Prevent remapping of the <key combination>
--
-- :help noremap
--
---@return function setter
function M.noremap()
	return function(options)
		options.noremap = true
	end
end

--- Disable waiting for more keypresses after the key combination is matched
--
-- :help nowait
--
---@return function setter
function M.nowait()
	return function(options)
		options.nowait = true
	end
end

return M

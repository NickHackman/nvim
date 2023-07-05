local telescope = require('telescope.builtin')
local keymap = vim.keymap
local wk = require('which-key')

-- Reigster keymaps in which-key
wk.register({
    ['<leader>'] = {
        w = { name = 'Window' },
        b = { name = 'Buffer' },
        o = { name = 'Open' },
        d = { name = 'Diagnostics' }
    }
})


--- Creates options to provide to {vim.keymap.set}.
-- adds the default options of { noremap = true, silent = true }
---@param custom_opts table | nil custom options like 'desc'
---@return table options combined with the default
local opts = function(custom_opts)
    -- https://hiphish.github.io/blog/2020/12/31/spreading-tables-in-lua/
    local function spread(template)
        local result = {}
        for key, value in pairs(template) do
            result[key] = value
        end

        return function(table)
            if table == nil then
                return result
            end

            for key, value in pairs(table) do
                result[key] = value
            end

            return result
        end
    end

    return spread({ noremap = true, silent = true })(custom_opts)
end


-- <leader>
keymap.set('n', '<leader>/', telescope.live_grep, opts { desc = 'Search by Grep' })
keymap.set('n', '<leader><leader>', telescope.find_files, opts { desc = 'Search [G]it [F]iles' })


-- <leader>[w]indow
keymap.set('n', '<leader>wv', '<c-w>v', opts { desc = '[W]indow [V]ertical Split' })
keymap.set('n', '<leader>ws', '<c-w>s', opts { desc = '[W]indow [S]plit' })
keymap.set('n', '<leader>wl', '<c-w>l', opts { desc = '[W]indow Right' })
keymap.set('n', '<leader>wh', '<c-w>h', opts { desc = '[W]indow Left' })
keymap.set('n', '<leader>wj', '<c-w>j', opts { desc = '[W]indow Down' })
keymap.set('n', '<leader>wk', '<c-w>k', opts { desc = '[W]indow Up' })
keymap.set('n', '<leader>wq', ':wq<CR>', opts { desc = '[W]indow [Q]uit' })
keymap.set('n', '<leader>wH', ':vertical resize +5<CR>', opts { desc = '[W]indow Resize Left' })
keymap.set('n', '<leader>wL', ':vertical resize -5<CR>', opts { desc = '[W]indow Resize Right' })
keymap.set('n', '<leader>wJ', ':resize -5<CR>', opts { desc = '[W]indow Resize Down' })
keymap.set('n', '<leader>wK', ':resize +5<CR>', opts { desc = '[W]indow Resize Up' })

-- <leader>[b]uffer
keymap.set('n', '<leader>bs', telescope.buffers, opts { desc = '[B]uffer [S]earch' })
keymap.set('n', '<leader>bn', ':bnext<CR>', opts { desc = '[B]uffer [N]ext' })
keymap.set('n', '<leader>bp', ':bprev<CR>', opts { desc = '[B]uffer [P]revious' })

-- <leader>d
keymap.set('n', '<leader>dt', '<cmd>TroubleToggle<cr>', opts { desc = '[D]iagnostics [T]oggle' })
keymap.set('n', '<leader>dw', '<cmd>TroubleToggle workspace_diagnostics<cr>', opts { desc = '[D]iagnostics [W]orkspace' })
keymap.set('n', '<leader>dd', '<cmd>TroubleToggle document_diagnostics<cr>', opts { desc = '[D]iagnostics [D]ocument' })
keymap.set('n', '<leader>dl', '<cmd>TroubleToggle loclist<cr>', opts { desc = '[D]iagnostics [L]ocal' })
keymap.set('n', '<leader>dq', '<cmd>TroubleToggle quickfix<cr>', opts { desc = '[D]iagnostics [Q]uickfix' })

-- <leader>[o]pen
keymap.set('n', '<leader>op', ':Neotree toggle<CR>', opts { desc = '[O]pen [P]roject' })
keymap.set('n', '<leader>og', ':Neogit<CR>', opts { desc = '[O]pen Ma[g]it' })
keymap.set('n', '<leader>ou', ':UndotreeToggle<CR>', opts { desc = '[O]pen Undotree' })

-- open terminal on the bottom with no line numbers
keymap.set('n', '<leader>ot', '<cmd>sp<bar>term<cr><c-w>J:resize10<cr>:setlocal nonumber<cr>i',
    opts { desc = '[O]pen [T]erminal' })

-- Improved indentation
keymap.set('v', '<', '<gv', opts {})
keymap.set('v', '>', '>gv', opts {})

-- Center search results
keymap.set('n', 'n', 'nzz', opts {})
keymap.set('n', 'N', 'Nzz', opts {})

--- Configure LSP keybindings for on_attach
function Lsp_keybindings()
    -- [G]oto
    keymap.set('n', 'gd', vim.lsp.buf.definition, opts { desc = '[G]oto [D]efinition' })
    keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts { desc = '[G]oto [R]eferences' })
    keymap.set('n', 'gI', vim.lsp.buf.implementation, opts { desc = '[G]oto [I]mplementation' })
    keymap.set('n', 'gD', vim.lsp.buf.type_definition, opts { desc = 'Type [D]efinition' })

    -- Symbols Search
    keymap.set('n', '<leader>d?', require('telescope.builtin').lsp_document_symbols, opts { desc = 'Document Symbols' })
    keymap.set('n', '<leader>?', require('telescope.builtin').lsp_dynamic_workspace_symbols,
        opts { desc = 'Workspace Symbols' })

    keymap.set('n', 'K', vim.lsp.buf.hover, opts { desc = 'Hover Documentation' })
    keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts { desc = 'Signature Documentation' })

    keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts { desc = '[R]e[n]ame' })
    keymap.set('v', '<leader>cR', require('refactoring').select_refactor, opts { desc = "[C]ode [R]efactor" })
    keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts { desc = '[C]ode [A]ction' })
end

-- Export Lsp_keybindings to be used in lsp configuration
return {
    lsp_keybindings = Lsp_keybindings
}

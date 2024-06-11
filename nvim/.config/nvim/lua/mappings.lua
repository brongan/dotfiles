vim.g.mapleader = ","

local bind = vim.keymap.set
-- Fast saving and quit without saving
bind('n', '<Leader>w', ':w!<CR>')
bind('n', '<Leader>q', ':q!<CR>')
bind('n', 'bd', ':bd<CR>')

-- Quickly insert an empty new line without entering insert mode, below and above
bind('n', '<Space>o', 'o<Esc>k')
bind('n', '<Space>O', 'O<Esc>j')

-- Attempt to copy to system clipboard regardless of ssh/tmux.
bind('v', '<Leader>c', ':OSCYank<cr>')
bind('n', '<Leader>o', '<Plug>OSCYank')

-- FZF
bind('n', "<Leader>-", ":FZF <c-r>=fnameescape(expand('%:p:h'))<cr>/<cr>") -- Current file directory
bind('n', "<Leader>ff", ":FZF<cr>")                                        -- Search in current directory
bind('n', "<Leader>fF", ":Files ~/<cr>")                                   -- Search home directory
bind('n', "<Leader>fb", ":Buffers<cr>")                                    -- Open buffers
bind('n', "<Leader>fl", ":Lines<cr>")                                      -- Lines in loaded buffers
bind('n', "<Leader>fB", ":BLines<cr>")                                     -- Lines in the current buffer
bind('n', "<Leader>ft", ":Tags<cr>")                                       -- Tags in the project
bind('n', "<Leader>fh", ":History<cr>")                                    -- v:oldfiles and open buffers
bind('n', "<Leader>fH", ":Helptags<cr>")                                   -- Help tags
bind('n', "<Leader>f:", ":History:<cr>")                                   -- Vim Command History
bind('n', "<Leader>f/", ":History/<cr>")                                   -- Search History
bind('n', "<Leader>fg", ":GFiles<cr>")                                     -- Git files (git ls-files)
bind('n', "<Leader>fs", ":GFiles?<cr>")                                    -- Git files (git status)
bind('n', "<Leader>fc", ":Commits<cr>")                                    -- Git commits (requires fugitive.vim)
bind('n', "<Leader>fv", ":Commands<cr>")                                   -- Vim Commands
bind('n', "<Leader>fC", ":Colors<cr>")                                     -- Change colorscheme
bind('n', "<Leader>fm", ":Marks<cr>")                                      -- View marks
bind('n', "<Leader>fr", ":Rg<cr>")                                         -- Ripgrep search result (ALT-A to select all, ALT-D to deselect all)

-- make_it_rain
bind("n", "<Leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

-- OSCYank
bind('n', '<Leader>c', require('osc52').copy_operator, { expr = true })
bind('n', '<Leader>cc', '<Leader>c_', { remap = true })
bind('v', '<Leader>c', require('osc52').copy_visual)

-- Diagnostic
bind('n', 'd[', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message.' })
bind('n', 'd]', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message.' })
bind('n', '<Leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror message.' })
bind('n', '<Leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list.' })

-- Trouble
bind('n', '<Leader>xx', "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
bind('n', '<Leader>xX', "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
bind('n', '<Leader>cs', "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
bind('n', '<Leader>cl', "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP Definitions / references / ... (Trouble)" })
bind('n', '<Leader>xL', "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
bind('n', '<Leader>xQ', "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- Quickfix
bind('n', "c[", "<cmd>cprev<cr>", { desc = "Quickfix goto_prev" })
bind('n', "c]", "<cmd>cnext<cr>", { desc = "Quickfix goto_next" })
bind('n', "cC", "<cmd>cclose<cr>", { desc = "Quickfix close" })
bind('n', "cc", "<cmd>copen<cr>", { desc = "Quickfix open" })

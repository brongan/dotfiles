local map = vim.keymap.set

-- Fast saving and quit without saving
map('n', '<Leader>w', ':w!<CR>')
map('n', '<Leader>q', ':q!<CR>')
map('n', 'bd', ':bd<CR>')

-- Quickly insert an empty new line without entering insert mode, below and above
map('n', '<Leader>o', 'o<Esc>k')
map('n', '<Leader>O', 'O<Esc>j')

-- Diagnostic
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', 'd[', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message.' })
map('n', 'd]', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message.' })
map('n', '<Leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror message.' })
map('n', '<Leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list.' })

-- Quickfix
map('n', "c[", "<cmd>cprev<cr>", { desc = "Quickfix goto_prev" })
map('n', "c]", "<cmd>cnext<cr>", { desc = "Quickfix goto_next" })
map('n', "cC", "<cmd>cclose<cr>", { desc = "Quickfix close" })
map('n', "cc", "<cmd>copen<cr>", { desc = "Quickfix open" })

map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

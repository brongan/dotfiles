local map = vim.keymap.set

-- Fast saving and quit without saving
map("n", "<Leader>w", ":w!<CR>")
map("n", "<Leader>x", ":bd<CR>")

-- Diagnostic
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Go to prev [d]iagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Go to next [d]iagnostic" })
map("n", "<Leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [e]rror message." })
map("n", "<Leader>d", vim.diagnostic.setloclist, { desc = "Open diagnostic [d]uickfix list." })

-- Quickfix
map("n", "[q", "<cmd>cprev<cr>", { desc = "[q]uickfix goto_prev" })
map("n", "]q", "<cmd>cnext<cr>", { desc = "[q]uickfix goto_next" })
map("n", "<Leader>q", "<cmd>cclose<cr>", { desc = "[q]uickfix close" })
map("n", "<Leader>Q", "<cmd>copen<cr>", { desc = "[q]uickfix open" })

-- Terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Use vim keys you noob!
map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Vim key window navigation
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

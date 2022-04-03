--------------------------------------------------------
-- => Moving around, tabs, windows and buffers
--------------------------------------------------------
-- Smart way to move between windows
map("n", "<C-j", "C-W>j")
map("n", "<C-k", "C-W>k")
map("n", "<C-h", "C-W>h")
map("n", "<C-l", "C-W>l")

-- Useful mappings for managing tabs
map("n", "<leader>tn", "tabnew<cr>")
map("n", "<leader>to", "tabonly<cr>")
map("n", "<leader>tc", "tabclose<cr>")
map("n", "<leader>tm", "tabmove")
map("n", "<leader>t<leader>", "tabnext")

-- Buffer movement and delete
map("n", "gn", ":bn<cr>")
map("n", "gN", ":bp<cr>")

-- Quickfix
map('n', "<C-k>", "cnext<CR>zz")
map('n', "<C-j>", "cprev<CR>zz")
map('n', "<leader>k", "lnext<CR>zz")
map('n', "<leader>j", "lprev<CR>zz")


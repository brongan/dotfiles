--------------------------------------------------------
-- => Moving around, tabs, windows and buffers
--------------------------------------------------------
-- Smart way to move between windows
vim.keymap.set("n", "<C-j", "C-W>j")
vim.keymap.set("n", "<C-k", "C-W>k")
vim.keymap.set("n", "<C-h", "C-W>h")
vim.keymap.set("n", "<C-l", "C-W>l")

-- Useful mappings for managing tabs
vim.keymap.set("n", "<leader>tn", "tabnew<cr>")
vim.keymap.set("n", "<leader>to", "tabonly<cr>")
vim.keymap.set("n", "<leader>tc", "tabclose<cr>")
vim.keymap.set("n", "<leader>tm", "tabmove")
vim.keymap.set("n", "<leader>t<leader>", "tabnext")

-- Buffer movement and delete
vim.keymap.set("n", "gn", ":bn<cr>")
vim.keymap.set("n", "gN", ":bp<cr>")

-- Quickfix
vim.keymap.set('n', "<C-k>", "cnext<CR>zz")
vim.keymap.set('n', "<C-j>", "cprev<CR>zz")
vim.keymap.set('n', "<leader>k", "lnext<CR>zz")
vim.keymap.set('n', "<leader>j", "lprev<CR>zz")


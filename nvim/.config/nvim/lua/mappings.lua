vim.g.mapleader = ","

-- Fast saving and quit without saving
map('n', '<Leader>w', ':w!<CR>')
map('n', '<Leader>q', ':q!<CR>')

-- Quickly insert an empty new line without entering insert mode, below and above
map('n', '<Space>o', 'o<Esc>k')
map('n', '<Space>O', 'O<Esc>j')

-- Symbols Outline
map('n', "<Leader>s", ":SymbolsOutline<CR>")

-- Comentary
-- map('n', "<space>/", '<cmd>lua require("utils/comment")()<CR>')
-- map('v', "<space>/", '<cmd>lua require("utils/comment")()<CR>')

-- Nvim-Tree
map('n', "<C-n>", ":NvimTreeToggle<CR>")
map('n', "<Leader>r", ":NvimTreeRefresh<CR>")
map('n', "<Leader>n", ":NvimTreeFindFile<CR>")

-- LSP
map('n', "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map('n', "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
map('n', "gr", "<cmd>LspTrouble lsp_references<CR>")
map('n', "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
map('n', "<C-space>", "<cmd>lua vim.lsp.buf.hover()<CR>")
map('v', "<C-space>", "<cmd>RustHoverRange<CR>")

map('n', "ge", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
map('n', "gE", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
map('n', "<silent><Leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map('n', "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
map('n', "<Leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map('v', "<Leader>a", "<cmd>lua vim.lsp.buf.range_code_action()<CR>")

map('n', "<Leader>ld", "<cmd>LspTrouble lsp_definitions<CR>")
map('n', 
  "<Leader>le",
  "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>"
)
map('n', "<Leader>lE", "<cmd>LspTroubleWorkspaceToggle<CR>")

-- Telescope
-- map('n', "<C-f>", ':lua require("utils/telescope").search_files()<CR>')
-- map('n', "/", ':lua require("utils/telescope").search_in_buffer()<CR>')
-- map('i', 
--   "<C-f>",
--   '<Esc> :lua require("utils/telescope").search_in_buffer()<CR>'
-- )
-- map('n', 
--   "<Leader>fg",
--   '<Esc> :lua require("telescope.builtin").live_grep()<CR>'
-- )
-- map('n', 
--   "<Leader>fd",
--   '<Esc> :lua require("utils/telescope").search_dotfiles()<CR>'
-- )

map('n', "<Leader>-", ":FZF <c-r>=fnameescape(expand('%:p:h'))<cr>/<cr>") -- Current file directory
map('n', "<Leader>ff", ":FZF<cr>") -- Search in current directory
map('n', "<Leader>fF", ":Files ~/<cr>") -- Search home directory
map('n', "<Leader>fb", ":Buffers<cr>") -- Open buffers
map('n', "<Leader>fl",  ":Lines<cr>") -- Lines in loaded buffers
map('n', "<Leader>fB", ":BLines<cr>") -- Lines in the current buffer
map('n', "<Leader>ft", ":Tags<cr>") -- Tags in the project
map('n', "<Leader>fh", ":History<cr>") -- v:oldfiles and open buffers
map('n', "<Leader>fH", ":Helptags<cr>") -- Help tags
map('n', "<Leader>f:", ":History:<cr>") -- Vim Command History
map('n', "<Leader>f/", ":History/<cr>") -- Search History
map('n', "<Leader>fg", ":GFiles<cr>") -- Git files (git ls-files)
map('n', "<Leader>fs", ":GFiles?<cr>") -- Git files (git status)
map('n', "<Leader>fc", ":Commits<cr>") -- Git commits (requires fugitive.vim)
map('n', "<Leader>fv", ":Commands<cr>") -- Vim Commands
map('n', "<Leader>fC", ":Colors<cr>") -- Change colorscheme
map('n', "<Leader>fm", ":Marks<cr>") -- View marks
map('n', "<Leader>fr", ":Rg<cr>") -- Ripgrep search result (ALT-A to select all, ALT-D to deselect all)


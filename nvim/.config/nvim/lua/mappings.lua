vim.g.mapleader = ","

-- Fast saving and quit without saving
vim.keymap.set('n', '<Leader>w', ':w!<CR>')
vim.keymap.set('n', '<Leader>q', ':q!<CR>')
vim.keymap.set('n', 'bd', ':bd<CR>')

-- Quickly insert an empty new line without entering insert mode, below and above
vim.keymap.set('n', '<Space>o', 'o<Esc>k')
vim.keymap.set('n', '<Space>O', 'O<Esc>j')

-- Attempt to copy to system clipboard regardless of ssh/tmux.
vim.keymap.set('v', '<Leader>c', ':OSCYank<cr>')
vim.keymap.set('n', '<Leader>o', '<Plug>OSCYank')

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true, noremap=true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    bufmap('n', '<C-space>', '<cmd>RustHoverRange<cr>')

    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

    -- Jumps to the definition of the type symbol
    bufmap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Lists all the references 
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

    -- Displays a function's signature information
    bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    bufmap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<Leader>a', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<Leader>a', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
	bufmap('n', "<Leader>ld", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")

    -- Move to the previous diagnostic
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    -- Move to the next diagnostic
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

	bufmap("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
	bufmap("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")

	bufmap('n', "<Leader>ld", "<cmd>TroubleToggle lsp_definitions<CR>")
	bufmap('n', "<Leader>lE", "<cmd>TroubleToggle workspace_diagnostics<CR>")
  end
})

-- FZF
vim.keymap.set('n', "<Leader>-", ":FZF <c-r>=fnameescape(expand('%:p:h'))<cr>/<cr>") -- Current file directory
vim.keymap.set('n', "<Leader>ff", ":FZF<cr>") -- Search in current directory
vim.keymap.set('n', "<Leader>fF", ":Files ~/<cr>") -- Search home directory
vim.keymap.set('n', "<Leader>fb", ":Buffers<cr>") -- Open buffers
vim.keymap.set('n', "<Leader>fl",  ":Lines<cr>") -- Lines in loaded buffers
vim.keymap.set('n', "<Leader>fB", ":BLines<cr>") -- Lines in the current buffer
vim.keymap.set('n', "<Leader>ft", ":Tags<cr>") -- Tags in the project
vim.keymap.set('n', "<Leader>fh", ":History<cr>") -- v:oldfiles and open buffers
vim.keymap.set('n', "<Leader>fH", ":Helptags<cr>") -- Help tags
vim.keymap.set('n', "<Leader>f:", ":History:<cr>") -- Vim Command History
vim.keymap.set('n', "<Leader>f/", ":History/<cr>") -- Search History
vim.keymap.set('n', "<Leader>fg", ":GFiles<cr>") -- Git files (git ls-files)
vim.keymap.set('n', "<Leader>fs", ":GFiles?<cr>") -- Git files (git status)
vim.keymap.set('n', "<Leader>fc", ":Commits<cr>") -- Git commits (requires fugitive.vim)
vim.keymap.set('n', "<Leader>fv", ":Commands<cr>") -- Vim Commands
vim.keymap.set('n', "<Leader>fC", ":Colors<cr>") -- Change colorscheme
vim.keymap.set('n', "<Leader>fm", ":Marks<cr>") -- View marks
vim.keymap.set('n', "<Leader>fr", ":Rg<cr>") -- Ripgrep search result (ALT-A to select all, ALT-D to deselect all)

vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

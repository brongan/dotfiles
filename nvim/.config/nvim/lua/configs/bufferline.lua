-- colors for active , inactive buffer tabs
require("bufferline").setup({
	options = {
		separator_style = "thin",
		tab_size = 30,
		enforce_regular_tabs = true,
		how_buffer_icons = true,
		diagnostics = "nvim_lsp",
	},
})

-- These commands will navigate through buffers in order regardless of which mode you are using
-- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
vim.keymap.set('n', "b[", ":BufferLineCyclePrev<CR>")
vim.keymap.set('n', "b]", ":BufferLineCycleNext<CR>")

-- These commands will sort buffers by directory or language
vim.keymap.set('n', 'be', ':BufferLineSortByExtension<CR>')
vim.keymap.set('n', 'br', ':BufferLineSortByDirectory<CR>')

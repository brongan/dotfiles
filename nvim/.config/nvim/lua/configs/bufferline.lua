local map = vim.keymap.set
return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
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
			map('n', "b[", ":BufferLineCyclePrev<CR>")
			map('n', "b]", ":BufferLineCycleNext<CR>")

			-- These commands will sort buffers by directory or language
			map('n', 'be', ':BufferLineSortByExtension<CR>')
			map('n', 'br', ':BufferLineSortByDirectory<CR>')
		end
	},
}

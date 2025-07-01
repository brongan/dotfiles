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
			map("n", "[b", ":BufferLineCyclePrev<CR>", { desc = "Goto previous [b]uffer" })
			map("n", "]b", ":BufferLineCycleNext<CR>", { desc = "Goto next [b]uffer" })
			map("n", "b[", ":BufferLineCyclePrev<CR>", { desc = "Goto previous [b]uffer" })
			map("n", "b]", ":BufferLineCycleNext<CR>", { desc = "Goto next [b]uffer" })
			map("n", "eb", ":BufferLineSortByExtension<CR>", { desc = "[B]ufferline sort by [E]xtension" })
			map("n", "rb", ":BufferLineSortByDirectory<CR>", { desc = "[B]ufferline sort by [D]irectory" })
		end,
	},
}

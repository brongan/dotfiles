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
					diagnostics = "nvim_lsp",
				},
			})
			-- Navigation
			map("n", "[b", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
			map("n", "]b", "<cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })

			-- Re-ordering (Move buffer position)
			map("n", "<Leader>bl", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })
			map("n", "<Leader>br", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })

			-- Pinning
			map("n", "<Leader>bp", "<cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin Buffer" })

			-- Sorting
			map("n", "<Leader>se", "<cmd>BufferLineSortByExtension<CR>", { desc = "Sort by Extension" })
			map("n", "<Leader>sd", "<cmd>BufferLineSortByDirectory<CR>", { desc = "Sort by Dir" })
		end,
	},
}

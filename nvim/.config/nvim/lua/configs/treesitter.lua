return {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter",
		opts = {
			ensure_installed = {
				"c",
				"vim",
				"vimdoc",
				"query",
				"rust",
				"cpp",
				"proto",
				"bash",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"wgsl",
			},
			auto_install = false,
		},
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true,
				max_lines = 1,
				min_window_height = 0,
				line_numbers = true,
				multiline_threshold = 20,
				trim_scope = "outer",
				mode = "cursor",
				separator = nil,
				zindex = 20,
			})
			vim.filetype.add({
				pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
			})
		end,
	},
}

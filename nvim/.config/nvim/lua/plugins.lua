local username = os.getenv("USER")
local work_plugins = {}
if username == "brennantracy" then
	work_plugins = require("google")
	print("Loaded Google config.")
else
	print("Loaded Personal config.")
end

local map = vim.keymap.set

return {
	require("configs.bufferline"),
	require("configs.treesitter"),
	require("configs.lsp"),
	require("configs.telescope"),
	require("configs.nvim-cmp"),
	require("configs.conform"),
	"tpope/vim-surround",
	{ "williamboman/mason.nvim", opts = {} },
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		ft = { "dart" },
		config = true,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = { transparent_background = true, flavor = "mocha" },
	},
	{
		"eandrju/cellular-automaton.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			map("n", "<Leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")
		end,
	},
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{
				"<Leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				{ desc = "Diagnostics (Trouble)" },
			},
			{
				"<Leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				{ desc = "Buffer Diagnostics (Trouble)" },
			},
			{
				"<Leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				{ desc = "Symbols (Trouble)" },
			},
			{
				"<Leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				{ desc = "LSP Definitions / references / ... (Trouble)" },
			},
			{
				"<Leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				{ desc = "Location List (Trouble)" },
			},
			{
				"<Leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				{ desc = "Quickfix List (Trouble)" },
			},
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup({})
		end,
	}, -- Pretty indentations
	{
		"mhinz/vim-signify",
		config = function()
			-- A small `updatetime` is preferred to update signs as files are updated
			-- The default `updatetime` is 4000
			vim.opt.updatetime = 500
			vim.api.nvim_set_hl(0, "SignifySignAdd", { ctermfg = "green", fg = "#79b7a5" })
			vim.api.nvim_set_hl(0, "SignifySignChange", { ctermfg = "yellow", fg = "#ffffcc" })
			vim.api.nvim_set_hl(0, "SignifySignChangeDelete", { ctermfg = "red", fg = "#ff7b72" })
			vim.api.nvim_set_hl(0, "SignifySignDelete", { ctermfg = "red", fg = "#ff7b72" })
			vim.api.nvim_set_hl(0, "SignifySignDeleteDeleteFirstLine", { ctermfg = "red", fg = "#ff7b72" })
		end,
		keys = {
			{ "[h", "<Plug>(signify-prev-hunk)", desc = "Goto previous [h]unk" },
			{ "]h", "<Plug>(signify-next-hunk)", desc = "Goto next [h]unk" },
			{ "[H", "<cmd>normal 9999[c<cr>", desc = "Goto first [h]unk" },
			{ "]H", "<cmd>normal 9999]c<cr>", desc = "Goto last [h]unk" },
			{ "ih", "<Plug>(signify-motion-inner-pending)", desc = "[H]unk text object", mode = "o" },
			{ "ih", "<Plug>(signify-motion-inner-visual)", desc = "[H]unk text object", mode = "x" },
			{ "ah", "<Plug>(signify-motion-outer-pending)", desc = "[H]unk text object", mode = "o" },
			{ "ah", "<Plug>(signify-motion-outer-pending)", desc = "[H]unk text object", mode = "x" },
		},
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	}, -- Highlights colors
	"psliwka/vim-smoothie", -- Smooth scrolling
	"tpope/vim-eunuch", -- :SudoEdit and :Chmod and :Mkdir
	"tpope/vim-fugitive", -- :Git
	"tpope/vim-speeddating", -- Allows for incrementing/decrementing timestamps
	{
		"ojroques/nvim-osc52",
		config = function()
			map("n", "<leader>c", require("osc52").copy_operator, { expr = true, desc = "[c]opy to clipboard." })
			map("n", "<leader>cc", "<leader>c_", { remap = true, desc = "[c]opy the current line." })
			map("v", "<leader>c", require("osc52").copy_visual, { desc = "[c]opy the current selection." })
		end,
	},
	{ "folke/lazydev.nvim", ft = "lua" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			config = function()
				---@diagnostic disable-next-line: undefined-field
				require("lualine").setup({})
			end,
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			background_color = "#000000",
		},
	},
	{
		"kylechui/nvim-surround",
		version = "^3.0.0",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	unpack(work_plugins),
}

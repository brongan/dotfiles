local username = os.getenv("USER")
local work_plugins = {}

-- Conditionally load work plugins
if username == "brennantracy" then
	local ok, mod = pcall(require, "google")
	if ok then
		work_plugins = mod
		print("Loaded Google config.")
	end
else
	print("Loaded Personal config.")
end

-- Define core plugins
local plugins = {
	-- Local modules
	require("configs.bufferline"),
	require("configs.treesitter"),
	require("configs.lsp"),
	require("configs.telescope"),
	require("configs.nvim-cmp"),
	require("configs.conform"),

	-- LSP & Tools
	{ "williamboman/mason.nvim", opts = {} },
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
	},
	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
		ft = { "dart" },
		config = true,
	},
	{ "folke/lazydev.nvim",      ft = "lua" },

	-- UI & Themes
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = { transparent_background = true, flavor = "mocha" },
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {},
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			background_colour = "#000000",
			render = "default",
			stages = "fade",
		},
		config = function(_, opts)
			local notify = require("notify")
			local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
			if bg then
				opts.background_colour = string.format("#%06x", bg)
			else
				opts.background_colour = "#000000"
			end
			notify.setup(opts)
			vim.notify = notify
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	-- Smooth scrolling (Replacement for vim-smoothie)
	{ "karb94/neoscroll.nvim", opts = {} },

	-- Git
	"tpope/vim-fugitive",
	{
		"lewis6991/gitsigns.nvim", -- Replacement for vim-signify
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
		keys = {
			{ "]h",         "<cmd>Gitsigns next_hunk<cr>",                 desc = "Next Hunk" },
			{ "[h",         "<cmd>Gitsigns prev_hunk<cr>",                 desc = "Prev Hunk" },
			{ "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>",              desc = "Preview Hunk" },
			{ "<leader>hb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle Line Blame" },
		},
	},

	-- Utility / Editing
	{
		"kylechui/nvim-surround",
		version = "^3.0.0",
		event = "VeryLazy",
		config = true,
	},
	{ "numToStr/Comment.nvim", opts = {} },
	{ "stevearc/oil.nvim",     opts = {} },
	"tpope/vim-eunuch",
	"tpope/vim-speeddating",
	{
		"eandrju/cellular-automaton.nvim",
		keys = {
			{ "<Leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "Make it rain" },
		},
	},

	-- Diagnostics
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = {},
		keys = {
			{ "<Leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (Trouble)" },
			{ "<Leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer Diagnostics (Trouble)" },
			{ "<Leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)" },
			{ "<Leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Defs/Refs (Trouble)" },
			{ "<Leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)" },
			{ "<Leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)" },
		},
	},

	-- Markdown
	{
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	}
	,

	-- Clipboard (OSC52)
	{
		"ojroques/nvim-osc52",
		keys = {
			{ "<leader>c",  function() return require("osc52").copy_operator() end, expr = true,  desc = "Copy to clipboard" },
			{ "<leader>cc", "<leader>c_",                                           remap = true, desc = "Copy line" },
			{ "<leader>c",  function() return require("osc52").copy_visual() end,   mode = "v",   desc = "Copy selection" },
		},
	},

	-- Keybinding helper
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},
	"rafikdraoui/jj-diffconflicts",
	{
		"robitx/gp.nvim",
		config = function()
			local conf = {
				providers = {
					openai = {
						disable = true,
					},
					llamacpp = {
						endpoint = "http://localhost:8080/v1/chat/completions",
						secret = "none",
					},
				},
				agents = {
					{
						name = "Gemma4",
						chat = true,
						command = true,
						model = { model = "gemma-4-26B-A4B-it-GGUF" },
						system_prompt =
						"You are Gemma 4, an advanced 26B parameter coding assistant running locally via llama.cpp. You provide precise, expert-level code and technical explanations, utilizing your large contextwindow to analyze complex structures.",
						provider = "llamacpp",
					},
				},
			}
			require("gp").setup(conf)
		end,
	}
	,
}

-- Merge work plugins into the main list
vim.list_extend(plugins, work_plugins)

return plugins

local map = vim.keymap.set
return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function() return vim.fn.executable("make") == 1 end,
		},
		"nvim-telescope/telescope-ui-select.nvim",
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	keys = {
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>",       desc = "[F]uzzy [H]elp" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>",         desc = "[F]uzzy [K]eymaps" },
		{ "<leader>ff", "<cmd>Telescope find_files<cr>",      desc = "[F]uzzy [F]iles" },
		{ "<leader>fs", "<cmd>Telescope git_status<cr>",      desc = "[F]uzzy Git [S]tatus" },
		{ "<leader>fg", "<cmd>Telescope git_files<cr>",       desc = "[F]uzzy [G]it Files" },
		{ "<leader>fd", "<cmd>Telescope diagnostics<cr>",     desc = "[F]uzzy [D]iagnostics" },
		{ "<leader>fr", "<cmd>Telescope resume<cr>",          desc = "[F]uzzy [R]esume" },
		{ "<leader>fq", "<cmd>Telescope quickfix<cr>",        desc = "[F]uzzy [Q]uickfix" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>",         desc = "[F]uzzy [B]uffers" },
		{ "<leader>f.", "<cmd>Telescope oldfiles<cr>",        desc = '[F]uzzy Recent Files ("." for repeat)' },
		{ "<leader>fc", "<cmd>Telescope commands<cr>",        desc = "[F]uzzy [C]ommands" },
		{ "<leader>f/", "<cmd>Telescope search_history<cr>",  desc = "[F]uzzy Search History" },
		{ "<leader>f:", "<cmd>Telescope command_history<cr>", desc = "[F]uzzy Command History" },

		-- Search Content
		{ "<leader>fB", "<cmd>Telescope live_grep<cr>",       desc = "[F]uzzy Grep [P]roject (Ripgrep)" },
		{
			"<leader>fl",
			function()
				require("telescope.builtin").live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end,
			desc = "[F]uzzy [L]ines (Open Buffers)"
		},
		{
			"<leader>/",
			function()
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end,
			desc = "[/] Fuzzily search in current buffer"
		}
	},
	config = function()
		require("telescope").setup({
			defaults = {
				layout_strategy = "horizontal",
				layout_config = { horizontal = { width = 0.90 } },
				mappings = {
					i = {
						["<C-h>"] = "which_key",
						-- Quick actions inside telescope
						["<C-u>"] = false,
						["<C-d>"] = false,
					},
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
	end,
}

local ok, google = pcall(require, "google")
if ok then
	print("Loaded Google config.")
else
	print("Loaded Personal config.")
end

local map = vim.keymap.set;

return {
	require("configs.bufferline"),
	require("configs.treesitter"),
	require("configs.lsp"),
	require("configs.telescope"),
	require("configs.nvim-cmp"),
	{ "williamboman/mason.nvim",    opts = {} },
	{ "akinsho/flutter-tools.nvim", opts = {} },
	{ "catppuccin/nvim",            name = "catppuccin", priority = 1000, opts = { transparent_background = true, flavor = "mocha" }, },
	{
		"eandrju/cellular-automaton.nvim",
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		config = function()
			map("n", "<Leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");
		end
	},
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{
				'<Leader>xx',
				"<cmd>Trouble diagnostics toggle<cr>",
				{ desc = "Diagnostics (Trouble)" },
			},
			{
				'<Leader>xX',
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				{ desc = "Buffer Diagnostics (Trouble)" },
			},
			{
				'<Leader>cs',
				"<cmd>Trouble symbols toggle focus=false<cr>",
				{ desc = "Symbols (Trouble)" },
			},
			{
				'<Leader>cl',
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				{ desc = "LSP Definitions / references / ... (Trouble)" },
			},
			{
				'<Leader>xL',
				"<cmd>Trouble loclist toggle<cr>",
				{ desc = "Location List (Trouble)" },
			},
			{
				'<Leader>xQ',
				"<cmd>Trouble qflist toggle<cr>",
				{ desc = "Quickfix List (Trouble)" },
			},
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	{
		"junegunn/fzf.vim",
		dependencies = "junegunn/fzf",
		config = function()
			map('n', "<Leader>-", ":FZF <c-r>=fnameescape(expand('%:p:h'))<cr>/<cr>") -- Current file directory
			map('n', "<Leader>ff", ":FZF<cr>")                               -- Search in current directory
			map('n', "<Leader>fF", ":Files ~/<cr>")                          -- Search home directory
			map('n', "<Leader>fb", ":Buffers<cr>")                           -- Open buffers
			map('n', "<Leader>fl", ":Lines<cr>")                             -- Lines in loaded buffers
			map('n', "<Leader>fB", ":BLines<cr>")                            -- Lines in the current buffer
			map('n', "<Leader>ft", ":Tags<cr>")                              -- Tags in the project
			map('n', "<Leader>fh", ":History<cr>")                           -- v:oldfiles and open buffers
			map('n', "<Leader>fH", ":Helptags<cr>")                          -- Help tags
			map('n', "<Leader>f:", ":History:<cr>")                          -- Vim Command History
			map('n', "<Leader>f/", ":History/<cr>")                          -- Search History
			map('n', "<Leader>fg", ":GFiles<cr>")                            -- Git files (git ls-files)
			map('n', "<Leader>fs", ":GFiles?<cr>")                           -- Git files (git status)
			map('n', "<Leader>fc", ":Commits<cr>")                           -- Git commits (requires fugitive.vim)
			map('n', "<Leader>fv", ":Commands<cr>")                          -- Vim Commands
			map('n', "<Leader>fC", ":Colors<cr>")                            -- Change colorscheme
			map('n', "<Leader>fm", ":Marks<cr>")                             -- View marks
			map('n', "<Leader>fr", ":Rg<cr>")                                -- Ripgrep search result (ALT-A to select all, ALT-D to deselect all)
		end
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup({})
		end
	},                                               -- Pretty indentations
	"mhinz/vim-signify",                             -- Show changed lines from VCS
	{ "norcalli/nvim-colorizer.lua", opts = { "*" }, }, -- Highlights colors
	{ "L3MON4D3/LuaSnip",            version = "v2.*", },
	"psliwka/vim-smoothie",                          -- Smooth scrolling
	"tpope/vim-commentary",                          -- gc + motion comments out lines
	"tpope/vim-eunuch",                              -- :SudoEdit and :Chmod and :Mkdir
	"tpope/vim-fugitive",                            -- :Git
	"tpope/vim-repeat",                              -- Required for vim-surround
	"tpope/vim-speeddating",                         -- Allows for incrementing/decrementing timestamps
	"tpope/vim-surround",                            -- Surround is bae
	{
		"ojroques/nvim-osc52",
		config = function()
			map('n', '<leader>c', require('osc52').copy_operator,
				{ expr = true, desc = "[c]opy to clipboard." })
			map('n', '<leader>cc', '<leader>c_', { remap = true, desc = "[c]opy the current line." })
			map('v', '<leader>c', require('osc52').copy_visual, { desc = "[c]opy the current selection." })
		end
	},
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	{ "folke/lazydev.nvim", ft = "lua" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			config = function()
				---@diagnostic disable-next-line: undefined-field
				require('lualine').setup {}
			end
		}
	},
	{                 -- Useful plugin to show you pending keymaps.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to "VimEnter"
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document existing key chains
			require("which-key").register {
				["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
				["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
				["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
				["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
				["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
				["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
				["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
			}
			-- visual mode
			require("which-key").register({
				["<leader>h"] = { "Git [H]unk" },
			}, { mode = "v" })
		end,
	},
	unpack(ok and google or {}),
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local work_plugins = {}
local ok, google = pcall(require, "google")
if ok then
	work_plugins = google.plugins
end

local plugins = {
	"akinsho/flutter-tools.nvim",
	"akinsho/nvim-bufferline.lua", -- Top bar buffers thing tabs
	"akinsho/toggleterm.nvim",
	"catppuccin/nvim",
	"eandrju/cellular-automaton.nvim",
	"folke/lazy.nvim",
	"folke/trouble.nvim",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-path",
	"hrsh7th/nvim-cmp", -- Autocompletion
	"iamcco/markdown-preview.nvim",
	"junegunn/fzf",
	"junegunn/fzf.vim",
	"lukas-reineke/indent-blankline.nvim", -- Pretty indentations
	"mhinz/vim-signify",                -- Show changed lines from VCS
	"neovim/nvim-lspconfig",            -- Collection of configurations for the built-in LSP client
	"norcalli/nvim-colorizer.lua",      -- Highlights colors
	"nvim-lua/plenary.nvim",
	"nvim-treesitter/nvim-treesitter",  -- Highlighting based on syntax tree
	"nvim-treesitter/nvim-treesitter-context",
	"onsails/lspkind.nvim",             -- LSP Symbols
	"p00f/clangd_extensions.nvim",
	"psliwka/vim-smoothie",             -- Smooth scrolling
	"ray-x/lsp_signature.nvim",         -- give me those function signatures
	"tpope/vim-commentary",             -- gc + motion comments out lines
	"tpope/vim-eunuch",                 -- :SudoEdit and :Chmod and :Mkdir
	"tpope/vim-fugitive",               -- :Git
	"tpope/vim-repeat",                 -- Required for vim-surround
	"tpope/vim-speeddating",            -- Allows for incrementing/decrementing timestamps
	"tpope/vim-surround",               -- Surround is bae
	"wincent/terminus",                 -- Fixes mouse + paste
	"windwp/nvim-ts-autotag",
	'ojroques/nvim-osc52',
	'saadparwaiz1/cmp_luasnip',
	'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
	{ "folke/lazydev.nvim",        ft = "lua" },
	{ "L3MON4D3/LuaSnip",          dependencies = { "rafamadriz/friendly-snippets" }, },
	{ 'j-hui/fidget.nvim',         opts = {} }, -- Useful status updates for LSP.
	{ "nvim-lualine/lualine.nvim", dependencies = { 'nvim-tree/nvim-web-devicons' } },
	{ 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
	{ 'williamboman/mason.nvim',   config = true,                                     opt = {}, },
	{                 -- Useful plugin to show you pending keybinds.
		'folke/which-key.nvim',
		event = 'VimEnter', -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require('which-key').setup()

			-- Document existing key chains
			require('which-key').register {
				['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
				['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
				['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
				['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
				['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
				['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
				['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
			}
			-- visual mode
			require('which-key').register({
				['<leader>h'] = { 'Git [H]unk' },
			}, { mode = 'v' })
		end,
	},
	unpack(work_plugins),
}

require("lazy").setup(plugins, {});

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
	"L3MON4D3/LuaSnip",
	"akinsho/flutter-tools.nvim",
	"akinsho/nvim-bufferline.lua", -- Top bar buffers thing tabs
	"akinsho/toggleterm.nvim",
	"catppuccin/nvim",
	"eandrju/cellular-automaton.nvim",
	"famiu/feline.nvim", -- StatusLine
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
	"nvim-treesitter/nvim-treesitter", -- Highlighting based on syntax tree
	"nvim-treesitter/nvim-treesitter-context",
	"onsails/lspkind.nvim",         -- LSP Symbols
	"p00f/clangd_extensions.nvim",
	"psliwka/vim-smoothie",         -- Smooth scrolling
	"ray-x/lsp_signature.nvim",     -- give me those function signatures
	"tpope/vim-commentary",         -- gc + motion comments out lines
	"tpope/vim-eunuch",             -- :SudoEdit and :Chmod and :Mkdir
	"tpope/vim-fugitive",           -- :Git
	"tpope/vim-repeat",             -- Required for vim-surround
	"tpope/vim-speeddating",        -- Allows for incrementing/decrementing timestamps
	"tpope/vim-surround",           -- Surround is bae
	"wincent/terminus",             -- Fixes mouse + paste
	"windwp/nvim-ts-autotag",
	'ojroques/nvim-osc52',
	'saadparwaiz1/cmp_luasnip',
	{ "folke/lazydev.nvim",        ft = "lua" },
	{ 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
	{"nvim-lualine/lualine.nvim",  dependencies = { 'nvim-tree/nvim-web-devicons' }},
	unpack(work_plugins),
}

require("lazy").setup(plugins, {});

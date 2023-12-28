vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
		install_path })
end

local packer = require('packer')

return packer.startup(function(use)
	use("L3MON4D3/LuaSnip")
	use('saadparwaiz1/cmp_luasnip')
	use("akinsho/nvim-bufferline.lua") -- Top bar buffers thing tabs
	use("akinsho/toggleterm.nvim")
	use("eandrju/cellular-automaton.nvim")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-path")
	use("hrsh7th/nvim-cmp") -- Autocompletion
	use("junegunn/fzf")
	use("junegunn/fzf.vim")
	use("lukas-reineke/indent-blankline.nvim") -- Pretty indentations
	use("lvimuser/lsp-inlayhints.nvim")
	use("mhinz/vim-signify")                -- Show changed lines from VCS
	use("morhetz/gruvbox")
	use("neovim/nvim-lspconfig")            -- Collection of configurations for the built-in LSP client
	use("norcalli/nvim-colorizer.lua")      -- Highlights colors
	use("nvim-treesitter/nvim-treesitter-context")
	use("onsails/lspkind.nvim")             -- LSP Symbols
	use("p00f/clangd_extensions.nvim")
	use("psliwka/vim-smoothie")             -- Smooth scrolling
	use("ray-x/lsp_signature.nvim")         -- give me those function signatures
	use("tpope/vim-commentary")             -- gc + motion comments out lines
	use("tpope/vim-eunuch")                 -- :SudoEdit and :Chmod and :Mkdir
	use("tpope/vim-fugitive")               -- :Git
	use("tpope/vim-repeat")                 -- Required for vim-surround
	use("tpope/vim-speeddating")            -- Allows for incrementing/decrementing timestamps
	use("tpope/vim-surround")               -- Surround is bae
	use("wbthomason/packer.nvim")           -- Packer can manage itself
	use("wincent/terminus")                 -- Fixes mouse + paste
	use("windwp/nvim-ts-autotag")
	use('ojroques/nvim-osc52')
	use({ "akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim" })
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({ "famiu/feline.nvim", branch = "master" }) -- StatusLine
	use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" })
	use({ "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end })
	use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- Highlighting based on syntax tree
	use({ 'VonHeikemen/lsp-zero.nvim', branch = 'v2.x' })
	local ok, _ = pcall(require, "google")
	if ok then
		for i, plugin in ipairs(require("google").plugins) do
			use(plugin)
		end
	end
	-- Automatically set up your configuration after cloning packer.nvim
	if packer_bootstrap then
		packer.sync()
	end
end)

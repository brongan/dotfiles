vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local packer = require('packer')

return packer.startup(function(use)
	use("JoosepAlviste/nvim-ts-context-commentstring") -- handles embedded languages
	use("RishabhRD/nvim-lsputils") -- Sensible defaults for lsp
	use("RishabhRD/popfix") -- Dependency for something
	use("akinsho/nvim-bufferline.lua") -- Top bar buffers thing tabs
	use("akinsho/toggleterm.nvim")
	use("hrsh7th/cmp-buffer")
	use({"folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons"})
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-emoji")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/nvim-cmp") -- Autocompletion
	use("hrsh7th/vim-vsnip")
	use("iamcco/vim-language-server")
	use("junegunn/fzf")
	use("junegunn/fzf.vim")
	use("kyazdani42/nvim-web-devicons") -- needed by lualine
	use("lukas-reineke/indent-blankline.nvim") -- Pretty indentations
	use("mfussenegger/nvim-dap") -- Debugging
	use("mg979/vim-visual-multi") -- Change multiple lines at once
	use("mhinz/vim-signify") -- Show changed lines from VCS
	use("morhetz/gruvbox")
	use("neovim/nvim-lspconfig") -- Collection of configurations for the built-in LSP client
	use("norcalli/nvim-colorizer.lua") -- Highlights colors
	use("ojroques/vim-oscyank") -- Escape code based copy paste
	use("onsails/lspkind.nvim")
	use("psliwka/vim-smoothie") -- Smooth scrolling
	use("ray-x/lsp_signature.nvim") -- give me those function signatures
	use("sumneko/lua-language-server")
	use("tpope/vim-commentary") -- gc + motion comments out lines
	use("tpope/vim-eunuch") -- :SudoEdit and :Chmod and :Mkdir
	use("tpope/vim-fugitive")
	use("tpope/vim-repeat") -- Required for vim-surround
	use("tpope/vim-scriptease") -- Neovim plugin development
	use("tpope/vim-speeddating") -- Allows for incrementing/decrementing timestamps
	use("tpope/vim-surround")  -- Surround is bae
	use("vim-syntastic/syntastic") -- Syntax Checker
	use("wbthomason/packer.nvim") -- Packer can manage itself
	use("williamboman/nvim-lsp-installer")
	use("wincent/terminus") -- Fixes mouse + paste
	use({"akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim"})
	use({"famiu/feline.nvim", branch = "master" }) -- StatusLine
	use({"nvim-lualine/lualine.nvim",requires = { "kyazdani42/nvim-web-devicons", opt = true }	})
	use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- Highlighting based on syntax tree
	use({"rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }) -- Debugging UI
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


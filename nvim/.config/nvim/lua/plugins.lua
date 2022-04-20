require("packer").startup(function(use)
	use("JoosepAlviste/nvim-ts-context-commentstring") -- handles embedded languages
	use("L3MON4D3/LuaSnip")
	use("RishabhRD/nvim-lsputils") -- Sensible defaults for lsp
	use("RishabhRD/popfix") -- Dependency for something
	use("airblade/vim-rooter") -- maybe use if this is pain
	use("akinsho/nvim-bufferline.lua") -- Top bar buffers thing tabs
	use("akinsho/toggleterm.nvim")
	use("antoinemadec/FixCursorHold.nvim")
	use("folke/trouble.nvim") -- Unifies LSP stuff with quickfix stuff and telescope
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-emoji")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/nvim-cmp") -- Autocompletion
	use("hrsh7th/vim-vsnip")
	use("iamcco/vim-language-server")
	use("kyazdani42/nvim-web-devicons") -- needed by lualine
	use("lewis6991/gitsigns.nvim") -- Alternative to signfiy TODO: Decide if I should remove
	use("lukas-reineke/indent-blankline.nvim") -- Pretty indentations
	use("mfussenegger/nvim-dap") -- Debugging
	use("mg979/vim-visual-multi") -- Change multiple lines at once
	use("mhinz/vim-signify") -- Show changed lines from VCS
	use("mhinz/vim-startify") -- start screen
	use("neovim/nvim-lspconfig") -- Collection of configurations for the built-in LSP client
	use("neovim/nvim-lspconfig") -- L S P
	use("norcalli/nvim-colorizer.lua") -- Highlights colors
	use("nvim-lua/plenary.nvim")
	use("nvim-lualine/lualine.nvim") -- have been told this is faster than airline
	use("nvim-treesitter/playground") -- Show treesitter info in window
	use("ojroques/vim-oscyank") -- Escape code based copy paste
	use("psliwka/vim-smoothie") -- Smooth scrolling
	use("ray-x/lsp_signature.nvim") -- give me those function signatrues
	use("simrat39/rust-tools.nvim")
	use("sumneko/lua-language-server")
	use("tpope/vim-commentary") -- gc + motion comments out lines
	use("tpope/vim-eunuch") -- :SudoEdit and :Chmod and :Mkdir
	use("tpope/vim-fugitive")
	use("tpope/vim-repeat") -- Required for vim-surround
	use("tpope/vim-scriptease") -- Neovim plugin development
	use("tpope/vim-speeddating") -- Allows for incrementing/decrementing timestamps
	use("tpope/vim-surround")  -- Surround is bae
	use("vim-syntastic/syntastic") -- Syntax Checker
	use("williamboman/nvim-lsp-installer")
	use("wincent/terminus") -- Fixes mouse + paste
	use("windwp/nvim-autopairs") -- Trendy new autopairs
	use('junegunn/fzf')
	use('junegunn/fzf.vim')
	use('morhetz/gruvbox')
	use('nvim-lua/plenary.nvim')
	use('wbthomason/packer.nvim') -- Packer can manage itself
	use({ "famiu/feline.nvim", branch = "develop" }) -- StatusLine
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- Highlighting based on syntax tree
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" }, { "nvim-lua/popup.nvim" } },
	})
	use({
		"romgrk/fzy-lua-native",
		requires = { { "nvim-telescope/telescope.nvim" } },
	})
	use({
		"nvim-telescope/telescope-fzy-native.nvim",
		requires = { { "nvim-telescope/telescope.nvim" } },
	})
end)


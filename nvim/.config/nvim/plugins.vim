" Plugins
call plug#begin('$XDG_DATA_HOME/nvim/plugged')

Plug 'L3MON4D3/LuaSnip'
Plug 'sumneko/lua-language-server'
Plug 'iamcco/vim-language-server'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp' " Autocompletion
Plug 'junegunn/fzf' " Fuzzy Finder
Plug 'junegunn/fzf.vim' " Fuzzy Finder Vim Extension
Plug 'kyazdani42/nvim-web-devicons' " needed by lualine
Plug 'lervag/vimtex' " Latex
Plug 'lukas-reineke/indent-blankline.nvim' " Pretty indentations
Plug 'mfussenegger/nvim-dap' " Debugging
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " Change multiple lines at once
Plug 'mhinz/vim-signify' " Show changed lines from VCS
Plug 'neovim/nvim-lspconfig' " L S P
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lualine/lualine.nvim' " have been told this is faster than airline
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " Highlighting based on syntax tree
Plug 'ojroques/vim-oscyank' " Escape code based copy paste
Plug 'psliwka/vim-smoothie' " Smooth scrolling
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'simrat39/rust-tools.nvim'
Plug 'tpope/vim-commentary' " gc + motion comments out lines
Plug 'tpope/vim-eunuch' " :SudoEdit and :Chmod and :Mkdir
Plug 'tpope/vim-repeat' " Required for vim-surround
Plug 'tpope/vim-speeddating' " Allows for incrementing/decrementing timestamps
Plug 'tpope/vim-surround'  " Surround is bae
Plug 'vim-syntastic/syntastic' " Syntax Checker
Plug 'wincent/terminus' " Fixes mouse + paste

" Initialize plugin system
call plug#end()


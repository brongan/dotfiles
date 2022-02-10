" Plugins
call plug#begin('$XDG_DATA_HOME/nvim/plugged')

Plug 'google/vim-codefmt'
Plug 'google/vim-maktaba'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'kovetskiy/sxhkd-vim'
Plug 'lervag/vimtex'
Plug 'michaeljsmith/vim-indent-object'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'ojroques/vim-oscyank'
Plug 'psliwka/vim-smoothie'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wellle/targets.vim'
Plug 'wincent/terminus'

" Initialize plugin system
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => XDG path configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath^=${XDG_CONFIG_HOME}/nvim runtimepath+=${XDG_DATA_HOME}/nvim runtimepath+=${XDG_DATA_HOME}/nvim/after
set packpath^=${XDG_DATA_HOME}/nvim,${XDG_CONFIG_HOME}/nvim
set packpath+=${XDG_CONFIG_HOME}/nvim/after,${XDG_DATA_HOME}/nvim/after

call mkdir($XDG_DATA_HOME."/vim/spell", 'p')
set viewdir=$XDG_DATA_HOME/vim/view | call mkdir(&viewdir, 'p')

set backupdir=${XDG_CACHE_HOME}/vim/backup | call mkdir(&backupdir, 'p')
set directory=${XDG_CACHE_HOME}/vim/swap   | call mkdir(&directory, 'p')
set undodir=${XDG_CACHE_HOME}/vim/undo	   | call mkdir(&undodir,	'p')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Fast quit without saving
nmap <leader>q :q!<cr>

" Disable middle button paste
:map <MiddleMouse> <Nop>
:imap <MiddleMouse> <Nop>

" Consecutive visual increment
vnoremap <C-a> g<C-a>
vnoremap g<C-a> <C-a>

" Remove all trailing whitespace by pressing F2
nnoremap <F2> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Move highlighted section up and down vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Quickly insert an empty new line without entering insert mode, below and above
nnoremap <space>o o<Esc>k
nnoremap <space>O O<Esc>j

if exists(':tnoremap')
	" Disable Python 2 support
	let g:loaded_python_provider = 0
	" Disable Ruby support
	let g:loaded_ruby_provider = 0
	" Disable Node.js support
	let g:loaded_node_provider = 0
endif

" Turn error bell off
set noerrorbells

" Relative linenumbers
set relativenumber


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  Save Stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Clipboard set to global and ctrl c/v maps
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+
vnoremap <leader>x "+c
noremap <leader>y "+y

" SSH friendly clipboard
vnoremap <leader>c :OSCYank<CR>
vmap <C-c> :OSCYank<CR>

" ex <leader>oip  " copy the inner paragraph
nmap <leader>o <Plug>OSCYank

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
	set wildignore+=.git\*,.hg\*,.svn\*
else
	set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Add a bit extra margin to the left
set foldcolumn=1

" Disable comment continuation
set formatoptions-=cro
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Underline when going to insert mode
" autocmd InsertEnter,InsertLeave * set cul!

" Set cursor to thin line in insert mode
if exists('$TMUX')
	let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
	let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
	let &t_SI = "\e[5 q"
	let &t_EI = "\e[2 q"
endif

" Linux: open browser with xdg-open using gx under cursor
let g:netrw_browsex_viewer= "xdg-open"

" Set windows to open below
set splitbelow

" Line number and mouse point
set number
set mouse=a

" Disable highlighting on search
set nohlsearch

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make color schemes work with highlights
function! AdaptColorscheme()
	highlight clear CursorLine
	highlight Normal ctermbg=none
	highlight LineNr ctermbg=none
	highlight Folded ctermbg=none
	highlight NonText ctermbg=none
	highlight SpecialKey ctermbg=none
	highlight VertSplit ctermbg=none
	highlight SignColumn ctermbg=none
endfunction

autocmd ColorScheme * call AdaptColorscheme()

" Gruvbox
autocmd vimenter * ++nested colorscheme gruvbox

set background=dark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Be smart when using tabs
set smarttab

" The way things should be done
set shiftwidth=4
set tabstop=4
set noexpandtab

" 1 tab views as 4 spaces
set noet
set ts=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Make it so that a curly brace automatically inserts an indented line
inoremap {<CR> {<CR>}<Esc>O<BS><Tab>

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on
"	 means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
	if $XDG_DATA_HOME != ""
		set undodir=${XDG_DATA_HOME}/nvim/undo
	else
		set undodir=~/.vim/undo
	endif
	set undofile
catch
endtry

""""""""""""""""""""""""""""""
" => Shell section
""""""""""""""""""""""""""""""
set termguicolors

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
	if &paste
		return 'PASTE MODE	'
	endif
	return ''
endfunction


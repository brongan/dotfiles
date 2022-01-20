"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => XDG path configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stop polluting $HOME
if $XDG_DATA_HOME != ""
    set runtimepath^=${XDG_CONFIG_HOME}/nvim runtimepath+=${XDG_DATA_HOME}/nvim runtimepath+=${XDG_DATA_HOME}/nvim/after

    set packpath^=${XDG_DATA_HOME}/nvim,${XDG_CONFIG_HOME}/nvim
    set packpath+=${XDG_CONFIG_HOME}/nvim/after,${XDG_DATA_HOME}/nvim/after
else
    set runtimepath+=~/.vim runtimepath+=~/.vim/after
endif


call mkdir($XDG_DATA_HOME."/vim/spell", 'p')
set viewdir=$XDG_DATA_HOME/vim/view | call mkdir(&viewdir, 'p')

set backupdir=${XDG_CACHE_HOME}/vim/backup | call mkdir(&backupdir, 'p')
set directory=${XDG_CACHE_HOME}/vim/swap   | call mkdir(&directory, 'p')
set undodir=${XDG_CACHE_HOME}/vim/undo     | call mkdir(&undodir,   'p')

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
" => Plugins,
" :PlugInstall to install plugins, :PlugUpdate to update or install
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
if $XDG_DATA_HOME != ''
    call plug#begin('$XDG_DATA_HOME/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'kovetskiy/sxhkd-vim'
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => COC.nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TextEdit might fail if hidden is not set.
set hidden

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" inoremap <silent><expr> <TAB>
"             \ pumvisible() ? "\<C-n>" :
"             \ <SID>check_back_space() ? "\<TAB>" :
"             \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use <c-space> to trigger completion.
inoremap <silent><expr> <C-space> coc#refresh()
"Some terminals may send <NUL> when you press <c-space>, so you could instead:
" inoremap <silent><expr> <NUL> coc#refresh()

" Close completition window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>S  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Extensions
" coc config

" View yank list from coc-yank
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" Format selected text
vmap <leader>p  <Plug>(coc-format-selected)
nmap <leader>p  <Plug>(coc-format-selected)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Most commands support CTRL-T / CTRL-X / CTRL-V key bindings
" to open in a new tab, a new split, or in a new vertical split

" Current file directory
nnoremap <leader>- :FZF <c-r>=fnameescape(expand('%:p:h'))<cr>/<cr>
" Search in current directory
nnoremap <leader>ff :FZF<cr>
" Search home directory
nnoremap <leader>fF :Files ~/<cr>
" Open buffers
nnoremap <leader>fb :Buffers<cr>
" Lines in loaded buffers
nnoremap <leader>fl :Lines<cr>
" Lines in the current buffer
nnoremap <leader>fB :BLines<cr>
" Tags in the project
nnoremap <leader>ft :Tags<cr>
" v:oldfiles and open buffers
nnoremap <leader>fh :History<cr>
" Help tags
nnoremap <leader>fH :Helptags<cr>
" Vim Command History
nnoremap <leader>f: :History:<cr>
" Search History
nnoremap <leader>f/ :History/<cr>
" Git files (git ls-files)
nnoremap <leader>fg :GFiles<cr>
" Git files (git status)
nnoremap <leader>fs :GFiles?<cr>
" Git commits (requires fugitive.vim)
nnoremap <leader>fc :Commits<cr>
" Vim Commands
nnoremap <leader>fv :Commands<cr>
" Change colorscheme
nnoremap <leader>fC :Colors<cr>
" View marks
nnoremap <leader>fm :Marks<cr>
" Ripgrep search result (ALT-A to select all, ALT-D to deselect all)
nnoremap <leader>fr :Rg<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => nvim-treesitter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
require'nvim-treesitter.configs'.setup {
ensure_installed = "all",     -- one of "all", "language", or a list of languages
highlight = {
enable = true,              -- false will disable the whole extension
},
   incremental_selection = {
   enable = true,
   keymaps = {
       init_selection = "gnn",
       node_incremental = "grn",
       scope_incremental = "grc",
       node_decremental = "grm",
       },
   },
   refactor = {
       highlight_definition = { enable = true },
       navigation = { enable = true },
       },
   textobjects = { enable = true },
   }
EOF

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

" A buffer becomes hidden when it is abandoned
set hid

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

" Enable syntax highlighting
" syntax enable

" Set 256 color palette
"set t_Co=256

" Gruvbox
colorscheme gruvbox
autocmd vimenter * ++nested colorscheme gruvbox

set background=dark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Be smart when using tabs
set smarttab

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :nohl<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Buffer movement and delete
map gb :bn<cr>
map gB :bp<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Neovim Terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists(':tnoremap')
    " Use <C-w> in terminal mode to escape all the way
    tnoremap <C-w> <C-\><C-n><C-w>

    " With this function you can reuse the same terminal in neovim.
    " You can toggle the terminal and also send a command to the same terminal.
    " Taken and modified from: https://gist.github.com/ram535/b1b7af6cd7769ec0481eb2eed549ea23
    let s:monkey_terminal_window = -1
    let s:monkey_terminal_buffer = -1
    let s:monkey_terminal_job_id = -1
    let s:monkey_terminal_current_dir = ""

    function! MonkeyTerminalOpen()
        " Check if buffer exists, if not create a window and a buffer
        if !bufexists(s:monkey_terminal_buffer)
            " Creates a window call monkey_terminal
            new monkey_terminal
            " Moves to the window below the current one
            wincmd J
            let s:monkey_terminal_job_id = termopen($SHELL, { 'detach': 1 })

            " Change the name of the buffer to "Terminal 1"
            silent file Terminal\ 1
            " Gets the id of the terminal window
            let s:monkey_terminal_window = win_getid()
            let s:monkey_terminal_buffer = bufnr('%')
            let s:monkey_terminal_current_dir = getcwd()

            " The buffer of the terminal won't appear in the list of the buffers
            " when calling :buffers command
            set nobuflisted
        else
            if !win_gotoid(s:monkey_terminal_window)
                sp
                " Moves to the window below the current one
                wincmd J
                buffer Terminal\ 1
                " Gets the id of the terminal window
                let s:monkey_terminal_window = win_getid()
            endif
        endif
    endfunction

    function! MonkeyTerminalToggle()
        if win_gotoid(s:monkey_terminal_window)
            call MonkeyTerminalClose()
        else
            " Resize terminal window
            let s:main_window_height = winheight(0) * 1/2
            call MonkeyTerminalOpen()
            exe 'resize' s:main_window_height
        endif
    endfunction

    function! MonkeyTerminalClose()
        if win_gotoid(s:monkey_terminal_window)
            " close the current window
            hide
        endif
    endfunction

    " Toggle the terminal with alt + enter
    nnoremap <silent> <M-cr> :call MonkeyTerminalToggle()<cr>a
    inoremap <silent> <M-cr> <Esc>:call MonkeyTerminalToggle()<cr>a
    tnoremap <silent> <M-cr> <C-\><C-n>:call MonkeyTerminalToggle()<cr>
endif

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline status bar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatically displays all buffers when there's only one tab open.
let g:airline#extensions#tabline#enabled = 1

" Enable Powerline fonts
let g:airline_powerline_fonts = 1

" The separator used on the left side
"let g:airline_left_sep = '>'

" The separator used on the right side
"let g:airline_right_sep = '<'

" Enable modified detection
let g:airline_detect_modified = 1

" Enable paste detection
let g:airline_detect_paste = 1

" Enable crypt detection
let g:airline_detect_crypt = 1

" Enable spell detection
let g:airline_detect_spell = 1

" Display spelling language when spell detection is enabled (if enough space is available)
let g:airline_detect_spelllang = 1

" Enable iminsert detection
let g:airline_detect_iminsert = 0

" Determine whether inactive windows should have the left section collapsed to only the filename of that buffer.
" let g:airline_inactive_collapse = 1

" Use alternative seperators for the statusline of inactive windows
" let g:airline_inactive_alt_sep = 1

" Enable/disable COC.nvim error/warning display
" let g:airline#extensions#coc#enabled = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on
"    means that you can undo even when you close a buffer/VIM
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
if exists('$TMUX')
    if has('nvim')
        set termguicolors
    else
        set term=screen-256color
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Navigation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-k> :cnext<CR>zz
nnoremap <C-j> :cprev<CR>zz
nnoremap <leader>k :lnext<CR>zz
nnoremap <leader>j :lprev<CR>zz


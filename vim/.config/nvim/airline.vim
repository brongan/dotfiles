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


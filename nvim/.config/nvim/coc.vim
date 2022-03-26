
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


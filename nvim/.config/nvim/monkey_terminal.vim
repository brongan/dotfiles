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


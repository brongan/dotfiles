function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

source ${XDG_CONFIG_HOME}/nvim/airline.vim
source ${XDG_CONFIG_HOME}/nvim/basics.vim
source ${XDG_CONFIG_HOME}/nvim/coc.vim
let work_path = $XDG_CONFIG_HOME . '/nvim/google.vim'
call SourceIfExists(work_path)
source ${XDG_CONFIG_HOME}/nvim/monkey_terminal.vim
source ${XDG_CONFIG_HOME}/nvim/navigation.vim
source ${XDG_CONFIG_HOME}/nvim/plugins.vim
source ${XDG_CONFIG_HOME}/nvim/tex.vim
source ${XDG_CONFIG_HOME}/nvim/treesitter.vim

lua << EOF
EOF


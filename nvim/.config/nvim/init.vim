function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

source ${XDG_CONFIG_HOME}/nvim/basics.vim
let work_path = $XDG_CONFIG_HOME . '/nvim/google.vim'
call SourceIfExists(work_path)
source ${XDG_CONFIG_HOME}/nvim/monkey_terminal.vim
source ${XDG_CONFIG_HOME}/nvim/navigation.vim
source ${XDG_CONFIG_HOME}/nvim/plugins.vim
source ${XDG_CONFIG_HOME}/nvim/tex.vim

lua << END
require('lualine').setup()
require('rust-tools').setup({})
package.path = os.getenv('XDG_CONFIG_HOME')..'/nvim/'..package.path
require('.lsp')
require('.treesitter')
require('.indent_blankline')
require('.nvim-cmp')
END


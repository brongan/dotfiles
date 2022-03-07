source ${XDG_CONFIG_HOME}/nvim/airline.vim
source ${XDG_CONFIG_HOME}/nvim/basics.vim
source ${XDG_CONFIG_HOME}/nvim/coc.vim
if !empty(glob("${XDG_CONFIG_HOME}/nvim/google.vim"))
	source ${XDG_CONFIG_HOME}/nvim/google.vim
endif
source ${XDG_CONFIG_HOME}/nvim/monkey_terminal.vim
source ${XDG_CONFIG_HOME}/nvim/navigation.vim
source ${XDG_CONFIG_HOME}/nvim/plugins.vim
source ${XDG_CONFIG_HOME}/nvim/tex.vim
source ${XDG_CONFIG_HOME}/nvim/treesitter.vim

lua << EOF
EOF


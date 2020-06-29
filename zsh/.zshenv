# Enviroment variables
export EDITOR="/usr/bin/vim"
export SYSTEMD_EDITOR=$EDITOR
export ZSH="$HOME/.oh-my-zsh"
export LC_ALL=en_US.UTF-8
export TERMINAL=kitty
export LESS="-R" # show colors
export LESSOPEN="| bat %s"
export PAGER=less
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export GPG_TTY=$(tty)
export BLANT_DIR="$HOME/dev/BLANT"
export MALMO_XSD_PATH="$HOME/MalmoPlatform/Schemas"

# Ruby gems
PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
export GEM_HOME=$HOME/.gem
PATH="$PATH:${GEM_HOME}/bin"

# Node.js
PATH="$HOME/.node_modules/bin:$PATH"
export npm_config_prefix=~/.node_modules

# PIP
export PATH=$HOME/.local/bin:$PATH

# Go
export PATH="$PATH:$HOME/go/bin"


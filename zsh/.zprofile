# Enviroment variables
export ZSH="$HOME/.oh-my-zsh"
export LC_ALL=en_US.UTF-8
export TERMINAL=konsole
export PAGER=less
export TERM="xterm-256color"
export GPG_TTY=$(tty)
export BLANT_DIR="$HOME/dev/BLANT"
export MALMO_XSD_PATH="$HOME/MalmoPlatform/Schemas"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nano'
else
    export EDITOR='nano'
fi

# Ruby gems
PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
export GEM_HOME=$HOME/.gem
PATH="$PATH:${GEM_HOME}/bin"

# Node.js
PATH="$HOME/.node_modules/bin:$PATH"
export npm_config_prefix=~/.node_modules

# PIP
export PATH=$HOME/.local/bin:$PATH

# startx when logged in
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

# Go
export PATH="$PATH:$HOME/go/bin"

#  _____    _
# |__  /___| |__  _ __ ___
#   / // __| '_ \| '__/ __|
#  / /_\__ \ | | | | | (__
# /____|___/_| |_|_|  \___|

# Exports
export VISUAL="/usr/bin/vim"
export EDITOR="$VISUAL"
export SYSTEMD_EDITOR=$EDITOR
export ZSH="$HOME/.oh-my-zsh"
export LC_ALL=en_US.UTF-8
export TERMINAL=kitty
export LESS="-R" # show colors
export LESSOPEN="| bat %s"
export PAGER=less
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export TERM="xterm-256color"
export GPG_TTY=$(tty)
export MALMO_XSD_PATH="$HOME/MalmoPlatform/Schemas"

# FZF stuff
FD_OPTIONS="--follow --exclude .git --exclude node_modules"
export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview'[[ \$(file --mine {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {}) 2> /dev/null"
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="fd --type d $FD_OPTIONS"
export FZF_ALT_C_COMMAND="fd --type f --hidden $FD_OPTIONS"

# Show OS info when opening a new terminal
neofetch

# Command execution time stamp shown in the history command output.
HIST_STAMPS="mm/dd/yyyy"

# Plugins to load
plugins=(
	aws
	docker
	fd
	gitfast
	golang
	npm
	pyenv
	pylint
	sudo
	vi-mode
    virtualenv
)

source $ZSH/oh-my-zsh.sh
source ~/.powerlevel9k_config
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

autoload -Uz compinit && compinit

bindkey -v # vi mode

# Aliases for a few useful commands
alias icat="kitty +kitten icat"
alias ls="colorls"
alias ip="ip -c"
alias rm="rm -i"

alias dingbat="tmux new -d -s lol 'DXVK_STATE_CACHE=1 WINEPREFIX=~/Games/Games-Wine/LoL WINEARCH=win32 /opt/wine-lol/bin/wine ~/Games/Games-Wine/LoL/drive_c/Riot\ Games/League\ of\ Legends/LeagueClient.exe'"
alias kill-orphans="sudo pacman -Rns $(pacman -Qtdq)"
alias attach_headphones="sudo virsh attach-device win10 --file $HOME/dev/kvm_scripts/headset.xml> --config"
alias detach_headphones="sudo virsh detach-device win10 --file $HOME/dev/kvm_scripts/headset.xml> --config"


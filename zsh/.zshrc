#  _____    _
# |__  /___| |__  _ __ ___
#   / // __| '_ \| '__/ __|
#  / /_\__ \ | | | | | (__
# /____|___/_| |_|_|  \___|

# FZF stuff
FD_OPTIONS="--follow --exclude .git --exclude node_modules"
export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview '([[ -d {} ]] && tree -aC {}) || ([[ -f {} ]] && bat --color=always --style=header,grid --line-range :300 {})'"
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="fd --type d $FD_OPTIONS"
export FZF_ALT_C_COMMAND="fd --type f --hidden $FD_OPTIONS"

# NNN
export NNN_PLUG='o:fzopen;v:preview-kitty'
export NNN_FIFO=/tmp/nnn.fifo

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
	pass
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
source /usr/share/vim/vimfiles/gruvbox_256palette.sh
(cat ~/.cache/wal/sequences &)

autoload -Uz compinit && compinit

bindkey -v # vi mode

# Aliases for a few useful commands
alias icat="kitty +kitten icat"
alias ls="exa"
alias ip="ip -c"
alias rm="rm -i"
alias cat="bat"
alias vim="nvim"

alias dingbat="tmux new -d -s lol 'DXVK_STATE_CACHE=1 WINEPREFIX=~/Games/Games-Wine/LoL WINEARCH=win32 /opt/wine-lol/bin/wine ~/Games/Games-Wine/LoL/drive_c/Riot\ Games/League\ of\ Legends/LeagueClient.exe'"
alias kill-orphans="sudo pacman -Rns $(pacman -Qtdq)"
alias attach_headphones="sudo virsh attach-device win10 --file $HOME/dev/kvm_scripts/headset.xml> --config"
alias detach_headphones="sudo virsh detach-device win10 --file $HOME/dev/kvm_scripts/headset.xml> --config"


#  _____    _
# |__  /___| |__  _ __ ___
#   / // __| '_ \| '__/ __|
#  / /_\__ \ | | | | | (__
# /____|___/_| |_|_|  \___|

autoload -Uz compinit

# Coloured man pages using less as pager
function man() {
    env \
	      LESS_TERMCAP_mb=$(printf "\e[1;31m") \
	      LESS_TERMCAP_md=$(printf "\e[1;31m") \
	      LESS_TERMCAP_me=$(printf "\e[0m") \
	      LESS_TERMCAP_se=$(printf "\e[0m") \
	      LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
	      LESS_TERMCAP_ue=$(printf "\e[0m") \
	      LESS_TERMCAP_us=$(printf "\e[1;36m") \
	      man "$@"
}

# Exports related to aliases
export VISUAL=vim
export EDITOR="$VISUAL"

# Show OS info when opening a new terminal
neofetch

# Command auto-correction.
ENABLE_CORRECTION="true"

# Command execution time stamp shown in the history command output.
HIST_STAMPS="mm/dd/yyyy"

source $ZSH/oh-my-zsh.sh

# Check If Windows
if [ ! "$WINDOWS" = "true" ]; then
    source ~/.powerlevel9k_config
else
    ZSH_THEME="robbyrussell"
    unalias ls
fi

# Plugins to load
plugins=(git
        virtualenv
	zsh-syntax-highlighting
	aws
	docker
	gitfast
	mvn
	pyenv
	pylint
	python
	screen
	vscode
	npm
	history-substring-search)

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# Aliases for a few useful commands
alias cat="bat"
alias ls="colorls"
alias ip="ip -c"
alias rm="rm -i"
alias x="ranger"
alias c="cmus"
alias h="htop"
alias nano="vim"
alias untar="tar -xvzf"
alias sshhosts="sed -rn 's/^\s*Host\s+(.*)\s*/\1/ip' ~/.ssh/config"

alias dingbat="tmux new -d -s lol 'DXVK_STATE_CACHE=1 WINEPREFIX=~/Games/Games-Wine/LoL WINEARCH=win32 /opt/wine-lol/bin/wine ~/Games/Games-Wine/LoL/drive_c/Riot\ Games/League\ of\ Legends/LeagueClient.exe'"
alias kill-orphans="sudo pacman -Rns $(pacman -Qtdq)"
alias attach_headphones="sudo virsh attach-device win10 --file $HOME/dev/kvm_scripts/headset.xml> --config"
alias detach_headphones="sudo virsh detach-device win10 --file $HOME/dev/kvm_scripts/headset.xml> --config"
export RUBYOPT=-W:no-deprecated colorls

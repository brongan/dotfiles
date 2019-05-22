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
	npm)

# added by Anaconda3 5.3.1 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '$HOME/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="$HOME/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

export pimac="B8:27:EB:13:AB:3C"
export desktopmac="1C:1B:0D:76:EF:0D"

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



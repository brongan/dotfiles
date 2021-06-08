#  _____    _
# |__  /___| |__  _ __ ___
#   / // __| '_ \| '__/ __|
#  / /_\__ \ | | | | | (__
# /____|___/_| |_|_|  \___|

# FZF stuff
FD_OPTIONS="--follow --exclude .git --exclude node_modules"
export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info"
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="fd --type d $FD_OPTIONS"
export FZF_CTRL_T_OPTS="--preview '([[ -d {} ]] && tree -aC {}) || ([[ -f {} ]] && bat --color=always --style=header,grid --line-range :300 {})'"
export FZF_ALT_C_COMMAND="fd --type f --hidden $FD_OPTIONS"

# NNN
if (( $+commands[kitty] )); then
	export NNN_PLUG='o:fzopen;v:preview-kitty'
fi
export NNN_FIFO=/tmp/nnn.fifo

# Editors and pagers
if (( $+commands[nvim] )); then
  export EDITOR="nvim"
else
  export EDITOR="vim"
fi

export SUDO_EDITOR=$EDITOR
export SYSTEMD_EDITOR=$EDITOR

if (( $+commands[bat] )); then
  export LESS="-R" # show colors
  export LESSOPEN="| bat %s"
  export PAGER=less
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

wm=$(wmctrl -m 2&> /dev/null | head -n 1 | cut -d' ' -f 2)
if [[ $wm == "bspwm" || $wm == "i3" ]]; then
  export _JAVA_AWT_WM_NONREPARENTING=1
fi

# Command execution time stamp shown in the history command output.
HIST_STAMPS="yyyy/mm/dd"

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

ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
source ~/.powerlevel9k_config
if [ -d /usr/local/Cellar/ ]; then
	source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
	source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f ~/.vim/plugged/gruvbox/gruvbox_256palette_osx.sh ] && source ~/.vim/plugged/gruvbox/gruvbox_256palette_osx.sh
[ -f /usr/share/vim/vimfiles/gruvbox_256palette.sh ] && source /usr/share/vim/vimfiles/gruvbox_256palette.sh
[ -f ~/.cache/wal/sequences ] && (cat ~/.cache/wal/sequences &)

bindkey -v # vi mode

if (( $+commands[kitty] )) && [[ $TERM -eq xterm-kitty ]]; then
	kitty + complete setup zsh | source /dev/stdin
fi

if (( $+commands[kitty] )); then
	alias icat="kitty +kitten icat"
	alias issh="kitty +kitten ssh"
fi

# Aliases for a few useful commands
alias ls="exa"
alias la="exa -a"
alias ll="exa -aglh"
alias ip="ip -c"
alias rm="rm -i"
alias cat="bat"
alias vim="nvim"

# Work
if (( $+commands[eda] )); then
	export EDA_AUTO="$HOME/.config/eda/completion"
	mkdir -p $EDA_AUTO
	eda completions zsh > $EDA_AUTO/_eda
	fpath=($EDA_AUTO $fpath)
fi
[ -f '/usr/local/bin/aws_completer' ] && complete -C '/usr/local/bin/aws_completer' aws

if [ -c "/Users/${USER}/Library/Android/sdk" ]; then
	export ANDROID_HOME="/Users/${USER}/Library/Android/sdk"
	path=($path "$ANDROID_HOME/platforms-tools" "$ANDROID_HOME/tools/" "$ANDROID_HOME/build-tools/21.1.2" "/Users/${USER}/workplace/ATVAndroidDevTools/gradle")
	export ANDROID_HVPROTO=ddm
fi

# Finalize
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

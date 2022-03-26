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

# time
export TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'

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

wm=$(wmctrl -m 2&> /dev/null | head -n 1 | cut -d' ' -f 2)
if [[ $wm == "bspwm" || $wm == "i3" ]]; then
	export _JAVA_AWT_WM_NONREPARENTING=1
fi

[ -f ${XDG_CACHE_HOME}/wal/sequences ] && (cat ~/.cache/wal/sequences &)

source "$XDG_CONFIG_HOME/.powerlevel9k_config"

# XDG Aliases
alias bazel="/usr/bin/env -u _JAVA_OPTIONS bazel --bazelrc=${XDG_CONFIG_HOME}/bazel/bazelrc --host_jvm_args=$_JAVA_OPTIONS"
alias gpg="/usr/bin/gpg2 --homedir $XDG_DATA_HOME/gnupg"
alias gpg=gpg2
alias irssi="/usr/bin/irssi --config=${XDG_CONFIG_HOME}/irssi/config --home=${XDG_DATA_HOME}/irssi"
alias nvidia-settings="/usr/bin/nvidia-settings --config=${XDG_CONFIG_HOME}/nvidia/settings"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
alias yarn="yarn --use-yarnrc ${XDG_CONFIG_HOME}/yarn/config"

# Aliases for a few useful commands
alias ls="exa"
alias la="exa -a"
alias ll="exa -aglh"
alias ip="ip -c"
alias rm="rm -i"
alias grep="rg"
if (( $+commands[bat] )); then
	alias cat="bat"
elif (( $+commands[batcat] )); then
	alias cat="batcat"
	alias bat="batcat"
fi
alias vim="nvim"
alias pass="gopass"
if (($+commands[btop])); then
	alias top="btop"
fi
alias bdf="sudo btrfs filesystem usage"
alias bdu="sudo btrfs filesystem du"
function xdg-query() {
	xdg-mime query default $(xdg-mime query filetype ${1})
}

export LESS="-R" # show colors
export LESSOPEN="| bat %s"
export PAGER=less
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Rust why
if (( $+commands[sccache] )); then
	export RUSTC_WRAPPER=sccache
fi

if (( ! $+commands[sudoedit] )); then
	alias sudoedit="sudo -e"
fi

if (( $+commands[kitty] )); then
	alias icat="kitty +kitten icat"
	alias ssh="kitty +kitten ssh"
fi

# Completion
if [[ $OSTYPE =~ "linux" ]]; then
	if [[ -d /usr/share/fzf ]]; then
		source /usr/share/fzf/key-bindings.zsh
		source /usr/share/fzf/completion.zsh
	else
		source /usr/share/doc/fzf/examples/key-bindings.zsh
		source /usr/share/doc/fzf/examples/completion.zsh
	fi
	if [[ -f /usr/share/vim/vimfiles/gruvbox_256palette.sh ]]; then
		source /usr/share/vim/vimfiles/gruvbox_256palette.sh
	else
		source ${XDG_DATA_HOME}/nvim/plugged/gruvbox/gruvbox_256palette.sh
	fi
	if [[ -d /usr/share/zsh/plugins ]]; then
		source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
		source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
	else
		source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
		source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
	fi

	bindkey '^A' beginning-of-line
	bindkey '^E' end-of-line
elif [[ $OSTYPE =~ "darwin" ]]; then
	source /usr/local/Cellar/fzf/0.27.2/shell/key-bindings.zsh
	source /usr/local/Cellar/fzf/0.27.2/shell/completion.zsh
	source ${XDG_DATA_HOME}/nvim/plugged/gruvbox/gruvbox_256palette_osx.sh 
	source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

autoload -Uz compinit && compinit -d $ZCOMPDUMP

if (( $+commands[kitty] )) && [[ $TERM == "xterm-kitty" ]]; then
	kitty + complete setup zsh | source /dev/stdin
fi

# Atuin
atuin-fzf () {
local selected num
setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
selected=( $(atuin history list -h | fzf --tac) )
local ret=$?
if [ -n "$selected" ]; then
	RBUFFER="${selected[@]:2:-1}${RBUFFER}"
fi
zle end-of-line
zle reset-prompt
return $ret
}
if (( $+commands[atuin] )); then
	export ATUIN_NOBIND=1
	eval "$(atuin init zsh)"
	zle -N atuin-fzf
	bindkey '^R' atuin-fzf
fi

if [[ "${USER}" == "brennantracy" ]]; then
  source "${ZDOTDIR}/google.zsh"
fi


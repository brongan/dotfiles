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

if [[ ! -n ${SSH_CONNECTION} ]]; then
    export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
fi

wm=$(wmctrl -m 2&> /dev/null | head -n 1 | cut -d' ' -f 2)
if [[ $wm == "bspwm" || $wm == "i3" || $wm == "wlroots" ]]; then
	export _JAVA_AWT_WM_NONREPARENTING=1
fi

eval "$(starship init zsh)"

# XDG Aliases
alias bazel="/usr/bin/env -u _JAVA_OPTIONS CC=clang bear -- /usr/bin/env bazel --bazelrc=${XDG_CONFIG_HOME}/bazel/bazelrc --host_jvm_args=$_JAVA_OPTIONS"
alias blaze=bazel # Why
alias gpg="/usr/bin/gpg2 --homedir ${XDG_DATA_HOME}/gnupg"
alias irssi="/usr/bin/irssi --config=${XDG_CONFIG_HOME}/irssi/config --home=${XDG_DATA_HOME}/irssi"
alias nvidia-settings="/usr/bin/nvidia-settings --config=${XDG_CONFIG_HOME}/nvidia/settings"
alias svn="svn --config-dir ${XDG_CONFIG_HOME}/subversion"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
alias yarn="yarn --use-yarnrc ${XDG_CONFIG_HOME}/yarn/config"

# Aliases for a few useful commands
alias ls="exa"
alias la="exa -a"
alias ll="exa -aglh"
alias ip="ip -c"
alias rm="rm -i"
alias grep="rg"
alias diff="delta"
if (( $+commands[bat] )); then
	alias cat="bat"
elif (( $+commands[batcat] )); then
	alias cat="batcat"
	alias bat="batcat"
fi
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
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
alias watch=viddy

export LESS="-R" # show colors
export LESSOPEN="| bat %s"
export PAGER=delta
# export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
export MANPAGER="nvim +Man!"
export MANROFFOPT="-c"
if (( $+commands[chromium] )); then
	export CHROME_EXECUTABLE=$(which chromium)
fi

# Rust why
if (( $+commands[sccache] )); then
	export RUSTC_WRAPPER=sccache
fi

if (( ! $+commands[sudoedit] )); then
	alias sudoedit="sudo -e"
fi

if (( $+commands[kitty] )); then
	alias icat="kitty +kitten icat"
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
	elif [[ -f ${XDG_DATA_HOME}/nvim/plugged/gruvbox/gruvbox_256palette.sh ]]; then
		source ${XDG_DATA_HOME}/nvim/plugged/gruvbox/gruvbox_256palette.sh
	fi
	if [[ -d /usr/share/zsh/plugins ]]; then
		source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
		source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
	else
		source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
		source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
	fi

	if [[ -f /etc/profile.d/google-cloud-sdk.sh ]]; then
		source /etc/profile.d/google-cloud-sdk.sh ]]
	fi

	bindkey -v
	bindkey '^A' beginning-of-line
	bindkey '^E' end-of-line
fi

autoload -Uz compinit && compinit -d $ZCOMPDUMP

# Atuin
atuin-fzf () {
	local selected num
	setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
	selected=( $(atuin history list --human | fzf --tac) )
	local ret=$?
	if [ -n "$selected" ]; then
		RBUFFER="${selected[3,-2]}${RBUFFER}"
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

if (( $+commands[direnv] )); then
	eval "$(direnv hook zsh)"
fi

if (( $+commands[nix] )); then
	fpath=(/usr/share/zsh/site-functions/ $fpath)
fi

if (( $+commands[flutter] )); then
	export FLUTTER_ROOT="/usr/lib/flutter"
fi


if (( $+commands[jj] )); then
	source <(jj util completion zsh)
fi

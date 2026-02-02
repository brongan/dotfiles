# ------------------------------------------------------------------------------
# 1. Interactive Options & Bindings
# ------------------------------------------------------------------------------
# FZF Config (Static variables only)
export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info"
export FD_OPTIONS="--follow --exclude .git --exclude node_modules"
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="fd --type d $FD_OPTIONS"
export FZF_CTRL_T_OPTS="--preview '([[ -d {} ]] && tree -aC {}) || ([[ -f {} ]] && bat --color=always --style=header,grid --line-range :300 {})'"
export FZF_ALT_C_COMMAND="fd --type f --hidden $FD_OPTIONS"

# ZSH
export TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'
HISTSIZE=10000
SAVEHIST=10000

# Editor Config
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export SYSTEMD_EDITOR="nvim"
export VISUAL="nvim"

# Pager Config
export LESS="-R"
export LESSOPEN="| bat %s"
export GIT_PAGER="delta"
export MANPAGER="nvim +Man!"
export MANROFFOPT="-c"

# Keybindings (VI Mode)
bindkey -v
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# ------------------------------------------------------------------------------
# 2. Integration & Compatibility
# ------------------------------------------------------------------------------
# Fix Java tiling (Moved from wmctrl logic to environment check)
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    export _JAVA_AWT_WM_NONREPARENTING=1
fi

# Rust sccache
if (( $+commands[sccache] )); then
    export RUSTC_WRAPPER=sccache
fi

# Flutter / Chrome
if (( $+commands[flutter] )); then
    export FLUTTER_ROOT="/usr/lib/flutter"
    # Prioritize Chrome Stable if it exists, else Chromium
    if (( $+commands[google-chrome-stable] )); then
        export CHROME_EXECUTABLE="google-chrome-stable"
    elif (( $+commands[chromium] )); then
        export CHROME_EXECUTABLE="chromium"
    fi
fi

# ------------------------------------------------------------------------------
# 3. Aliases
# ------------------------------------------------------------------------------
# XDG Cleanups
alias bazel="/usr/bin/env -u _JAVA_OPTIONS CC=clang bear -- /usr/bin/env bazel --bazelrc=${XDG_CONFIG_HOME}/bazel/bazelrc --host_jvm_args=$_JAVA_OPTIONS"
alias blaze=bazel
alias gpg="gpg --homedir ${XDG_DATA_HOME}/gnupg"
alias irssi="irssi --config=${XDG_CONFIG_HOME}/irssi/config --home=${XDG_DATA_HOME}/irssi"
alias nvidia-settings="nvidia-settings --config=${XDG_CONFIG_HOME}/nvidia/settings"
alias svn="svn --config-dir ${XDG_CONFIG_HOME}/subversion"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
alias yarn="yarn --use-yarnrc ${XDG_CONFIG_HOME}/yarn/config"

# General
alias ip="ip -c"
alias rm="rm -i"
alias grep="grep --color=auto"
alias diff="delta"
alias pass="gopass"
alias watch=viddy
alias sudoedit="sudo -e"

# Modern Replacements
(( $+commands[btop] )) && alias top="btop"
if (( $+commands[eza] )); then
    alias ls="eza --icons"
    alias la="eza --icons -a"
    alias ll="eza --icons -aaglh"
fi

if (( $+commands[bat] )); then
    alias cat="bat"
elif (( $+commands[batcat] )); then
    alias cat="batcat"
    alias bat="batcat"
fi

# Global Help aliases (Pipe to bat)
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
alias vim="nvim"
alias pass="passage"
 if (($+commands[btop])); then
 	alias top="btop"
fi

# Kitty specific
if (( $+commands[kitty] )); then
    alias s="kitten ssh"
    alias icat="kitty +kitten icat"
fi

# Btrfs
alias bdf="sudo btrfs filesystem usage"
alias bdu="sudo btrfs filesystem du"

# ------------------------------------------------------------------------------
# 4. Functions
# ------------------------------------------------------------------------------
function xdg-query() {
    xdg-mime query default $(xdg-mime query filetype ${1})
}

# Custom Atuin FZF behavior
atuin-fzf () {
    local selected
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

# ------------------------------------------------------------------------------
# 5. Completions
# ------------------------------------------------------------------------------
# Load distro-specific plugins
if [[ -d /usr/share/zsh/plugins ]]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ -d /usr/share/zsh-syntax-highlighting ]]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Load FZF bindings
if [[ -d /usr/share/fzf ]]; then
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
fi

# Fast Compinit (Checks cache once a day)
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit -d "${ZDOTDIR}/.zcompdump"
else
  compinit -i -d "${ZDOTDIR}/.zcompdump"
  # Touch the file to update modification time
  touch "${ZDOTDIR}/.zcompdump"
fi

# Load Tool Completions from Files (Do not generate on fly)
# Run `zellij setup --generate-completion zsh > $ZDOTDIR/completions/_zellij` manually once
# Run `jj util completion zsh > $ZDOTDIR/completions/_jj` manually once
fpath=(${ZDOTDIR}/completions $fpath)

# Nix
if (( $+commands[nix] )); then
    fpath=(/usr/share/zsh/site-functions/ $fpath)
fi

# ------------------------------------------------------------------------------
# 6. Tool Initialization
# ------------------------------------------------------------------------------

# Atuin
if (( $+commands[atuin] )); then
    export ATUIN_NOBIND=1
    eval "$(atuin init zsh)"
    zle -N atuin-fzf
    bindkey '^R' atuin-fzf
fi

# Google
if [[ $(whoami) == "brennantracy" && -f "${ZDOTDIR}/google.zsh" ]]; then
  source "${ZDOTDIR}/google.zsh"
fi

# Direnv
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"

# Zoxide (Replaces cd)
if (( $+commands[zoxide] )); then
	alias cd=z
	eval "$(zoxide init zsh)"
fi

(( $+commands[starship] )) && eval "$(starship init zsh)"

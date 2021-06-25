export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export HISTFILE="$XDG_STATE_HOME"/zsh/history

# TODO: Figure out why this is required?
if (( $+commands[kitty] )); then
	export TERMINAL=kitty
fi

# PATH
typeset -U path

# XDG PLZ
if (( $+commands[systemd-path] )); then
  path=($path "$(systemd-path user-binaries)")
else
  path=($path "$HOME/.local/bin")
fi

export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}rustup"
export GOPATH="${XDG_DATA_HOME}/go"
alias yarn='yarn --use-yarnrc "${XDG_CONFIG_HOME}/yarn/config"'
export LESSHISTFILE="${XDG_STATE_HOME}/less/history"
export LESSKEY="${XDG_CONFIG_HOME}/less/keys"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/password-store"
export XAUTHORITY="${XDG_RUNTIME_DIR}/Xauthority"
export WINEPREFIX="${XDG_DATA_HOME}"/wineprefixes/default
export VSCODE_PORTABLE="${XDG_DATA_HOME}"/vscode
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}"/nv
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export GRADLE_USER_HOME="${XDG_DATA_HOME}"/gradle
export GTK2_RC_FILES="${XDG_CONFIG_HOME}"/gtk-2.0/gtkrc
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"
export AWS_CLI_HISTORY_FILE="${XDG_DATA_HOME}/aws/history"
export AWS_CREDENTIALS_FILE="${XDG_DATA_HOME}/aws/credentials"
export AWS_WEB_IDENTITY_TOKEN_FILE="${XDG_DATA_HOME}/aws/token"
export AWS_SHARED_CREDENTIALS_FILE="${XDG_DATA_HOME}/aws/shared-credentials"
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/startup.py"

# Go and Rust have to be special
path=($path "${CARGO_HOME}/bin" "${GOPATH}/bin")

# Node.js
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  \. "$NVM_DIR/nvm.sh" # This loads nvm
else
  path=($path "$HOME/.node_modules/bin")
  export npm_config_prefix="${XDG_DATA_HOME}/npm"
fi

# Work
if [[ -d "$HOME/.toolbox" ]]; then
  path=($path "$HOME/.toolbox/bin" "/usr/local/opt/ruby/bin")
fi


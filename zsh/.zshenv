export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export ZCOMPDUMP="${XDG_CACHE_HOME}/zsh/zcompdump-$ZSH_VERSION"
export HISTFILE="${XDG_STATE_HOME}/zsh/history"
export HISTSIZE=5000
export SAVEHIST=10000
setopt appendhistory
export LESSHISTFILE=-

if [[ $OSTYPE =~ "linux" ]]; then
  if (( $+commands[kitty] )); then
    export TERMINAL="kitty"
  elif (( $+commands[alacritty] )); then
    export TERMINAL="alacritty"
  else
    export TERMINAL="xterm"
  fi
elif [[ $OSTYPE =~ "darwin" ]]; then
  export TERMINAL="iterm"
fi

export PRIMARY_MONITOR=$(xrandr --query -display :0.0| grep " connected " | awk '{ print$1 }' | head -n 1)

# PATH
typeset -U path
if (( $+commands[systemd-path] )); then
  path=($path "$(systemd-path user-binaries)")
else
  path=($path "$HOME/.local/bin")
fi

# XDG PLZ
export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}rustup"
export GOPATH="${XDG_DATA_HOME}/go"
export LESSHISTFILE="${XDG_STATE_HOME}/less/history"
export LESSKEY="${XDG_CONFIG_HOME}/less/keys"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/password-store"
export XAUTHORITY="${XDG_RUNTIME_DIR}/Xauthority"
export WINEPREFIX="${XDG_DATA_HOME}"/wineprefixes/default
export VSCODE_PORTABLE="${XDG_DATA_HOME}"/vscode
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}"/nv
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java"
export GRADLE_USER_HOME="${XDG_DATA_HOME}"/gradle
export GTK2_RC_FILES="${XDG_CONFIG_HOME}"/gtk-2.0/gtkrc
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"
export AWS_CLI_HISTORY_FILE="${XDG_DATA_HOME}/aws/history"
export AWS_CREDENTIALS_FILE="${XDG_DATA_HOME}/aws/credentials"
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/startup.py"
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
export XSERVERRC="${XDG_CONFIG_HOME}/X11/xserverrc"
export LEIN_HOME="${XDG_DATA_HOME}/lein"

# Go and Rust have to be special
path=($path "${CARGO_HOME}/bin" "${GOPATH}/bin")

# Node.js
if [ -s "${XDG_CONFIG_HOME}/nvm/nvm.sh" ]; then
  export NVM_DIR="${XDG_CONFIG_HOME}/nvm"
  \. "$NVM_DIR/nvm.sh" # This loads nvm
else
  path=($path "$HOME/.node_modules/bin")
  export npm_config_prefix="${XDG_DATA_HOME}/npm"
fi
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"


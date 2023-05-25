# XDG directories
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

# ZSH configuration
export HISTFILE="${XDG_STATE_HOME}/zsh/history"
export HISTSIZE=5000
export LESSHISTFILE=-
export SAVEHIST=10000
export ZCOMPDUMP="${XDG_CACHE_HOME}/zsh/zcompdump-$ZSH_VERSION"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
setopt appendhistory

# Terminal
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

# Xorg multidisplay
if [[ -v DISPLAY ]]; then
  export PRIMARY_MONITOR=$(xrandr --query -display $DISPLAY | grep " connected " | awk '{ print$1 }' | head -n 1)
fi

if [[ ${XDG_SESSION_TYPE} = wayland ]]; then
	export QT_QPA_PLATFORM=wayland
	export SDL_VIDEODRIVER=wayland
	export MOZ_ENABLE_WAYLAND=1
	export MOZ_WEBRENDER=1
	export MOZ_DBUS_REMOTE=1
	export QT_WAYLAND_FORCE_DPI=physical
	export LIBVA_DRIVER_NAME=nvidia
	export MOZ_DISABLE_RDD_SANDBOX=1
	export EGL_PLATFORM=wayland
fi

# Node.js
if [ -s "${XDG_CONFIG_HOME}/nvm/nvm.sh" ]; then
  export NVM_DIR="${XDG_CONFIG_HOME}/nvm"
  \. "$NVM_DIR/nvm.sh" # This loads nvm
else
  path=($path "$HOME/.node_modules/bin")
  export npm_config_prefix="${HOME}/.local"
fi
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"

# XDG PLZ
export AWS_CLI_HISTORY_FILE="${XDG_DATA_HOME}/aws/history"
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"
export AWS_CREDENTIALS_FILE="${XDG_DATA_HOME}/aws/credentials"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}"/nv
export DISTCC_DIR="/tmp/distcc"
export GEM_HOME="${XDG_DATA_HOME}/gem/ruby"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
export GOPATH="${XDG_DATA_HOME}/go"
export GRADLE_USER_HOME="${XDG_DATA_HOME}"/gradle
export GTK2_RC_FILES="${XDG_CONFIG_HOME}"/gtk-2.0/gtkrc
export LEIN_HOME="${XDG_DATA_HOME}/lein"
export LESSHISTFILE="${XDG_STATE_HOME}/less/history"
export LESSKEY="${XDG_CONFIG_HOME}/less/keys"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/password-store"
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/startup.py"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export TERMINFO="${XDG_DATA_HOME}/terminfo"
export TERMINFO_DIRS="${XDG_DATA_HOME}/terminfo:/usr/share/terminfo"
export VSCODE_PORTABLE="$XDG_DATA_HOME/vscode"
export VSCODE_PORTABLE="${XDG_DATA_HOME}"/vscode
export WINEPREFIX="${XDG_DATA_HOME}"/wineprefixes/default
export XAUTHORITY="${XDG_RUNTIME_DIR}/Xauthority"
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
export XSERVERRC="${XDG_CONFIG_HOME}/X11/xserverrc"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java"
export KDEHOME="${XDG_CONFIG_HOME}/kde"

# Path changes
typeset -U path
if (( $+commands[systemd-path] )); then
  path=($path "$(systemd-path user-binaries)")
else
  path=($path "$HOME/.local/bin")
fi

path=("${CARGO_HOME}/bin" $path "${GOPATH}/bin" "${GEM_HOME}/bin")
# Debian Why
if [ -d "/usr/lib/cargo/bin/" ]; then
  path=($path "/usr/lib/cargo/bin")
fi


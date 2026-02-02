# ------------------------------------------------------------------------------
# XDG Base Directories
# ------------------------------------------------------------------------------
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-${HOME}/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-${HOME}/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-${HOME}/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-${HOME}/.local/state}

# ------------------------------------------------------------------------------
# ZSH Core Vars
# ------------------------------------------------------------------------------
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export HISTFILE="${XDG_STATE_HOME}/zsh/history"

# ------------------------------------------------------------------------------
# Tool Configuration (XDG Cleanup)
# ------------------------------------------------------------------------------
export AWS_CLI_HISTORY_FILE="${XDG_DATA_HOME}/aws/history"
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"
export AWS_CREDENTIALS_FILE="${XDG_DATA_HOME}/aws/credentials"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}/nv"
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export GEM_HOME="${XDG_DATA_HOME}/gem/ruby"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
export GOPATH="${XDG_DATA_HOME}/go"
export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
export GTK_RC_FILES="${XDG_CONFIG_HOME}/gtk-1.0/gtkrc"
export KDEHOME="${XDG_CONFIG_HOME}/kde"
export LEIN_HOME="${XDG_DATA_HOME}/lein"
export LESSHISTFILE="${XDG_STATE_HOME}/less/history"
export LESSKEY="${XDG_CONFIG_HOME}/less/keys"
export MACHINE_STORAGE_PATH="${XDG_DATA_HOME}/docker-machine"
export PASSAGE_DIR="${XDG_CONFIG_HOME}/passage/store"
export PASSAGE_IDENTITIES_FILE="${XDG_CONFIG_HOME}/passage/identities"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/password-store"
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/startup.py"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export TERMINFO="${XDG_DATA_HOME}/terminfo"
export TERMINFO_DIRS="${XDG_DATA_HOME}/terminfo:/usr/share/terminfo"
export VSCODE_PORTABLE="${XDG_DATA_HOME}/vscode"
export WINEPREFIX="${XDG_DATA_HOME}/wineprefixes/default"
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
export XSERVERRC="${XDG_CONFIG_HOME}/X11/xserverrc"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java"

# Only set XAUTHORITY if Runtime Dir exists to avoid breaking fallback behavior
[[ -n "$XDG_RUNTIME_DIR" ]] && export XAUTHORITY="${XDG_RUNTIME_DIR}/Xauthority"

# ------------------------------------------------------------------------------
# Wayland & Graphics
# ------------------------------------------------------------------------------
if [[ ${XDG_SESSION_TYPE} == wayland ]]; then
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
export QT_QPA_PLATFORMTHEME=qt5ct

# ------------------------------------------------------------------------------
# Node / NVM (Variables Only)
# ------------------------------------------------------------------------------
export NVM_DIR="${XDG_CONFIG_HOME}/nvm"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export npm_config_prefix="${HOME}/.local"

# ------------------------------------------------------------------------------
# Path Construction
# ------------------------------------------------------------------------------
typeset -U path

# Prepend paths (User specific > System specific)
# Note: systemd-path call removed for speed. Hardcoding is preferred in zshenv.
path=(
    "${HOME}/.local/bin"
    "${CARGO_HOME}/bin"
    "${GOPATH}/bin"
    "${GEM_HOME}/bin"
    "${XDG_STATE_HOME}/nix/profile/bin"
    "${HOME}/.node_modules/bin"
    $path
)

# Optional paths
[[ -d "/usr/lib/cargo/bin" ]] && path+=("/usr/lib/cargo/bin")
[[ -d "/opt/dart-sdk/bin" ]] && path+=("/opt/dart-sdk/bin")


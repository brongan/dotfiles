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

# Go and Rust have to be special
path=($path "$HOME/.cargo/bin" "$HOME/go/bin")

# Node.js
if ! (( $+commands[nvm] )); then
  path=($path "$HOME/.node_modules/bin")
  export npm_config_prefix="$HOME/.node_modules"
fi

# Work
if (( $+commands[toolbox] )); then
  path=$($path "$HOME/.toolbox/bin" "/usr/local/opt/ruby/bin")
fi


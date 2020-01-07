#!/bin/bash
set -x
stow config
stow fonts -t ~/.fonts
stow git
stow konsole -t ~/.local/share/konsole
stow powerlevel9k
stow tmux
stow vim
stow zsh

if [[ -z $DISPLAY ]] && [[ $(tty) =~ "/dev/tty*" ]]; then
  export DISPLAY=:0
  systemctl --user import-environment DISPLAY XAUTHORITY
  systemctl --user start xorg-session.target
fi


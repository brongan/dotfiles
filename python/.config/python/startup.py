#!/usr/bin/env python3
import atexit
import os
import readline
from pathlib import Path


if 'PYTHONHISTFILE' in os.environ:
    histfile = Path(os.environ['PYTHONHISTFILE']).relative_to(Path.home())
elif 'XDG_DATA_HOME' in os.environ:
    histfile = Path(os.environ['XDG_DATA_HOME']) / 'python' / 'python_history'
else:
    histfile = Path.home() / '.python_history'

histfile.parent.mkdir(parents=True, exist_ok=True)

try:
    readline.read_history_file(histfile)
except FileNotFoundError:
    histfile.touch()

readline.set_history_length(2000)
atexit.register(readline.write_history_file, histfile)


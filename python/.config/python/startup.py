#!/usr/bin/env python3
import os
import readline
from pathlib import Path


if history := os.environ.get('PYTHON_HISTORY'):
    Path(history).parent.mkdir(parents=True, exist_ok=True)
readline.set_history_length(2000)

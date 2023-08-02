#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title emacsclient
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/emacsclient-icon.png
# @raycast.packageName emacsclient
# @raycast.alias eclient emacsclient

# Documentation:
# @raycast.author Avelino


if ! brew services list | ag homebrew | ag emacs &>/dev/null; then
    brew services start d12frosted/emacs-plus/emacs-plus@28
fi
emacsclient -n -c -a ""

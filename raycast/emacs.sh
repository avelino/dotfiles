#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title emacs
# @raycast.mode compact

# Optional parameters:
# @raycast.icon images/emacs-icon.png

emacsclient -c -a '' --no-wait $argv

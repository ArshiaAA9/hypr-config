#!/usr/bin/env bash

exec >>/tmp/godot-nvim.log 2>&1

set -x

PIPE="/tmp/godothost"
FILE="$1"
LINE="${2:-1}"
COL="${3:-1}"
DIR="$(dirname "$FILE")"

echo "Godot-Nvim: Opening $FILE:$LINE:$COL"

if ! nvim --server "$PIPE" --remote-expr '1' &>/dev/null; then
    echo "Starting new Neovim server..."
    wezterm start -- nvim --listen "$PIPE" &
    for i in $(seq 1 20); do
        [[ -S "$PIPE" ]] && break
        sleep 0.1
    done
fi

nvim --server "$PIPE" --remote-send \
"<C-\\><C-N>:cd $(printf '%q' "$DIR")<CR>:e $(printf '%q' "$FILE")<CR>:call cursor(${LINE},${COL})<CR>zz"
hyprctl dispatch focuswindow "class:org.wezfurlong.wezterm" || true

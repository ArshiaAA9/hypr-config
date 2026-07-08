# ~/.local/bin/godot-nvim
#!/usr/bin/env bash

PIPE="/tmp/godothost"
FILE="$1"
LINE="${2:-1}"
COL="${3:-1}"

# Start Neovim server if it's not running
if ! nvim --server "$PIPE" --remote-expr '1' &>/dev/null; then
    # Launch Neovim in background
    nvim --listen "$PIPE" &
    sleep 0.3  # Give it a moment to start
fi

# Open the file + jump to line/column
nvim --server "$PIPE" --remote-send "<C-\\><C-N>:n ${FILE}<CR>:call cursor(${LINE},${COL})<CR>zz"

# Focus the Neovim window in Hyprland
hyprctl dispatch focuswindow "class:org.wezterm" >/dev/null 2>&1 || \
hyprctl dispatch focuswindow "class:nvim" >/dev/null 2>&1 || true

#!/usr/bin/env bash
# ┌──────────────────────────────────────────────┐
# │  dotfiles installer — symlinks via GNU Stow  │
# └──────────────────────────────────────────────┘
# usage: ./install.sh            -> install every package
#        ./install.sh nvim tmux  -> install only those
#        ./install.sh -D nvim    -> uninstall (remove symlinks)
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES=(alacritty atuin autokey imwheel kando nvim solaar starship tmux vim yazi)

c_ok=$'\e[38;2;156;207;216m'; c_info=$'\e[38;2;196;167;231m'; c_warn=$'\e[38;2;246;193;119m'; c_off=$'\e[0m'
say()  { printf '%s󰄬%s %s\n' "$c_ok" "$c_off" "$*"; }
info() { printf '%s%s %s\n' "$c_info" "$c_off" "$*"; }
warn() { printf '%s%s %s\n' "$c_warn" "$c_off" "$*"; }

command -v stow >/dev/null || { warn "GNU Stow not found → sudo apt install stow"; exit 1; }

MODE="-S"
if [[ "${1:-}" == "-D" ]]; then MODE="-D"; shift; fi
(( $# )) && PACKAGES=("$@")

cd "$DOTFILES"
for pkg in "${PACKAGES[@]}"; do
  [[ -d "$pkg" ]] || { warn "skipping unknown package: $pkg"; continue; }
  stow -v $MODE --target="$HOME" "$pkg" 2>&1 | sed 's/^/   /' || warn "conflict in $pkg (existing file? back it up and retry)"
  say "$pkg"
done

if [[ "$MODE" == "-S" ]]; then
  # tmux plugin manager
  if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    info "cloning tpm…"
    git clone --depth 1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  fi
  info "done! open tmux and press  prefix (Ctrl+s) + I  to fetch plugins"
  info "open nvim once — lazy.nvim bootstraps itself and installs everything"
fi

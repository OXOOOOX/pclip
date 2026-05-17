#!/usr/bin/env bash
set -euo pipefail

repo_url="https://raw.githubusercontent.com/OXOOOOX/pclip/main/pclip"
target="/usr/local/bin/pclip"

if command -v apt >/dev/null 2>&1; then
  sudo apt update
  sudo apt install -y wl-clipboard
else
  echo "install.sh: apt not found; skipping clipboard backend install." >&2
  echo "Install one of these manually: wl-clipboard, xclip, xsel" >&2
fi

if command -v curl >/dev/null 2>&1; then
  curl -fsSL "$repo_url" | sudo tee "$target" >/dev/null
elif command -v wget >/dev/null 2>&1; then
  wget -qO- "$repo_url" | sudo tee "$target" >/dev/null
else
  echo "install.sh: curl or wget is required to download pclip." >&2
  exit 1
fi

sudo chmod 0755 "$target"

if command -v bash >/dev/null 2>&1; then
  bash -n "$target"
fi

echo "pclip installed to $target"
echo "Test with: echo hello | pclip"

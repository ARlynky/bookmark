#!/bin/bash
set -e

PROJECT="bookmark"
REPO_URL="https://github.com/ARlynky/$PROJECT.git"
INSTALL_DIR="$HOME/.local/share/$PROJECT"

# Determine the shell rc file
if [[ "$SHELL" == */zsh ]]; then
  RC_FILE="$HOME/.zshrc"
elif [[ "$SHELL" == */bash ]]; then
  RC_FILE="$HOME/.bashrc"
else
  echo "⚠️ Unknown shell. Please manually add the bookmark function to your shell's rc file."
  RC_FILE="$HOME/.bashrc" # Fallback
fi

mkdir -p "$INSTALL_DIR"

if [ -d "$INSTALL_DIR/.git" ]; then
  echo "[*] Updating existing $PROJECT install..."
  git -C "$INSTALL_DIR" pull
else
  echo "[*] Cloning $PROJECT project..."
  git clone "$REPO_URL" "$INSTALL_DIR"
fi

# Add to shell rc if not already present
if ! grep -q "bookmark()" "$RC_FILE"; then
  cat >>"$RC_FILE" <<'EOF'

# ──────── bookmark CLI integration ────────
bookmark() {
    if [[ "$1" == "--goto" && -n "$2" ]]; then
        cd "$(python3 ~/.local/share/bookmark/bookmark.py --goto "$2")"
    else
        python3 ~/.local/share/bookmark/bookmark.py "$@"
    fi
}
EOF

  echo "[+] Bookmark function added to $RC_FILE"
else
  echo "[=] Bookmark function already exists in $RC_FILE"
fi

echo "[✓] $PROJECT installed and shell function is ready!"
echo "Restart or source the shell and try running: bookmark --help"

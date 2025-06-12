#!/bin/bash
set -e

REPO_URL="https://github.com/ARlynky/todo.git"
INSTALL_DIR="$HOME/.local/share/todo"
BIN_DIR="$HOME/.local/bin"

PROJECT="bookmark"

mkdir -p "$INSTALL_DIR"
mkdir -p "$BIN_DIR"

if [ -d "$INSTALL_DIR/.git" ]; then
  echo "[*] Updating existing $PROJECT install..."
  git -C "$INSTALL_DIR" pull
else
  echo "[*] Cloning $PROJECT project..."
  git clone "$REPO_URL" "$INSTALL_DIR"
fi

cat >"$BIN_DIR/$PROJECT" <<'EOF'
#!/bin/bash
cd "$HOME/.local/share/bookmark"
exec python3 bookmark.py "$@"
EOF
chmod +x "$BIN_DIR/$PROJECT"

if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
  echo "⚠️ Warning: $BIN_DIR is not in your PATH."
  echo "Add this line to your shell profile:"
  echo 'export PATH="$HOME/.local/bin:$PATH"'
fi

echo "[✓] $PROJECT installed!"
echo "Make sure \$HOME/.local/bin is in your PATH."
echo "Try running: $PROJECT -h"

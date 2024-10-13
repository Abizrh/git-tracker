#!/bin/bash

INSTALL_DIR="$HOME/.git-tracker"
BIN_DIR="$HOME/bin"

mkdir -p "$INSTALL_DIR"
mkdir -p "$BIN_DIR"

curl -o "$INSTALL_DIR/git-tracker" https://raw.githubusercontent.com/Abizrh/git-tracker/main/git-tracker.sh

chmod +x "$INSTALL_DIR/git-tracker"

ln -s "$INSTALL_DIR/git-tracker" "$BIN_DIR/git-tracker"

if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
    echo "Mohon jalankan 'source ~/.bashrc' atau buka terminal baru untuk memperbarui PATH."
fi

echo "Git Tracker telah terinstal. Anda dapat menggunakannya dengan perintah 'git-tracker'."

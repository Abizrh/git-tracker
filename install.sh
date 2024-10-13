#!/bin/bash

# Tentukan lokasi instalasi
INSTALL_DIR="$HOME/.local/bin"
CONFIG_DIR="$HOME/.config/git-tracker"

# Buat direktori instalasi jika belum ada
mkdir -p "$INSTALL_DIR"
mkdir -p "$CONFIG_DIR"

# Unduh script git-tracker
curl -o "$CONFIG_DIR/git-tracker" https://raw.githubusercontent.com/username/git-tracker/main/git-tracker.sh

# Buat git-tracker dapat dieksekusi
chmod +x "$CONFIG_DIR/git-tracker"

# Buat symlink di INSTALL_DIR
ln -sf "$CONFIG_DIR/git-tracker" "$INSTALL_DIR/git-tracker"

# Fungsi untuk menambahkan ke PATH
add_to_path() {
    local shell_rc="$1"
    if [ -f "$shell_rc" ]; then
        if ! grep -q "$INSTALL_DIR" "$shell_rc"; then
            echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$shell_rc"
            echo "PATH ditambahkan ke $shell_rc"
        fi
    fi
}

# Tambahkan ke berbagai shell configuration files
add_to_path "$HOME/.bashrc"
add_to_path "$HOME/.zshrc"
add_to_path "$HOME/.config/fish/config.fish"

echo "Git Tracker telah terinstal di $CONFIG_DIR"
echo "Symlink dibuat di $INSTALL_DIR/git-tracker"
echo "Pastikan untuk me-reload shell Anda atau menjalankan 'source' pada file konfigurasi shell Anda."
echo "Anda dapat menggunakan Git Tracker dengan perintah 'git-tracker'"

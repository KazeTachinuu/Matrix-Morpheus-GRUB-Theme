#!/bin/bash
# ===============================================================
# Matrix Morpheus GRUB Theme Installer for Bazzite/Fedora Atomic
# Repository: https://github.com/Priyank-Adhav/Matrix-GRUB-Theme
#
# Compatible with:
#   - Bazzite (all variants)
#   - Fedora Silverblue/Kinoite
#   - Other Fedora Atomic/Universal Blue distributions
# ===============================================================

set -e

THEME_NAME="Matrix"
THEME_DIR="/boot/grub2/themes"
GRUB_CFG="/etc/default/grub"
GRUB_FILE_ALT="/etc/grub2.cfg"

echo ""
echo "==========================================="
echo "Matrix GRUB Theme Installer (Bazzite/Fedora)"
echo "==========================================="
echo ""

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Error: Please run this script as root (use sudo)."
    exit 1
fi

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Verify theme directory exists in the repo
if [ ! -d "$SCRIPT_DIR/$THEME_NAME" ]; then
    echo "Error: Theme directory '$THEME_NAME' not found in $SCRIPT_DIR"
    echo "Make sure the Matrix folder exists alongside this script."
    exit 1
fi

# Verify critical theme files exist
if [ ! -f "$SCRIPT_DIR/$THEME_NAME/theme.txt" ]; then
    echo "Error: theme.txt not found in $SCRIPT_DIR/$THEME_NAME/"
    exit 1
fi

if [ ! -d "$SCRIPT_DIR/$THEME_NAME/icons" ]; then
    echo "Error: icons directory not found in $SCRIPT_DIR/$THEME_NAME/"
    exit 1
fi

echo "[1/6] Detecting system..."
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "      Detected: $NAME ${VERSION_ID:-}"
fi

# Check for rpm-ostree (Bazzite/Fedora Atomic indicator)
if command -v rpm-ostree >/dev/null 2>&1; then
    echo "      System: Fedora Atomic (rpm-ostree detected)"
else
    echo "      Warning: rpm-ostree not found. This script is designed for Bazzite/Fedora Atomic."
    echo "      Continuing anyway..."
fi

echo ""
echo "[2/6] Checking GRUB configuration file..."
if [ ! -f "$GRUB_CFG" ]; then
    echo "      $GRUB_CFG not found. Creating it..."
    touch "$GRUB_CFG"
    echo "# GRUB configuration for Bazzite" > "$GRUB_CFG"
    echo "      Created $GRUB_CFG"
else
    echo "      Found $GRUB_CFG"
fi

echo ""
echo "[3/6] Creating theme directory..."
mkdir -p "$THEME_DIR"
echo "      Created $THEME_DIR"

echo ""
echo "[4/6] Installing theme files..."
# Remove existing theme if present to ensure clean install
if [ -d "$THEME_DIR/$THEME_NAME" ]; then
    rm -rf "$THEME_DIR/$THEME_NAME"
    echo "      Removed existing theme"
fi

cp -r "$SCRIPT_DIR/$THEME_NAME" "$THEME_DIR/" || {
    echo ""
    echo "Error: Failed to copy theme files."
    echo "If you see 'Read-only file system', try:"
    echo "  sudo mount -o remount,rw /boot"
    echo "Then run this script again."
    exit 1
}
echo "      Copied theme to $THEME_DIR/$THEME_NAME/"

echo ""
echo "[5/6] Configuring GRUB..."

THEME_PATH="$THEME_DIR/$THEME_NAME/theme.txt"

# Function to set or update a GRUB config value
set_grub_config() {
    local key="$1"
    local value="$2"

    if grep -q "^${key}=" "$GRUB_CFG" 2>/dev/null; then
        sed -i "s|^${key}=.*|${key}=\"${value}\"|" "$GRUB_CFG"
        echo "      Updated $key"
    else
        echo "${key}=\"${value}\"" >> "$GRUB_CFG"
        echo "      Added $key"
    fi
}

# Set required configurations
set_grub_config "GRUB_TERMINAL_OUTPUT" "gfxterm"
set_grub_config "GRUB_THEME" "$THEME_PATH"
# Use auto to let GRUB pick the best resolution, with 1920x1080 as fallback
# The theme images are 1920x1080, GRUB will scale them appropriately
set_grub_config "GRUB_GFXMODE" "auto"
set_grub_config "GRUB_GFXPAYLOAD_LINUX" "keep"

echo ""
echo "[6/6] Regenerating GRUB configuration..."

if command -v grub2-mkconfig >/dev/null 2>&1; then
    grub2-mkconfig -o "$GRUB_FILE_ALT" 2>&1 | grep -v "^#" | head -5
    echo "      GRUB configuration regenerated successfully."
elif command -v grub-mkconfig >/dev/null 2>&1; then
    grub-mkconfig -o "$GRUB_FILE_ALT" 2>&1 | grep -v "^#" | head -5
    echo "      GRUB configuration regenerated successfully."
else
    echo ""
    echo "Warning: grub2-mkconfig not found."
    echo "Please run manually after reboot:"
    echo "  ujust regenerate-grub"
fi

echo ""
echo "==========================================="
echo "Installation complete!"
echo "==========================================="
echo ""
echo "Theme installed to: $THEME_DIR/$THEME_NAME/"
echo ""
echo "Configuration set in $GRUB_CFG:"
echo "  GRUB_TERMINAL_OUTPUT=\"gfxterm\""
echo "  GRUB_THEME=\"$THEME_PATH\""
echo "  GRUB_GFXMODE=\"auto\""
echo "  GRUB_GFXPAYLOAD_LINUX=\"keep\""
echo ""
echo "Reboot now to see your Matrix GRUB theme!"
echo ""

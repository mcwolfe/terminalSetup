#!/bin/bash

# Determine the OS type
OS_TYPE=$(uname)
ARCH_TYPE=$(uname -m)

# Detect the package manager based on the system
if command -v apt &> /dev/null; then
    PKG_MANAGER="apt"
elif command -v dnf &> /dev/null; then
    PKG_MANAGER="dnf"
else
    echo "Unsupported package manager. Please use a system with apt or dnf."
    exit 1
fi

# List of applications to install
apps=("node" "git" "wget" "python@3.12" "ruby" "vim" "go" "rust" "emacs" "sqlite" "obsidian" "logseq" "visual-studio-code" "julia" "haskell")
apps+=("wezterm" "kitty" "Alacritty")
# Function to install packages using apt or dnf
install_package() {
    local package=$1
    if [[ "$PKG_MANAGER" == "apt" ]]; then
        sudo apt update
        sudo apt install -y "$package"
    elif [[ "$PKG_MANAGER" == "dnf" ]]; then
        sudo dnf install -y "$package"
    fi
}

# Install flatpak if not already installed and add Flathub repository
install_flatpak() {
    if ! command -v flatpak &> /dev/null; then
        echo "Flatpak is not installed. Installing Flatpak..."
        if [[ "$PKG_MANAGER" == "apt" ]]; then
            sudo apt update
            sudo apt install -y flatpak
        elif [[ "$PKG_MANAGER" == "dnf" ]]; then
            sudo dnf install -y flatpak
        fi
        sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    else
        echo "Flatpak is already installed."
    fi
}

# Function to install apps with flatpak if they are not available in apt or dnf
install_with_flatpak() {
    local flatpak_name=$1
    echo "Installing $flatpak_name using Flatpak..."
    flatpak install -y flathub "$flatpak_name"
}

# Install core applications using apt or dnf
for app in "${apps[@]}"; do
    echo "Checking $app..."
    if ! command -v "$app" &> /dev/null; then
        echo "$app is not installed. Installing..."
        install_package "$app"
    else
        echo "$app is already installed."
    fi
done

# Install and set up Flatpak
install_flatpak

# Example of installing an app with Flatpak if needed
# install_with_flatpak "com.visualstudio.code"

echo "Installation complete."


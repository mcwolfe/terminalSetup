#!/bin/bash

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Determine the OS type
OS_TYPE=$(uname)

# List of applications, languages, and tools to install
apps=("node" "git" "wget" "python@3.12" "ruby" "vim" "go" "rust" "emacs" "sqlite" "obsidian" "logseq" "visual-studio-code" "julia" "ghc")

# Add macOS-specific applications and terminals
if [[ "$OS_TYPE" == "Darwin" ]]; then
    echo "Detected macOS. Adding macOS-specific apps."
    apps+=("iterm2")
fi

# Add cross-platform terminal emulators
apps+=("wezterm" "kitty")

# Loop through each app and install it if not already installed
for app in "${apps[@]}"; do
    if ! brew list "$app" &>/dev/null; then
        echo "Installing $app..."
        # Use --cask for GUI applications like iTerm2, WezTerm, and Kitty
        if [[ "$app" == "iterm2" || "$app" == "wezterm" || "$app" == "kitty" || "$app" == "visual-studio-code" || "$app" == "obsidian" || "$app" == "logseq" ]]; then
            brew install --cask "$app"
        else
            brew install "$app"
        fi
    else
        echo "$app is already installed."
    fi
done

# Check if Emacs is installed and install Org-mode package if Emacs is available
if command -v emacs &> /dev/null; then
    echo "Emacs is installed. Checking for Org-mode setup..."
    # Automatically set up Org-mode if it's not already configured
    if ! emacs --batch --eval "(require 'org)" &> /dev/null; then
        echo "Org-mode not found or not set up. Installing Org-mode..."
        emacs --batch --eval "(progn (package-initialize) (package-refresh-contents) (package-install 'org))"
    else
        echo "Org-mode is already installed and configured in Emacs."
    fi
else
    echo "Emacs is not installed, skipping Org-mode setup."
fi

echo "All specified apps and tools are checked and installed where necessary."
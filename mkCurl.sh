#!/bin/bash

# Determine the OS type
OS_TYPE=$(uname)

# Function to install curl based on the detected OS
install_curl() {
    if [[ "$OS_TYPE" == "Darwin" ]]; then
        echo "Installing curl on macOS using Homebrew..."
        if ! command -v brew &> /dev/null; then
            echo "Homebrew is not installed. Installing Homebrew first..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew install curl
    elif [[ "$OS_TYPE" == "Linux" ]]; then
        echo "Installing curl on Linux..."
        # Check for common package managers and install curl accordingly
        if command -v apt &> /dev/null; then
            sudo apt update
            sudo apt install -y curl
        elif command -v dnf &> /dev/null; then
            sudo dnf install -y curl
        elif command -v pacman &> /dev/null; then
            sudo pacman -Sy curl
        else
            echo "Could not determine package manager. Please install curl manually."
            exit 1
        fi
    else
        echo "Unsupported OS. Please install curl manually."
        exit 1
    fi
}

# Check if curl is installed, if not, call the install function
if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Installing curl..."
    install_curl
else
    echo "curl is already installed."
fi

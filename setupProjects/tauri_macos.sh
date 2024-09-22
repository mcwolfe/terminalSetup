#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Step 1: Check and install Node.js
if ! command_exists node; then
    echo "Node.js is not installed. Installing Node.js..."
    # Install Node.js using your preferred method (e.g., nvm, apt, brew)
    curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
    sudo brew install node
fi

# Step 2: Check and install Rust
if ! command_exists rustc; then
    echo "Rust is not installed. Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME/.cargo/env"
fi

# Step 3: Install Tauri CLI globally
if ! command_exists tauri; then
    echo "Installing Tauri CLI..."
    npm install -g @tauri-apps/cli
fi

# Step 4: Create a new Tauri project
echo "Enter the project name:"
read project_name
npm create tauri-app "$project_name"

# Step 5: Navigate to the project directory and install dependencies
cd "$project_name" || exit
npm install

echo "Tauri project '$project_name' has been set up successfully!"
echo "npm run tauri dev"
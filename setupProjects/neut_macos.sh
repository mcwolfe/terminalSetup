#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if a project name is provided
if [ -z "$1" ]; then
  echo "Usage: ./setup_neutralino.sh <project_name>"
  exit 1
fi

PROJECT_NAME=$1


# Step 1: Check and install Node.js
if ! command_exists node; then
    echo "Node.js is not installed. Installing Node.js..."
    # Install Node.js using your preferred method (e.g., nvm, apt, brew)
    curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
    sudo brew install node
fi


# Check if Neutralino is installed
if ! command -v neu &> /dev/null; then
  echo "Neutralino is not installed. Installing Neutralino globally..."
  npm install -g @neutralinojs/neu
else
  echo "Neutralino is already installed. Checking for updates..."
  npm update -g @neutralinojs/neu
fi

# Check if the project directory already exists
if [ -d "$PROJECT_NAME" ]; then
  echo "Project directory '$PROJECT_NAME' already exists. Skipping project creation."
else
  echo "Creating a new Neutralino project: $PROJECT_NAME"
  neu create "$PROJECT_NAME"
fi

# Navigate to the project directory
cd "$PROJECT_NAME" || { echo "Failed to enter project directory."; exit 1; }

# Check if dependencies are already installed
if [ -f "neutralino.config.json" ]; then
  echo "Project dependencies appear to be set up already."
else
  echo "Setting up the project dependencies..."
  neu build
fi

# Start the Neutralino app
echo "Starting the Neutralino application..."
neu run

echo "Neutralino project setup complete!"
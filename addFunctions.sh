#!/bin/bash

# Determine the OS type and set the target configuration file
OS_TYPE=$(uname)
if [[ "$OS_TYPE" == "Darwin" ]]; then
    CONFIG_FILE="$HOME/.zshrc"  # macOS typically uses .zshrc
else
    CONFIG_FILE="$HOME/.bashrc" # Linux typically uses .bashrc
fi

# Path to the external functions file
FUNCTIONS_FILE="$HOME/bash_functions.sh"

# Check if the functions file exists, if not, create an empty one
if [ ! -f "$FUNCTIONS_FILE" ]; then
    touch "$FUNCTIONS_FILE"
    echo "# Add your custom functions here" >> "$FUNCTIONS_FILE"
fi

# Append the sourcing line to the configuration file if not already present
if ! grep -q "source $FUNCTIONS_FILE" "$CONFIG_FILE"; then
    echo -e "\n# Source external functions" >> "$CONFIG_FILE"
    echo "source $FUNCTIONS_FILE" >> "$CONFIG_FILE"
fi

# Reload the configuration file to apply changes
source "$CONFIG_FILE"

echo "Functions are now sourced from $FUNCTIONS_FILE and linked in $CONFIG_FILE."#!/bin/bash

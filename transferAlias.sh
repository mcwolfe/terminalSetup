#!/bin/bash

# Determine the OS type and set the target configuration file
OS_TYPE=$(uname)
if [[ "$OS_TYPE" == "Darwin" ]]; then
    CONFIG_FILE="$HOME/.zshrc"  # macOS uses .zshrc
else
    CONFIG_FILE="$HOME/.bashrc" # Linux uses .bashrc
fi

# Backup the existing configuration file before modifying
cp "$CONFIG_FILE" "$CONFIG_FILE.bak"

# File to store the current aliases temporarily
ALIAS_FILE="aliases.txt"

# Declare an array to hold the formatted aliases
declare -a formatted_aliases

# Read the aliases from the text file into the array
while IFS= read -r line; do
    formatted_aliases+=("alias $line")
done < "$ALIAS_FILE"

# Append the formatted aliases to the shell configuration file
echo -e "\n# Appended aliases from the script" >> "$CONFIG_FILE"
for alias in "${formatted_aliases[@]}"; do
    echo "$alias" >> "$CONFIG_FILE"
done

# Reload the configuration file to apply changes
source "$CONFIG_FILE"

# Clean up by removing the temporary alias file
rm "$ALIAS_FILE"

echo "Formatted aliases have been added to $CONFIG_FILE successfully."
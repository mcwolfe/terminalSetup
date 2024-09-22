#!/bin/bash

# Create an array to hold formatted aliases
declare -a formatted_aliases

ALIAS_FILE="aliases.txt"

# Read current aliases, format them, and store them in the array
# Save the current aliases to a text file
alias | sed -E 's/^alias //' > "$ALIAS_FILE"


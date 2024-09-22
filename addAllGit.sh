#!/bin/bash

# Show the current status of the repository
git status

# Add all changes to staging
git add .

# Prompt the user for a commit message
echo "Write commit message:"
read comments

# Commit the changes with the provided message
git commit -m "$comments"

# Push the changes to the remote repository
git push

# Inform the user that the process is complete
echo "Changes have been pushed to GitHub."

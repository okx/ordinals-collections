#!/bin/bash

# Create the updated_files directory if it doesn't exist
mkdir -p updated_files

# Get the changes between the current branch and the base branch
git fetch origin $GITHUB_BASE_REF:refs/remotes/origin/$GITHUB_BASE_REF
git checkout -b temp-branch origin/$GITHUB_BASE_REF
changes=$(git diff --name-only temp-branch HEAD)

# Loop through each changed file and append the updates to the new directory
for file in $changes; do
  if [ -f "$file" ]; then
    # Create the directory structure in updated_files
    mkdir -p updated_files/$(dirname $file)

    # Append the updates to the new file in updated_files
    git show HEAD:$file >> updated_files/$file
  fi
done
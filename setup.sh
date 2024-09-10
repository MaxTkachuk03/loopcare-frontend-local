#!/bin/bash

# Copy all hooks from git_hooks directory to .git/hooks
cp git_hooks/* .git/hooks/

# Make sure all hooks are executable
chmod +x .git/hooks/*

echo "Git hooks have been set up successfully!"
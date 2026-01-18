#!/bin/bash

# Exit on error
set -e

# Define build directory
BUILD_DIR="static"

# Clean up previous build
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

# Copy index.html to build directory
cp index.html "$BUILD_DIR/"

# Function to copy assets while preserving directory structure under static/puzzles
copy_puzzle_assets() {
    local puzzle_dir="$1"
    local target_dir="$BUILD_DIR/$puzzle_dir"
    
    mkdir -p "$target_dir"
    
    # Copy html, js, css, and images
    find "$puzzle_dir" -maxdepth 1 -type f \( -name "*.html" -o -name "*.js" -o -name "*.css" -o -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.gif" \) -exec cp {} "$target_dir/" \;
}

# Find all puzzle directories containing html files and copy them
find puzzles -name "*.html" -exec dirname {} \; | sort -u | while read -r dir; do
    copy_puzzle_assets "$dir"
done

echo "Build complete! Files are in $BUILD_DIR/"

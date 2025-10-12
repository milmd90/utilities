#!/bin/bash

# Directory to scan for duplicates
TARGET_DIR=".."

# Temporary file to store file hashes and paths
TEMP_FILE=$(mktemp)

echo "Scanning for duplicate files in $TARGET_DIR..."

# Find all regular files in the target directory and its subdirectories,
# calculate their MD5 hash, and store it along with the file path in the temporary file.
find "$TARGET_DIR" -type f -print0 | while IFS= read -r -d $'\0' file; do
    md5sum "$file" >> "$TEMP_FILE"
done

echo "Identifying duplicates..."

# Sort the temporary file by hash, then use `uniq -w 32 -D` to find duplicate hashes.
# The `-w 32` ensures comparison only on the first 32 characters (the MD5 hash).
# The `-D` prints all duplicate lines.
# `awk '{print $2}'` extracts the file path from the duplicate lines.
# `sort -u` removes any duplicate paths if a file was listed multiple times for some reason.
DUPLICATE_FILES=$(sort "$TEMP_FILE" | uniq -w 32 -D | awk '{print $2}' | sort -u)

if [ -z "$DUPLICATE_FILES" ]; then
    echo "No duplicate files found."
else
    echo "The following duplicate files will be removed (keeping the first encountered instance):"
    echo "$DUPLICATE_FILES"

    # Iterate through the identified duplicate files and remove them.
    # This example keeps the first encountered instance and removes subsequent duplicates.
    # Be cautious: this permanently deletes files. Consider adding a confirmation prompt.
    echo "$DUPLICATE_FILES" | while IFS= read -r duplicate_file; do
        # You might want to add a check here to ensure the file exists before attempting to remove.
        # For example: if [ -f "$duplicate_file" ]; then rm "$duplicate_file"; fi
        echo "Removing: $duplicate_file"
        # rm "$duplicate_file"
    done
    echo "Duplicate files removed."
fi

# Clean up the temporary file
rm "$TEMP_FILE"
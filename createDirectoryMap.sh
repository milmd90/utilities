#!/usr/bin/env bash

# Creates a JSON file representing the file structure starting at the given directory.
# Usage: ./createDirectoryMap.sh <directory> [output.json]
#   directory  - path to the root directory to map
#   output.json - optional path for the output file (default: directory_map.json)

set -e

ROOT_DIR="${1:?Usage: $0 <directory> [output.json]}"
OUTPUT_FILE="${2:-directory_map.json}"

if [[ ! -d "$ROOT_DIR" ]]; then
  echo "Error: '$ROOT_DIR' is not a directory or does not exist." >&2
  exit 1
fi

# Escape a string for use inside JSON double-quoted value: \ " and newlines
json_escape() {
  local s="$1"
  s="${s//\\/\\\\}"
  s="${s//\"/\\\"}"
  s="${s//$'\n'/\\n}"
  printf '%s' "$s"
}

# Recursively emit a JSON object for the given directory (no outer braces for root)
emit_dir() {
  local dir="$1"
  local first=true
  local name name_escaped item

  printf '{'
  for item in "$dir"/*; do
    [[ -e "$item" ]] || continue
    $first || printf ','
    first=false
    name=$(basename "$item")
    name_escaped=$(json_escape "$name")
    if [[ -d "$item" ]]; then
      printf '"%s": ' "$name_escaped"
      emit_dir "$item"
    else
      printf '"%s": null' "$name_escaped"
    fi
  done
  printf '}'
}

emit_dir "$ROOT_DIR" > "$OUTPUT_FILE"
echo "Wrote directory map to $OUTPUT_FILE"

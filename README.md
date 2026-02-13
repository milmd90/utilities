# Utilities

Shell scripts for file and directory operations.

---

## Create Directory Map

Builds a JSON file that represents the file structure starting at a given directory. Recursively walks the tree: each file is a key with value `null`, each directory is a key whose value is a nested object with the same structure.

**Usage:** `./createDirectoryMap.sh <directory> [output.json]`

- **directory** — Path to the root directory to map (required).
- **output.json** — Path for the output file (optional; default: `directory_map.json` in the current directory).

**Example:** `./createDirectoryMap.sh ~/Projects ./project_map.json`

---

## Deduplicate Files

Finds and optionally removes duplicate files that follow the " (1)" pattern (e.g. `document (1).pdf` when `document.pdf` exists). Runs recursively from the given directory. Use without `execute` to see what would be removed (dry run).

**Usage:** `./deduplicateFiles.sh <start_directory> [execute]`

- **start_directory** — Directory to start searching from (required).
- **execute** — If the second argument is exactly `execute`, duplicate files are deleted. Otherwise the script only reports what would be removed (dry run).

**Example:** `./deduplicateFiles.sh ~/Downloads` (dry run)  
**Example:** `./deduplicateFiles.sh ~/Downloads execute` (delete duplicates)

---

## Rename Files

Searches for files and directories to rename. Names must start with the "find" string; that prefix is replaced with the "replace" string. The search starts in the given directory and goes exactly "levels" subdirectory levels deep.

**Usage:** `./renameFiles.sh find replace start levels`

- **find** — The string to search for at the start of names.
- **replace** — The string to replace it with.
- **start** — The starting directory.
- **levels** — Number of subdirectory levels to search.

**Example:** `./renameFiles.sh old_ new_ ./myfiles 2`

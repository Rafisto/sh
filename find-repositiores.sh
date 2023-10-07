#!/bin/bash

read -p "Enter the starting directory (press Enter for current directory): " start_dir

if [ -z "$start_dir" ]; then
    start_dir=$(pwd)
fi

echo "Searching for git without remotes in: $start_dir" 

unset_remote_repos=()

while IFS= read -r -d '' config_file; do
    repo_dir=$(dirname "$config_file")
    if ! grep -q 'url =' "$config_file"; then
        echo "${repo_dir}"
        unset_remote_repos+=("$repo_dir")
    fi
done < <(find "$start_dir" -type f -name "config" -print0)

if [ ${#unset_remote_repos[@]} -eq 0 ]; then
    echo "No Git repositories with unset remotes found."
else
    echo "Search concluded."
fi

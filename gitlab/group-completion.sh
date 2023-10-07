#!/bin/bash

echo "$0"
cur=$(date '+%Y-%m-%d %H:%M:%S')
echo "List status at: ${cur}"

DEBUG=false

# Source GitLab PRIVATE_TOKEN and API_BASE_URL e.g. https://gitlab.com
if [ ! -f ".env" ];
then
    echo "You must specify PRIVATE_TOKEN in .env file."
    exit 1
fi

source .env

# Define your GitLab group and token
GROUP_ID="818"
MINIMUM_FILES_IN_A_REPOSITORY=1

repos=""
page=1

while true; do
    API_URL="${API_BASE_URL}/api/v4/groups/$GROUP_ID/projects?page=$page"
    page_repos=$(curl -s --header "PRIVATE-TOKEN: $PRIVATE_TOKEN" "$API_URL")

    if [ "$page_repos" == "[]" ]; then
        break
    fi

    repos="$repos$page_repos"
    page=$((page + 1))
done

# Loop through repositories
for repo in $(echo "$repos" | jq -r '.[].id'); do
    all=$(($all + 1))
    # Get repository details
    repo_info=$(curl -s --header "PRIVATE-TOKEN: $PRIVATE_TOKEN" "${API_BASE_URL}/api/v4/projects/${repo}/repository/tree")
    name=$(curl -s --header "PRIVATE-TOKEN: $PRIVATE_TOKEN" "${API_BASE_URL}/api/v4/projects/${repo}" | jq -r '.name')

    if [ $DEBUG == true ];
    then
        echo "Found repository ${name} with id: ${repo}"
    fi

    # Get the number of files in the repository
    num_files=$(echo "$repo_info" | jq length)

    if [ $DEBUG == true ];
    then
        echo "${num_files}"
    fi

    # Determine if the checkbox should be marked
    checkbox="- [ ]"
    if [ "$num_files" -gt "$MINIMUM_FILES_IN_A_REPOSITORY" ]; then
        checkbox="- [✓]"
        optional="${num_files}"
        finished=$(($finished + 1))
    else
        optional=$(echo "${repo_info}" | jq -r '.[0].name')
    fi

    if [ $DEBUG == true ];
    then
        echo "${checkbox} ${name} (${repo}, files=${optional})"
    else
        echo "${checkbox} ${name}"
    fi
done

echo "${finished}/${all} repositories have been uploaded."

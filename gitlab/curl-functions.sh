#!/bin/bash

if [ ! -f '.env' ];
then
    echo ".env not present. Make sure to create a .env file and include"
    echo "GITLAB_TOKEN=..."
fi

source .env

touch "data2.txt"

list_namepspaces() {
    # LIST NAMESPACES
    curl --header "PRIVATE-TOKEN: ${GITLAB_TOKEN}" "${API_BASE_URL}/api/v4/namespaces"
}

create_repositories() {
    # LOOP THROUGH TEAMS
    while IFS= read -r line
    do
        # CREATE REPOSITORY
        id=$(curl --request POST --header "PRIVATE-TOKEN: ${GITLAB_TOKEN}" \
            --header "Content-Type: application/json" --data "{
                \"name\": \"${line}\", \"description\": \"Repository of ${line}\",
                \"namespace_id\": \"818\", \"initialize_with_readme\": \"true\"}" \
            --url "${API_BASE_URL}/api/v4/projects/" | jq .id)

        # CREATE ACCESS TOKEN
        token=$(curl --request POST --header "PRIVATE-TOKEN: ${GITLAB_TOKEN}" \
        --header "Content-Type:application/json" \
        --data '{ "name":"curl_token", "scopes":["api", "read_repository", "write_repository"], "expires_at":"2023-10-01", "access_level": 40 }' \
        "${API_BASE_URL}/api/v4/projects/${id}/access_tokens" | jq .token) 

        echo "${id} :: ${API_BASE_URL}/cybertron/zadania2023/${line} :: ${token}" >> "data.txt"
        
    done < "teams2.txt"
}

delete_repository() {
    # DELETE REPOSITORY WITH SPECIFIC ID
    curl --request DELETE --header "PRIVATE-TOKEN: ${GITLAB_TOKEN}" ${API_BASE_URL}/api/v4/projects/563/
}

allow_force_push() {
    # UNPROTECT MASTER BRANCH
    while IFS= read -r line
    do
        id=$(echo "$line" | cut -d' ' -f1)
        curl --request DELETE --header "PRIVATE-TOKEN: ${GITLAB_TOKEN}" "${API_BASE_URL}/api/v4/projects/${id}/protected_branches/master"
    done < "data2.txt"
}

# create_repositories

### sh repository
A set of projects to learn bash

### Project List

- [Sort and copy files into a new directory](/organizer). Files are organized by their extension and the initial directory is left untouched. Contains dummy file generator `files.sh` and `organizer.sh`.
- [Gitlab: Batch create repositories, access tokens...](/gitlab/curl-functions.sh) Edit branch protection rules, remove repositories and list namespaces. All in one group management utility. Contains `curl-functions.sh`. Uses `.env`.
- [Gitlab: Check if each repository in a group has more than one file](/gitlab/group-completion.sh). Helpful to track work by which repositories have changed from having only a template of README.md. Contains `group-completion.sh`. Uses `.env`.
- [Find all git repositories in a directory with undefined remote url](/git/endangered-repositories.sh). Prints each repository directory which may be possibly endangered with unspecified remote. Contains `endangered-repositories.sh`.

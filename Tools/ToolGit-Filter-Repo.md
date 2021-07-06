# Use cases
- Split up a git repository
- Delete a sensible file (causing licensing infringement or containing passwords for instance)

# How to
Avoid creating a new git history from current files, and prefer rewriting/filtering the commits (see [this post](https://stackoverflow.com/questions/10067848/remove-folder-and-its-contents-from-git-githubs-history)).
The `git-filter-repo` tool is tailored for this exact task, see its [GitHub repo](https://github.com/newren/git-filter-repo) for more infos.

# Warning
When filtering out git repo, you are effectively REWRITING the git history, which is a destructive action. In other words, the commits and their hashes will change, preventing any further common ground/context. If you don't know what it means for the repo(s) you are processing, stop and ask for help, or at least process with caution!

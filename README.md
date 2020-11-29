This is an extension of [https://github.com/djmaze/tiddlywiki-docker](tiddlywiki-docker) of djmaze
The files `init-and-run-wiki` and `tiddlyweb_host` are taken as is.

This docker will also create a git commit on every file change.
If ssh keys and GIT_REPO are supplied: Push all changes every 5 minutes to an upstream repository.

Have a look at [https://github.com/djmaze/tiddlywiki-docker](djmaze/tiddlywiki-docker) for basic configuration.

# Extended Configuration possibilities

Commits will be created without any of the following configurations.
`GIT_REPO` env var and `root/.ssh` volume are required for upstream pushes.


## ENV Vars

| Name | Description |
| GIT_REPO | ssh-link-to-repo (e.g. git@github.com:a-kraschitzer/tiddlywiki-docker-git.git) |
| GIT_AUTHOR_EMAIL | Email of the git commit author |
| GIT_AUTHOR_NAME | Name of the git commit author |

## VOLUMES
| Docker path | Description |
| /root/.ssh | location for SSH Keys that are used for git push (be sure to chmod correctly) |
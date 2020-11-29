This is an extension of [djmaze/tiddlywiki-docker](https://github.com/djmaze/tiddlywiki-docker).  
The files `init-and-run-wiki` and `tiddlyweb_host` are taken as is.

Additional to the base functionality this docker will also create a git commit on every file change (excl. `Draft of*`, `__StoryList.tid`).  
If ssh keys and GIT_REPO are supplied, all changes will be pushed to an upstream repository every 5 minutes.


Have a look at [djmaze/tiddlywiki-docker](https://github.com/djmaze/tiddlywiki-docker) for basic configuration.



## Extended Configuration possibilities

Commits will be created without any of the configurations.  
`GIT_REPO` env var and `root/.ssh` volume are required for upstream pushes.



### ENV Vars

Name | Description
---- | -----------
GIT_REPO | ssh-link-to-repo (e.g. git@github.com:a-kraschitzer/tiddlywiki-docker-git.git)
GIT_AUTHOR_EMAIL | Email of the git commit author
GIT_AUTHOR_NAME | Name of the git commit author



### VOLUMES

Docker path | Description
----------- | -----------
/root/.ssh | location for SSH Keys that are used for git push (be sure to chmod correctly)

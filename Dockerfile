FROM ubuntu:bionic

RUN apt update
RUN apt install -y ssh git wget npm fswatch cron

RUN npm install -g tiddlywiki
RUN wget -O /tiddlyweb_host_template https://raw.githubusercontent.com/a-kraschitzer/tiddlywiki-docker-git/main/tiddlyweb_host
RUN wget -O /usr/local/bin/init-and-run-wiki https://raw.githubusercontent.com/a-kraschitzer/tiddlywiki-docker-git/main/init-and-run-wiki

RUN git config --global user.email "n@t.set"
RUN git config --global user.name "Not Set"

RUN echo "git status --porcelain | tr '\\n' '; '" > /root/commit_msg.sh
RUN echo "*/5 * * * * sh -c 'cd /var/lib/tiddlywiki; git push;' >> /var/log/cron.log 2>&1" | crontab

RUN echo 'cd /var/lib/tiddlywiki; bash /usr/local/bin/init-and-run-wiki 2>&1 | (sed -e "s/\(.*\)/[wiki]: \\1/")' > /root/start_wiki.sh
RUN echo 'cd /var/lib/tiddlywiki; git init 2>&1 | (sed -e "s/\(.*\)/[gitsetup]: \\1/"); touch .gitignore; git add .gitignore 2>&1 | (sed -e "s/\(.*\)/[gitsetup]: \\1/"); git commit -m "ini" 2>&1 | (sed -e "s/\(.*\)/[gitsetup]: \\1/"); git remote add origin $GIT_REPO 2>&1 | (sed -e "s/\(.*\)/[gitsetup]: \\1/"); git branch -M main 2>&1 | (sed -e "s/\(.*\)/[gitsetup]: \\1/"); git push -u origin main --force 2>&1 | (sed -e "s/\(.*\)/[gitsetup]: \\1/");' > /root/prep_git.sh
RUN echo 'while true; do fswatch -o -r --exclude=".git" --exclude="Draft of" --exclude="__StoryList.tid" --event-flags --event="Updated" --event="Created" --event="Removed" --monitor inotify_monitor /var/lib/tiddlywiki/ | xargs -I{} bash -c '"'"'echo {} && cd /var/lib/tiddlywiki && git add ./* && git commit -a -m "$(bash /root/commit_msg.sh)"'"'"' 2>&1 | (sed -e "s/\(.*\)/[watch]: \\1/"); done' > /root/start_watch.sh
RUN echo 'cron & bash /root/prep_git.sh; bash /root/start_watch.sh & bash /root/start_wiki.sh' > /root/start.sh


CMD ["bash", "/root/start.sh"]

EXPOSE 8080
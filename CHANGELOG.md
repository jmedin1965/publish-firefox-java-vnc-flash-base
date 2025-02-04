
# 0.7.1
* Installing bashio from Home Assistant add-on now, so remove from here
* add curl git

# 0.6.5
* wrong location for wheezy-backports

# 0.6.4
* delete /etc/apt/sources.list, and just add my two entries only

# 0.6.3
* need to add bashio source files to this repo

# 0.6.2
* forgot to MKDIR before copy, Docker file

# 0.6.1
* added bashio for home assistant
    * REF: https://github.com/hassio-addons/bashio/
* worked out how to add jq. It's a backport in Wheezy
    * REF: https://unix.stackexchange.com/questions/148605/alternative-for-jq-in-debian-wheezy-to-parse-json-in-bash

# 0.5.1
* Finally extracting git tag into an env variable. I was missing "fetch-depth: 0" from actions/checkout

# 0.4.1
* Changed github action to log in to docker using docker/login-action@v3 instead

# 0.3.1
* Changed github action to log in to docker using docker/login-action@v3 instead

# 0.2.1
* Cheanup Docker file, removed Hove Assistant LABELS

# 0.2.0
* debugging github actions is not easy
* added github actions to
    * auto save tag in repo vars
    * auto build and publish
    * post-commit hook to auto tag from CHANGLOG.md
    * REF: https://www.youtube.com/watch?v=RgZyX-e6W9E
    * REF: https://stackoverflow.com/questions/58177786/get-the-current-pushed-tag-in-github-actions

# 0.1.0
* added novnc to hopefully be able to just connect to a web URL rather than use a vnc client
* added --allow-unauthenticated to apt-get since the gpg key has expired and will never get reniewed
    * This makes updating this image very insecure, but it is coming from debian thugh
* added update-alternatives --force --all --skip-auto
    * REF: https://dev1galaxy.org/viewtopic.php?id=649

# 0.0.0
* first beta version build docker iameg and eventually push to github
* this is the base image I built up a long time ago

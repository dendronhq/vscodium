#!/bin/bash

# FIXME: already have dependencies so skipping. future, want to check for dependencies
#. install_deps.sh
export TRAVIS_OS_NAME=osx
export CI_WINDOWS='False'
export SHOULD_BUILD='yes'
export GITHUB_TOKEN="dummy_token"

# use to resume build
#export SKIP_GET_REPO=yes

echo "`date`: start"
echo "get repo local"
time . get_repo_local.sh
echo "check_tags"
time . check_tags.sh
# TODO: restore
# ./build.sh
echo "`date`: build1..."
time ./build1.sh
echo "`date`: build2..."
time ./build2.sh
# TODO: restore
# ./sign_mac_app_local.sh
echo "`date`: create_zip..."
time ./create_zip.sh
time ./create_dmg.sh
time ./sum.sh

echo "done: `date`"
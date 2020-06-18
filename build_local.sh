#!/bin/bash

# FIXME: already have dependencies so skipping. future, want to check for dependencies
#. install_deps.sh
export TRAVIS_OS_NAME=osx
export CI_WINDOWS='False'
export SHOULD_BUILD='yes'
export GITHUB_TOKEN="dummy_token"

# use to resume build
export SKIP_GET_REPO=yes

echo "start: `date`"
echo "get repo local..."
. get_repo_local.sh
. check_tags.sh
echo "build..."
# TODO: restore
# ./build.sh
./build2.sh
# TODO: restore
# ./sign_mac_app_local.sh
./create_zip.sh
./create_dmg.sh
./sum.sh

echo "done: `date`"
#!/bin/bash

# FIXME: already have dependencies so skipping. future, want to check for dependencies
#. install_deps.sh
export TRAVIS_OS_NAME=osx
export CI_WINDOWS='False'


. get_repo_local.sh
. check_tags.sh
./build.sh
# ./sign_mac_app_local.sh
./create_zip.sh
./create_dmg.sh
./sum.sh

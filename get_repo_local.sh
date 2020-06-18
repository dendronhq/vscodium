#!/bin/bash

if [ -d vscode ]; then
  rm -r vscode
fi

#TODO: don't hardcode
git clone -b dendron-dev /Users/kevinlin/projects/vscode-extension/ref/vscode
cd vscode

export LATEST_MS_COMMIT=$(git rev-list --tags --max-count=1)
export LATEST_MS_TAG=$(git describe --tags ${LATEST_MS_COMMIT})
echo "Got the latest MS tag: ${LATEST_MS_TAG}"
git checkout $LATEST_MS_TAG
cd ..

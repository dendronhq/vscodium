#!/bin/bash

if [ -d vscode ]; then
  cd vscode 
  git fetch --all
else
  git clone -b dendron-dev git@github.com:dendronhq/vscode.git
  cd vscode
fi

export LATEST_MS_COMMIT=$(git rev-list --tags --max-count=1)
export LATEST_MS_TAG=$(git describe --tags ${LATEST_MS_COMMIT})
echo "Got the latest MS tag: ${LATEST_MS_TAG}"
git checkout $LATEST_MS_TAG
cd ..

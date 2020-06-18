#!/bin/bash

if [[ "$SKIP_GET_REPO" == "yes" ]]; then
  echo "skip get_repo..."
else
  echo "get_repo..."
  if [ -d vscode ]; then
    rm -rf vscode
  fi

  #TODO: don't hardcode
  git clone -b dendron-dev /Users/kevinlin/projects/vscode-extension/ref/vscode
fi
cd vscode

export LATEST_MS_COMMIT=$(git rev-list --tags --max-count=1)
export LATEST_MS_TAG=$(git describe --tags ${LATEST_MS_COMMIT})
echo "Got the latest MS tag: ${LATEST_MS_TAG}"

if [[ "$SKIP_GET_REPO" != "yes" ]]; then
  git checkout $LATEST_MS_TAG
fi

cd ..

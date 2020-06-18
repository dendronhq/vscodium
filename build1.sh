#!/bin/bash

function keep_alive_small() {
  while true; do
    echo .
    read -t 60 < /proc/self/fd/1 > /dev/null 2>&1
  done
}

function keep_alive() {
  while true; do
    date
    sleep 60
  done
}

if [[ "$SHOULD_BUILD" == "yes" ]]; then
  export BUILD_SOURCEVERSION=$LATEST_MS_COMMIT
  echo "LATEST_MS_COMMIT: ${LATEST_MS_COMMIT}"
  echo "BUILD_SOURCEVERSION: ${BUILD_SOURCEVERSION}"

  export npm_config_arch="$BUILDARCH"
  export npm_config_target_arch="$BUILDARCH"

  ./prepare_vscode.sh

  cd vscode || exit

  export NODE_ENV=production

  # these tasks are very slow, so using a keep alive to keep travis alive
  if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    keep_alive_small &
  else
    keep_alive &
  fi

  KA_PID=$!

  yarn gulp compile-build
  yarn gulp compile-extensions-build

  kill $KA_PID

  cd ..
fi

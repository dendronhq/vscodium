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

  cd vscode || exit

  export NODE_ENV=production

  yarn gulp minify-vscode

  yarn gulp minify-vscode-reh
  yarn gulp minify-vscode-reh-web

  if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    npm install --global create-dmg
    yarn gulp vscode-darwin-min-ci
    yarn gulp vscode-reh-darwin-min-ci
    yarn gulp vscode-reh-web-darwin-min-ci
  elif [[ "$CI_WINDOWS" == "True" ]]; then
    cp LICENSE.txt LICENSE.rtf # windows build expects rtf license
    yarn gulp "vscode-win32-${BUILDARCH}-min-ci"
    yarn gulp "vscode-reh-win32-${BUILDARCH}-min-ci"
    yarn gulp "vscode-reh-web-win32-${BUILDARCH}-min-ci"
    yarn gulp "vscode-win32-${BUILDARCH}-code-helper"
    yarn gulp "vscode-win32-${BUILDARCH}-inno-updater"
    yarn gulp "vscode-win32-${BUILDARCH}-archive"
    yarn gulp "vscode-win32-${BUILDARCH}-system-setup"
    yarn gulp "vscode-win32-${BUILDARCH}-user-setup"
  else # linux
    yarn gulp vscode-linux-${BUILDARCH}-min-ci
    yarn gulp vscode-reh-linux-${BUILDARCH}-min-ci
    yarn gulp vscode-reh-web-linux-${BUILDARCH}-min-ci

    yarn gulp "vscode-linux-${BUILDARCH}-build-deb"
    if [[ "$BUILDARCH" == "x64" ]]; then
      yarn gulp "vscode-linux-${BUILDARCH}-build-rpm"
    fi
    . ../create_appimage.sh
  fi

  kill $KA_PID

  cd ..
fi
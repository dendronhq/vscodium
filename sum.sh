#!/bin/bash

# shasum blows up in Azure, so using this
# node package which has similar syntax and identical output
if [[ "$CI_WINDOWS" == "True" ]]; then
  npm i -g checksum
fi

sum_file () {
  if [[ -f "$1" ]]; then
    if [[ "$CI_WINDOWS" == "True" ]]; then
      checksum -a sha256 "$1" > "$1".sha256
      checksum -a sha1 "$1" > "$1".sha1
    else
      shasum -a 256 "$1" > "$1".sha256
      shasum "$1" > "$1".sha1
    fi
  fi
}

if [[ "$SHOULD_BUILD" == "yes" ]]; then
  if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    sum_file Dendron-darwin-*.zip
    sum_file Dendron*.dmg
  elif [[ "$CI_WINDOWS" == "True" ]]; then
    sum_file DendronSetup-*.exe
    sum_file DendronUserSetup-*.exe
    sum_file Dendron-win32-*.zip
  else # linux
    cp out/*.AppImage .
    cp vscode/.build/linux/deb/*/deb/*.deb .
    cp vscode/.build/linux/rpm/*/*.rpm .

    sum_file *.AppImage
    sum_file Dendron-linux*.tar.gz
    sum_file *.deb
    sum_file *.rpm
  fi
fi

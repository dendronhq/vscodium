#!/bin/bash
if [[ "$SHOULD_BUILD" == "yes" ]]; then
  if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    cd VSCode-darwin
    create-dmg Dendron.app ..
    mv "../Dendron ${LATEST_MS_TAG}.dmg" "../Dendron.${LATEST_MS_TAG}.dmg"
  fi
  cd ..
fi

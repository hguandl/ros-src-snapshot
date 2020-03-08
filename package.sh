#!/usr/bin/env bash

if [ ${TRAVIS} ]; then
  DEPLOY_NAME="ros-${TRAVIS_TAG}"
else
  DEPLOY_NAME="ros-$(git describe --tags)"
fi

if [ -d src ]; then
  find src -name .DS_Store -delete
  mkdir ${DEPLOY_NAME}
  cp -r src ${DEPLOY_NAME}
  python3 patch.py ${DEPLOY_NAME}/src
  cp build-requirements.txt ${DEPLOY_NAME}/requirements.txt
  tar -cJf ${DEPLOY_NAME}.tar.xz ${DEPLOY_NAME}
  rm -rf ${DEPLOY_NAME}
fi

cp build-requirements.txt requirements-${TRAVIS_TAG}.txt

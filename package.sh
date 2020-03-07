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

if [ -f build-requirements.txt ]; then
  mkdir ${DEPLOY_NAME}_pylib
  pip3 install -r build-requirements.txt --target=${DEPLOY_NAME}_pylib/lib/python3.7
  mv ${DEPLOY_NAME}_pylib/lib/python3.7/bin ${DEPLOY_NAME}_pylib
  tar -cJf ${DEPLOY_NAME}_pylib.tar.xz ${DEPLOY_NAME}_pylib
  rm -rf ${DEPLOY_NAME}_pylib
fi

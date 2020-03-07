#!/usr/bin/env bash

if [ -d src ]; then
  find src -name .DS_Store -delete
  tar cJf src.tar.xz src
fi

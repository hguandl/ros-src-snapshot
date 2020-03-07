#!/usr/bin/env bash

if ! hash virtualenv 2>/dev/null; then
  echo "  virtualenv is required. Please install it by:"
  echo "    pip3 install virtualenv"
  exit 0
fi

if [ ! -d rosdep-venv ]; then
  virtualenv rosdep-venv
  source ./rosdep-venv/bin/activate
  pip3 install -r requirements.txt
fi

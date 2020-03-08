#!/usr/bin/env bash

init_venv() {
  if ! hash virtualenv 2>/dev/null; then
    echo "  virtualenv is required. Please install it by:"
    echo "    pip3 install virtualenv"
    exit 0
  fi

  virtualenv rosdep-venv
  source ./rosdep-venv/bin/activate
  pip3 install -r requirements.txt
}

venv() {
  if [ ! -d rosdep-venv ]; then
    init_venv
  fi
}

sysenv() {
  pip3 install -r requirements.txt
}

if [ $TRAVIS ]; then
  sysenv
else
  venv
fi

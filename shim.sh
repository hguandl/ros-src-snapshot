#!/usr/bin/env bash
echo "yaml https://raw.githubusercontent.com/hguandl/ros-install-osx/master/osx-shim.yaml osx" | \
      sudo tee /etc/ros/rosdep/sources.list.d/00-shim.list

#!/usr/bin/env bash

ROS_DISTRO=${ROS_DISTRO:-melodic}
ROS_CONFIGURATION=${ROS_CONFIGURATION:-desktop_full}

if [ ! $TRAVIS ]; then
  source ./rosdep-venv/bin/activate
fi

if [ ! -d /etc/ros/rosdep/ ]; then
  sudo rosdep init
fi
if [ ! -f /etc/ros/rosdep/sources.list.d/00-shim.list ]; then
  sudo ./shim.sh
fi
rosdep update

rosinstall_generator ${ROS_CONFIGURATION} --rosdistro ${ROS_DISTRO} --deps --tar > ${ROS_DISTRO}-${ROS_CONFIGURATION}.rosinstall

if [ -f src/.rosinstall ]; then
  wstool merge -r -y -t src ${ROS_DISTRO}-${ROS_CONFIGURATION}.rosinstall
  wstool update --delete-changed-uris -t src
else
  wstool init -j$(nproc) src ${ROS_DISTRO}-${ROS_CONFIGURATION}.rosinstall
fi

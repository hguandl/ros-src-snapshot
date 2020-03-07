#!/usr/bin/env bash

ROS_DISTRO=${ROS_DISTRO:-melodic}
ROS_CONFIGURATION=${ROS_CONFIGURATION:-desktop_full}

source ./rosdep-venv/bin/activate

if [ ! -d /etc/ros/rosdep/ ]; then
    sudo rosdep init
fi
if [ ! -f /etc/ros/rosdep/sources.list.d/00-shim.list ]; then
    sudo ./shim
fi
rosdep update

rosinstall_generator ${ROS_CONFIGURATION} --rosdistro ${ROS_DISTRO} --deps --tar > ${ROS_DISTRO}-${ROS_CONFIGURATION}.rosinstall
wstool init -j8 src ${ROS_DISTRO}-${ROS_CONFIGURATION}.rosinstall

tar cJf src.tar.xz src

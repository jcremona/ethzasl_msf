#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

LAUNCH_FILE=$1    # Launch file. Path relative to msf_updates/launch.
docker run -d --net=host -v $CURRENT_DIR:/root/catkin_ws/src/ethzasl_msf/ msf:ros-melodic roslaunch --wait msf_updates $1


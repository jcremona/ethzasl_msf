#!/bin/bash

# Get full directory name of the script no matter where it is being called from
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

docker build -t "msf:ros-melodic" $CURRENT_DIR


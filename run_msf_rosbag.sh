#!/bin/bash
#
# Run MSF, rosbag play, and save trajectory in text files.
# It requires a catkin workspace containing pose_listener.

set -eE # Any subsequent commands which fail will cause the shell script to exit immediately

if [ -z "${CATKIN_WS_DIR}" ] ; then
  CATKIN_WS_DIR=$HOME/catkin_ws/
fi

# Get full directory name of the script no matter where it is being called from
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

function echoUsage()
{
    echo -e "Usage: <THIS_SCRIPT> [FLAG] ROSBAG\n\
            \t -r run VO system in a detached docker container \n\
            \t -h help" >&2
}

RUN_CONTAINER=0
OUTPUT_DIR=$CURRENT_DIR/output/$(date '+%Y%m%d_%H%M%S')

while getopts "hc:r" opt; do
    case "$opt" in
        h)  echoUsage
            exit 0
            ;;
        r)  RUN_CONTAINER=1
            ;;
        c)  case $OPTARG in
                -*) echo "ERROR: a path to output file must be provided"; echoUsage; exit 1 ;;
                *) CONFIG_FILE=$OPTARG ;;
            esac
            ;;

        *)
            echoUsage
            exit 1
            ;;
    esac
done

shift $((OPTIND -1))
BAG=$1

. $CONFIG_FILE

function cleanup() {
  if [ -n "${VO_CID}" ] ; then
    printf "\e[31m%s %s\e[m\n" "VO Cleaning"
    docker stop $VO_CID > /dev/null
    docker logs $VO_CID > $OUTPUT_DIR/vo_log.txt
    docker rm $VO_CID > /dev/null
    unset VO_CID
  fi
  if [ -n "${MSF_CID}" ] ; then
    printf "\e[31m%s %s\e[m\n" "MSF Cleaning"
    docker stop $MSF_CID > /dev/null
    docker logs $MSF_CID > $OUTPUT_DIR/msf_log.txt
    docker rm $MSF_CID > /dev/null
    unset MSF_CID
  fi
}

trap cleanup INT
trap cleanup ERR

function wait_docker() {
    TOPIC=$1
    attempts=0
    max_attempts=30
    output=$(rostopic list $TOPIC 2> /dev/null || :) # force the command to exit successfully (i.e. $? == 0) to avoid trap
    while [ "$attempts" -lt "$max_attempts" ] && [ "$output" != $TOPIC ]; do
        sleep 1
        output=$(rostopic list $TOPIC 2> /dev/null || :)
        attempts=$(( attempts + 1 ))
    done
    if [ "$attempts" -eq "$max_attempts" ] ; then
        echo "ERROR: System seems not to start"
        cleanup
        exit 1
    fi
}

mkdir -p $OUTPUT_DIR
source /opt/ros/$ROS_DISTRO/setup.bash

if [ $RUN_CONTAINER -eq 1 ] ; then
    echo "Starting VO method container (detached mode)"
    VO_CID=$($VO_METHOD_DIR/run.sh -v detached -l $VO_LAUNCH_FILE)
fi

wait_docker $VO_OUTPUT_TOPIC
echo "VO Running...."


echo "Starting MSF docker container (detached mode)"
MSF_CID=$($CURRENT_DIR/docker_run.sh $MSF_LAUNCH_FILE)

wait_docker "/msf_core/odometry"
echo "MSF Running...."

source ${CATKIN_WS_DIR}/devel/setup.bash
roslaunch $CURRENT_DIR/launch/play_bag.launch \
    vo_type:=$VO_OUTPUT_TYPE \
    vo_topic:=$VO_OUTPUT_TOPIC \
    save_to_file:=true \
    vo_output_file:="$OUTPUT_DIR/vo_trajectory.txt" \
    msf_odom_output_file:="$OUTPUT_DIR/msf_odom_trajectory.txt" \
    msf_pose_after_upd_output_file:="$OUTPUT_DIR/msf_after_upd_trajectory.txt" \
    bagfile:=$BAG

cleanup
echo "END"


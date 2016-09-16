#!/usr/bin/env bash

# Now relying on --net host instead, uncomment this to do auto discovery of private IP:
#HOST_IP=$(ip route | awk '/docker0/ { print $NF }')
#HOSTNAME=$(hostname)

if [[ "$(docker images -q francoisferland/hbba 2> /dev/null)" == "" ]]; then
    echo "!!! Unable to find francoisferland/hbba, see README.md in hbba_docker for details."
    exit 1
fi

# If ROS_HOSTNAME is unset, set it default (hostname). Simply avoids warning messages when starting nodes.
if [[ $ROS_HOSTNAME == "" ]]; then
    ROS_HOSTNAME=$(hostname)
fi
    
docker run --net host -e ROS_HOSTNAME=$ROS_HOSTNAME -e ROS_MASTER_URI=$ROS_MASTER_URI francoisferland/hbba:ortools-latest roslaunch hbba_synth base_nodes_r2.launch

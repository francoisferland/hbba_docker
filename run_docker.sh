#!/usr/bin/env bash

HOST_IP=$(ip route | awk '/docker0/ { print $NF }')
HOSTNAME=$(hostname)

docker run --net host -e ROS_HOSTNAME=$ROS_HOSTNAME -e ROS_MASTER_URI=$ROS_MASTER_URI francoisferland/hbba roslaunch hbba_synth base_nodes_r2.launch

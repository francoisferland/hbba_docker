#!/bin/bash

set -e

source /opt/ros/indigo/setup.bash
source /hbba_ws/devel/setup.bash

echo "ROS_HOSTNAME: $ROS_HOSTNAME"
echo "Will try to connect to master at $ROS_MASTER_URI ..."

# NOTE: Disabled IP discovery, now expects ROS_MASTER_URI and ROS_HOSTNAME to
#       be set, and the default run scripts starts the container on the same
#       network as the host (--net host).
# Get container and host IP, use this as ROS hostname and master.
# OWN_IP=$(awk 'NR==1 {print $1}' /etc/hosts)
# HOST_IP=$(/sbin/ip route | awk '/default/ { print $3 }')
# export ROS_MASTER_URI=http://$HOST_IP:11311/
# export ROS_HOSTNAME=$OWN_IP

exec "$@"

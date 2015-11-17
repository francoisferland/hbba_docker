#!/bin/bash

set -e

source /opt/ros/indigo/setup.bash
source /hbba_ws/devel/setup.bash

# Get container and host IP, use this as ROS hostname and master.
OWN_IP=$(awk 'NR==1 {print $1}' /etc/hosts)
HOST_IP=$(/sbin/ip route | awk '/default/ { print $3 }')
export ROS_MASTER_URI=http://$HOST_IP:11311/
export ROS_HOSTNAME=$OWN_IP

exec "$@"

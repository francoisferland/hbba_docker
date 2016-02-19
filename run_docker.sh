#!/usr/bin/env bash

HOST_IP=$(ip route | awk '/docker0/ { print $NF }')
HOSTNAME=$(hostname)

docker run --add-host=$HOSTNAME:$HOST_IP francoisferland/hbba roslaunch hbba_synth base_nodes_r2.launch

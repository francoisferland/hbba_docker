#!/usr/bin/env bash

CID=$(docker run -d hbba_docker roslaunch hbba_synth base_nodes_r2.launch)

IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CID)

export ROS_MASTER_URI=http://$IP:11311/
echo "ROS_MASTER: $ROS_MASTER_URI, waiting two seconds..."
sleep 2

rostopic list



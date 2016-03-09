Docker config for HBBA running on ROS Indigo / Ubuntu 14.04.

To get a pre-built image, just use:

  docker pull francoisferland/hbba

To run, use the run_docker.sh script, which relies on the pre-built image and
starts the base HBBA nodes.
Normally, the model config should already be present on the master (see
hbba_synth for tools on how to generate these configurations).

The script runs the container on the same network as the docker host, and relay
the ROS_MASTER_URI content so the nodes know where to connect.

To build locally, use the build_docker.sh script.


Docker config for HBBA running on ROS Indigo / Ubuntu 14.04.

On Ubuntu, Docker can be installed with:

    sudo apt-get install docker.io

You then need to add your user to the 'docker' group to access the container
manager.

To get a pre-built image of HBBA, just use:

  docker pull francoisferland/hbba

To run, use the run_docker.sh script, which relies on the pre-built image and
starts the base HBBA nodes.
Normally, the model config should already be present on the master (see
hbba_synth for tools on how to generate these configurations).

The script runs the container on the same network as the docker host, and relay
the ROS_MASTER_URI content so the nodes know where to connect.

If you need to build it locally (which is optional), use the build_docker.sh
script.

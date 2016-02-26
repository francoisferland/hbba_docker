Docker config for HBBA running on ROS Indigo / Ubuntu 14.04.

On Ubuntu, Docker can be installed with:

    sudo apt-get install docker.io

You then need to add your user to the 'docker' group to access the container
manager.

The image is available on Docker Hub as francoisferland/hbba.
To obtain it, just use:

    docker pull francoisferland/hbba

To re-build, use the build_docker.sh script.

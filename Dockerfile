# Docker image for HBBA and ROS Indigo
FROM ros:indigo

# To suppress error messages about the lack of term:
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Dependencies for or-tools and HBBA:
RUN apt-get update && apt-get install -y \
    autoconf            \
    bison               \
    curl                \
    flex                \
    g++                 \
    gawk                \
    gettext             \
    libtool             \
    libv8-dev           \
    make                \
    python-dev          \
    python-setuptools   \
    subversion          \
    texinfo             \
    texlive             \
    zlib1g-dev          

# Additional deps (to avoid re-running the above):
RUN apt-get install -y ros-indigo-tf
RUN apt-get install -y patch
RUN apt-get install -y help2man
RUN apt-get install -y libyaml-cpp-dev

# ROS Workspace setup for HBBA build
RUN mkdir -p /hbba_ws/src
RUN cd /hbba_ws/src; /ros_entrypoint.sh catkin_init_workspace
# Needed to generate the correct environment setup file
RUN sync; /ros_entrypoint.sh catkin_make -C /hbba_ws
# Will eventually clone a specific tag
RUN git clone --branch base_split https://github.com/francoisferland/HBBA.git /hbba_ws/src/hbba
RUN cd /hbba_ws/src/hbba; git submodule init; git submodule update

# Building, can take a while because of or-tools
COPY build_env.sh /build_env.sh
RUN sync; /build_env.sh catkin_make -C /hbba_ws

# Run environment (almost the same as build, plus hostname and ROS master
# setup).
COPY hbba_env.sh /hbba_env.sh
RUN sync

ENTRYPOINT ["/hbba_env.sh"]
#CMD ["bash"]

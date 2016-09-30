# Docker image for HBBA and ROS Indigo
FROM ros:indigo

# ENV http_proxy  http://147.250.1.2:8080/
# ENV https_proxy https://147.250.1.2:8080/

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
    unzip               \
    zlib1g-dev          \
    ros-indigo-tf       \
    patch               \
    help2man            \
    libyaml-cpp-dev     \
    ros-indigo-move-base-msgs

# For ENSTA proxy (again):
# RUN echo "http-proxy-host = proxy.ensta.fr" | cat >> /etc/subversion/servers
# RUN echo "http-proxy-port = 8080" | cat >> /etc/subversion/servers

# ROS Workspace setup for HBBA build
#
RUN ls
RUN mkdir -p /hbba_ws/src
RUN git config --global http.sslVerify false
# Will eventually clone a specific tag
RUN git clone https://github.com/francoisferland/HBBA.git /hbba_ws/src/hbba
RUN sync; cd /hbba_ws/src/hbba; git submodule init; git submodule update
RUN cd /hbba_ws/src; /ros_entrypoint.sh catkin_init_workspace

# Building, can take a while because of or-tools
COPY build_env.sh /build_env.sh
# Bootstrapping:
RUN sync; /ros_entrypoint.sh catkin_make -C /hbba_ws --pkg hbba_synth
RUN sync; /build_env.sh catkin_make -C /hbba_ws 

# Run environment (almost the same as build, plus hostname and ROS master
# setup).
COPY hbba_env.sh /hbba_env.sh
RUN sync

ENTRYPOINT ["/hbba_env.sh"]
#CMD ["bash"]

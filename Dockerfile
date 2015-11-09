# Docker image for HBBA and ROS Indigo
FROM ros:indigo

ENV http_proxy  http://147.250.1.2:8080/
ENV https_proxy https://147.250.1.2:8080/

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


# For ENSTA proxy (again):
RUN echo "http-proxy-host = proxy.ensta.fr" | cat >> /etc/subversion/servers
RUN echo "http-proxy-port = 8080" | cat >> /etc/subversion/servers

RUN cat /etc/subversion/servers
RUN svn co svn://vcs.exim.org/pcre/code/trunk /tmp/pcre


# ROS Workspace setup for HBBA build
RUN mkdir -p /hbba_ws/src
RUN cd /hbba_ws/src; /ros_entrypoint.sh catkin_init_workspace
# Needed to generate the correct environment setup file
RUN /ros_entrypoint.sh catkin_make -C /hbba_ws
# Will eventually clone a specific tag
RUN git clone --branch master https://github.com/francoisferland/HBBA.git /hbba_ws/src/hbba


# Building, can take a while because of or-tools
COPY hbba_env.sh /hbba_env.sh
RUN /hbba_env.sh catkin_make -C /hbba_ws

# Test only!
CMD [ "pwd" ]

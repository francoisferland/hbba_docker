#!/bin/bash

set -e

# source /opt/ros/indigo/setup.bash
source /hbba_ws/devel/setup.bash

exec "$@"

#!/bin/bash
# Start the DOFBOT Docker container

# Enable X11 for GUI apps
xhost +local:docker

# Check if container exists
if [ "$(docker ps -a -q -f name=dofbot_container)" ]; then
    echo "Starting existing container..."
    docker start -i dofbot_container
else
    echo "Creating new container..."
    docker run -it --privileged \
      --name dofbot_container \
      --network host \
      --env="DISPLAY" \
      --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
      -v ~/yahboom_backup:/root/yahboom_backup \
      -v ~/dofbot-jetson-orin-setup/scripts:/root/scripts \
      -v ~/dofbot-jetson-orin-setup/examples:/root/examples \
      -v /dev:/dev \
      dofbot_ros bash
fi

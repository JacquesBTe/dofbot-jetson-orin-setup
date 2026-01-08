FROM ros:noetic-robot

# Install dependencies
RUN apt-get update && apt-get install -y \
    ros-noetic-moveit \
    ros-noetic-moveit-visual-tools \
    ros-noetic-joint-state-publisher \
    ros-noetic-robot-state-publisher \
    python3-pip \
    python3-opencv \
    python3-yaml \
    python3-serial \
    i2c-tools \
    usbutils \
    net-tools \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip3 install smbus2 opencv-python pyserial Jetson.GPIO pygame

# Setup workspace
RUN mkdir -p /root/catkin_ws/src
WORKDIR /root/catkin_ws

# Source ROS
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN echo "if [ -f /root/catkin_ws/devel/setup.bash ]; then source /root/catkin_ws/devel/setup.bash; fi" >> ~/.bashrc

CMD ["/bin/bash"]

FROM ros:humble-ros-base

# Install common ROS 2 packages used by the project
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    python3-colcon-common-extensions \
    ros-humble-rosbridge-suite \
    ros-humble-nav2-bringup \
    ros-humble-robot-localization \
    ros-humble-foxglove-bridge \
    ros-humble-nmea-navsat-driver \
    ros-humble-rtabmap-ros \
    ros-humble-ros2-control \
    ros-humble-ros2-controllers \
    ros-humble-diff-drive-controller \
    && rm -rf /var/lib/apt/lists/*

# Create workspace
RUN mkdir -p /ros2_ws/src
WORKDIR /ros2_ws

# Fetch odrive_ros2_control package for motor control
RUN git clone --depth 1 https://github.com/Factor-Robotics/odrive_ros2_control.git src/odrive_ros2_control

# Install ROS dependencies and build the workspace
RUN apt-get update && \
    . /opt/ros/humble/setup.sh && \
    rosdep update && \
    rosdep install --from-paths src --ignore-src -r -y && \
    colcon build --symlink-install && \
    rm -rf /var/lib/apt/lists/*

# Default command keeps the container running
CMD ["bash"]

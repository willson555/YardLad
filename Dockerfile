FROM osrf/ros:humble-ros-base

# Install common ROS 2 packages used by the project
RUN apt-get update && apt-get install -y \
    ros-humble-rosbridge-suite \
    ros-humble-nav2-bringup \
    ros-humble-robot-localization \
    ros-humble-foxglove-bridge \
    ros-humble-nmea-navsat-driver \
    && rm -rf /var/lib/apt/lists/*

# Create workspace
RUN mkdir -p /ros2_ws/src
WORKDIR /ros2_ws

# Default command keeps the container running
CMD ["bash"]

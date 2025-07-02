# YardLad
A general use yard bot, starting with a small flail mower config.

## Setup
The repository uses Docker to run ROS 2 and a small web interface. Run `./setup.sh` to
install Docker, build the images and start the containers. The script prompts for
each step or you can pass flags like `--install`, `--build` and `--up`.

### Containers
- **ros** – Provides a ROS 2 Humble environment with common packages preinstalled.
  The ROS workspace lives in `ros2_ws/`.
- **web** – Simple Nginx server that serves files from `web/` on port `8080`.

### Directory structure
- `ros2_ws/` – ROS 2 workspace. Place your packages under `ros2_ws/src`.
- `web/` – Static web content shown by the web container.
- `docker-compose.yml` – Defines the containers used by the project.
- `Dockerfile` – Builds the ROS 2 image used by `docker-compose`.

The Docker image installs all ROS 2 packages listed in the Software section
and automatically clones and builds `odrive_ros2_control` inside the
workspace so the hardware drivers are available. The packages installed
by apt during the image build are:

```
ros-humble-rosbridge-suite
ros-humble-nav2-bringup
ros-humble-robot-localization
ros-humble-foxglove-bridge
ros-humble-nmea-navsat-driver
ros-humble-rtabmap-ros
ros-humble-ros2-control
ros-humble-ros2-controllers
ros-humble-diff-drive-controller
```

Run `docker-compose up` (or use `./setup.sh --up`) to start the system.


## Hardware
- Raspberry Pi CM5 Board, mounted in a CM4 Maker Board
- SimpleRTK2b configured as a rover long range according to simple rtk config file. Connected via USB
- Odrive 3.6 Connected and calibrated to 2 hoverboard motors with hall effect feedback Connected via USB
- Adafruit 9-DOF Absolute Orientation IMU Fusion Breakout - BNO055 - STEMMA QT / Qwiic Connected through I2C

## Software
- Raspberry Pi OS Debian Bookworm
- Docker
- Use SQLite to store setting and other data
- ROS 2 Humble running in a docker container
  - rtabmap_ros -- for real time positioning and mapping
  - odrive_ros2_control -- to control odrive 3.6
  - ros2_controllers -- for controlling the motors
  - diff_drive_controller -- for differential drive kinematics
  - robot_localization -- for imu and gps sensor fusion
  - nmea_navsat_driver -- Converts NMEA GPS data into ROS 2 topics for easier integration
  - nav2 -- for unplanned path making
  - rosbridge_suite -- Enables WebSocket-based communication between ROS2 and the web server
  - foxglove_bridge -- Allows visualization of ROS 2 data (maps, GPS, logs) on the web
- Watchdog timers to detect and reset system if it goes unresponsive
- have a log of any errors for ROS2, GPS, or linux
- Automatic log system where log's are kept for 90 days, then are deleted
- Allow a usb or bluetooth xbox type controller to be connected to manually move rover
- Rover should be able to be driven with a controller to set new boundry zones, and a path to follow
- Host a web server on the raspberry pi with the abality to go to webmower.com to see its web page
- System wide monitoring with Grafana
- Everywhere should start as a no-go zone until a route is created
- The pi should display a ROS 2 map in the web page, which displays --
  - Current gps rover location
  - Current gps base location
  - Current gps No-Go-Zones
  - Current gps path to follow


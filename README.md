# YardLad
A general use yard bot, starting with a small flail mower config. 







  Hardware:
	-Raspberry Pi CM5 Board, mounted in a CM4 Maker Board
	-SimpleRTK2b configured as a rover long range according to simple rtk config file. Connected via USB
	-Odrive 3.6 Connected and calibrated to 2 hoverboard motors with hall effect feedback Connected via USB
	-Adafruit 9-DOF Absolute Orientation IMU Fusion Breakout - BNO055 - STEMMA QT / Qwiic Connected through I2C
	




  Software:
	-Raspberry Pi OS Debian Bookworm
	-Docker
	-Use SQLite to store setting and other data
	-ROS 2 Humble running in a docker container
	  -rtabmap_ros -- for real time positioning and mapping
	  -odrive_ros2_control -- to control odrive 3.6
	  -ros2_controllers -- for controlling the motors
	  -diff_drive_controller -- for differential drive kinematics
	  -robot_localization -- for imu and gps sensor fusion
	  -nmea_navsat_driver -- Converts NMEA GPS data into ROS 2 topics for easier integration
	  -nav2 -- for unplanned path making
	  -rosbridge_suite -- Enables WebSocket-based communication between ROS 2 and the web server
	  -foxglove_bridge -- Allows visualization of ROS 2 data (maps, GPS, logs) on the web
	-Watchdog timers to detect and reset system if it goes unresponsive
	-have a log of any errors for ROS2, GPS, or linux
	-Automatic log system where log's are kept for 90 days, then are deleted
	-Allow a usb or bluetooth xbox type controller to be connected to manually move rover
	-Rover should be able to be driven with a controller to set new boundry zones, and a path to follow
	-Host a web server on the raspberry pi with the abality to go to webmower.com to see its web page
	-System wide monitoring with Grafana
	-Everywhere should start as a no-go zone until a route is created
	-The pi should display a ROS 2 map in the web page, which displays --
	  -Current gps rover location
	  -Current gps base location
	  -Current gps No-Go-Zones
	  -Current gps path to follow
	

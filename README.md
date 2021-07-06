ethzasl_msf
=====================
**ORIGINAL README**: see [Original README](README.orig.md)

The Ethzasl MSF Framework stack is a multi-sensor fusion (msf) framework based on an Extended Kalman Filter (EKF). Multi sensor refers to one or more update sensors and the IMU as a fixed prediction sensor. The framework is essentially divided into the two EKF steps prediction and update. The prediction is made based on the system model (i.e. differential equations) and IMU readings. 

## Run VIO/VI-SLAM System as pose sensor
The following command will run MSF with ORB-SLAM3 as a pose sensor:
```
./run_msf_rosbag.sh -c config/orbslam3_euroc.launch -r <EUROC_ROSBAG_PATH>
```
### Results
See `results/` folder.

## TODO
* VO_OUTPUT_TOPIC should be set in only one place. Use `vio_gps_rosario.launch` instead of individual files.
Modify `docker_run.sh` and `config/*` files properly.

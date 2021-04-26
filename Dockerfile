FROM ros:melodic-perception

ENV CATKIN_WS=/root/catkin_ws
WORKDIR $CATKIN_WS

RUN apt-get update && \
    apt-get install -y autoconf build-essential libtool && \
    rm -rf /var/lib/apt/lists/* && \
    git clone https://github.com/catkin/catkin_simple.git $CATKIN_WS/src/catkin_simple && \
    git clone https://github.com/ethz-asl/glog_catkin.git $CATKIN_WS/src/glog_catkin && \
    /bin/bash -c ". /opt/ros/melodic/setup.bash && catkin_make" 

#RUN git clone https://github.com/ethz-asl/ethzasl_msf.git $CATKIN_WS/src/ethzasl_msf 

COPY ./ $CATKIN_WS/src/ethzasl_msf 

RUN ["/bin/bash", "-c", ". /opt/ros/melodic/setup.bash && catkin_make"]


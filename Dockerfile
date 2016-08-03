# Copyright 2015 bradley childs, All rights reserved.
#

FROM ubuntu:14.04


ENV SCRIPT http://github.com/lavvy/job/raw/build.sh

MAINTAINER lavvy , lavashonline@gmail.com
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
 automake \
 curl wget git sshpass \
 build-essential \
 libfuse-dev libcurl4-openssl-dev \
 libtool \
 libxml2-dev mime-support 
 


RUN mkdir -p /root
WORKDIR /root
RUN echo $'#!/bin/sh\n \

           curl -s -L ${SCRIPT} | bash' > /root/run.sh 
           
RUN chmod 600 /root/run.sh

ENTRYPOINT ["/root/run.sh"]
# CMD ["--help"]
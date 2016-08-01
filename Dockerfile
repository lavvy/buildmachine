# Copyright 2015 bradley childs, All rights reserved.
#

FROM ubuntu:14.04


ENV script http://github.com/lavvy/job/raw/build.sh

MAINTAINER lavvy , lavashonline@gmail.com
RUN apt-get update -y ; apt-get install automake fuse-devel gcc-c++ git libcurl-devel sshpasss libxml2-devel make openssl-devel -y
RUN mkdir -p /root
WORKDIR /root
RUN echo $'#!/bin/sh\n \
           echo $S3User:$S3Secret > /etc/passwd-s3fs\n \
           chmod 600 /etc/passwd-s3fs\n \
           exec s3fs "$@"' > /root/s3fs.sh 
RUN chmod +x /root/s3fs.sh

ENTRYPOINT ["/root/s3fs.sh"]
# CMD ["--help"]
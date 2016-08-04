# Copyright 2015 lavvy lab, All rights reserved.

FROM ubuntu:14.04.4
MAINTAINER lavvy , lavashonline@gmail.com
ENV SCRIPT http://github.com/lavvy/job/raw/build.sh
ENV HTTP_DOCUMENTROOT /home

#install needed applications
RUN apt-get update && \
     apt-get install --no-install-recommends -y \
     arptables \
     bridge-utils \
     ca-certificates \
     curl \
     iptables \
     libssl-dev \
     libffi-dev \
     gcc \
     make \
     conntrack \
     libaio1 \
     fio
# install docker
RUN curl -fsSL https://get.docker.com/ | sh

RUN mkdir -p /root
WORKDIR /root

#run your custom script
RUN echo '#!/bin/sh\n \
set -e\n \
[ "$DEBUG" == "1" ] && set -x && set +e\n \
sleep 5\n \
if [ ! -e ${HTTP_DOCUMENTROOT}/index.php ]; then\n \
curl -s -L ${SCRIPT} | bash\n \
fi' > /root/run.sh

           
RUN chmod +x /root/run.sh
ENTRYPOINT ["/root/run.sh"]

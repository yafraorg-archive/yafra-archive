#
#  Copyright 2015 yafra.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

#
# yafra.org Python / Apache2 docker image
#

# source is yafra ubuntu
FROM yafraorg/docker-yafrabase

MAINTAINER Martin Weber <info@yafra.org>

RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
  echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list && \
  apt-get update && \
  curl -sL https://deb.nodesource.com/setup | sudo bash - && \
  curl -sL https://deb.nodesource.com/setup | sudo bash - && \
  apt-get install -y apache2 apache2-mpm-prefork apache2-utils libapache2-mod-wsgi && \
  apt-get install -y python-dev python-pip python3-dev python3-pip && \
  apt-get install -y nodejs mongodb-org-shell && \
  apt-get autoremove -yq && \
  apt-get clean all && \
  rm -rf /var/lib/apt/lists/*

# change default port of apache
RUN sed -i "/Listen/s/80/8081/" /etc/apache2/ports.conf

# Install apache wsgi
RUN a2enmod wsgi

RUN cd /work/repos && \
  git clone https://github.com/yafraorg/yafra-python.git && \
  git clone https://github.com/yafraorg/yafra-database.git

COPY run-docker.sh /work/run-docker.sh
RUN cd /work && \
  chmod 755 run-docker.sh

WORKDIR /work

EXPOSE 8081
EXPOSE 8082

CMD ["/work/run-docker.sh"]

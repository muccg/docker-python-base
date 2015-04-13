FROM muccg/centos6-base:latest
MAINTAINER ccg <devops@ccg.murdoch.edu.au>

RUN yum install -y \
  gcc \
  gcc-c++ \
  make \
  openssl-devel \
  python27 \
  python27-devel \
  python27-pip \
  python27-virtualenv \
  && yum clean all

RUN pip2.7 install -U pip && pip2.7 --version

ENV BUILD_HOST_FILE /data/build_host.txt
ENV PIP_CONF_DIR /root/.config/pip

CMD /bin/sh

# Determine build host
ONBUILD RUN netstat -nr | grep '^0\.0\.0\.0' | awk '{print $2}' > ${BUILD_HOST_FILE}

# devpi if available
ONBUILD RUN curl -v -I -H "HEAD /" `cat ${BUILD_HOST_FILE}`:3141 | grep Devpi \
  && mkdir -p ${PIP_CONF_DIR} \
  && (echo "[global]" > ${PIP_CONF_DIR}/pip.conf) \
  && (echo "timeout = 60" >> ${PIP_CONF_DIR}/pip.conf) \
  && (echo "index-url = http://$(cat ${BUILD_HOST_FILE}):3141/root/pypi/" >> ${PIP_CONF_DIR}/pip.conf) \
  && (echo "trusted-host = $(cat ${BUILD_HOST_FILE})" >> ${PIP_CONF_DIR}/pip.conf) \
  && (echo "no-cache-dir = true" >> ${PIP_CONF_DIR}/pip.conf) \
  && (echo "cache-dir = none" >> ${PIP_CONF_DIR}/pip.conf) \
  || echo "No devpi detected on docker host"

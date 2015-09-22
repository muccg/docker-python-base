FROM muccg/centos7-base:latest
MAINTAINER https://github.com/muccg

RUN yum install -y \
  gcc \
  gcc-c++ \
  make \
  libffi-devel \
  openssl-devel \
  python \
  python-devel \
  python-pip \
  python-virtualenv \
  && yum clean all

RUN pip install -U pip && pip --version

# Attempt to avoid https://github.com/pypa/pip/issues/2753
#RUN pip install -U requests[security]

ENV BUILD_HOST_FILE /data/build_host.txt
ENV YUM_CONF /etc/yum.conf
ENV PIP_CONF_DIR /root/.config/pip

CMD /bin/sh

# Determine build host
ONBUILD RUN netstat -nr | grep '^0\.0\.0\.0' | awk '{print $2}' > ${BUILD_HOST_FILE}

# squid proxy if available
ONBUILD RUN curl -v -I -H "HEAD /" `cat ${BUILD_HOST_FILE}`:3128 | grep squid-deb-proxy \
  && (echo "proxy=http://$(cat ${BUILD_HOST_FILE}):3128" >> ${YUM_CONF}) \
  || echo "No squid-deb-proxy detected on docker host"

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

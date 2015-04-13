FROM muccg/debian8-base:latest
MAINTAINER ccg <devops@ccg.murdoch.edu.au>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  python2.7 \
  python2.7-dev \
  python-setuptools \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN easy_install pip \
  && pip install virtualenv \
  && pip --version \ 
  && virtualenv --version

RUN env --unset=DEBIAN_FRONTEND

ENV BUILD_HOST_FILE /data/build_host.txt
ENV APT_PROXY_CONF /etc/apt/apt.conf.d/30proxy
ENV PIP_CONF_DIR /root/.config/pip

CMD /bin/sh

# Determine build host
ONBUILD RUN netstat -nr | grep '^0\.0\.0\.0' | awk '{print $2}' > ${BUILD_HOST_FILE}

# squid proxy if available
ONBUILD RUN echo -en "HEAD /\n\n\n" | nc -q -1 -n -v `cat ${BUILD_HOST_FILE}` 3128 | grep squid-deb-proxy \
  && (echo "Acquire::http::Proxy \"http://$(cat ${BUILD_HOST_FILE}):3128\";" > ${APT_PROXY_CONF}) \
  && (echo "Acquire::http::Proxy::ppa.launchpad.net DIRECT;" >> ${APT_PROXY_CONF}) \
  || echo "No squid-deb-proxy detected on docker host"

# devpi if available
ONBUILD RUN echo -en "HEAD /\n\n\n" | nc -q -1 -n -v `cat ${BUILD_HOST_FILE}` 3141 | grep Devpi \
  && mkdir -p ${PIP_CONF_DIR} \
  && (echo "[global]" > ${PIP_CONF_DIR}/pip.conf) \
  && (echo "timeout = 60" >> ${PIP_CONF_DIR}/pip.conf) \
  && (echo "index-url = http://$(cat ${BUILD_HOST_FILE}):3141/root/pypi/" >> ${PIP_CONF_DIR}/pip.conf) \
  && (echo "trusted-host = $(cat ${BUILD_HOST_FILE})" >> ${PIP_CONF_DIR}/pip.conf) \
  && (echo "no-cache-dir = true" >> ${PIP_CONF_DIR}/pip.conf) \
  && (echo "cache-dir = none" >> ${PIP_CONF_DIR}/pip.conf) \
  || echo "No devpi detected on docker host"

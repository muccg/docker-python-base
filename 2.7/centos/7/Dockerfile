FROM muccg/centos7-base:latest
MAINTAINER https://github.com/muccg

ARG PIP_INDEX_URL=https://pypi.python.org/simple/
ARG PIP_TRUSTED_HOST=127.0.0.1

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

RUN NO_PROXY=$PIP_TRUSTED_HOST pip2.7 --trusted-host $PIP_TRUSTED_HOST install -i $PIP_INDEX_URL --upgrade \
  pip \
  && pip2.7 --version

CMD /bin/sh

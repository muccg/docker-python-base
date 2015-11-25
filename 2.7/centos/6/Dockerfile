FROM muccg/centos6-base:latest
MAINTAINER https://github.com/muccg

ARG PIP_INDEX_URL=https://pypi.python.org/simple/
ARG PIP_TRUSTED_HOST=127.0.0.1

RUN yum install -y \
  gcc \
  gcc-c++ \
  make \
  libffi-devel \
  openssl-devel \
  python27 \
  python27-devel \
  python27-pip \
  python27-virtualenv \
  && yum clean all

RUN NO_PROXY=$PIP_TRUSTED_HOST pip2.7 --trusted-host $PIP_TRUSTED_HOST install -i $PIP_INDEX_URL --upgrade \
  pip \
  && pip2.7 --version

# Attempt to avoid https://github.com/pypa/pip/issues/2753
#RUN pip install -U requests[security]

CMD /bin/sh

# Image tag muccg/python-base:debian8-3.4
FROM muccg/debian8-base:latest
MAINTAINER https://github.com/muccg

ARG PIP_INDEX_URL=https://pypi.python.org/simple/
ARG PIP_TRUSTED_HOST=127.0.0.1

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  python3 \
  python3-dev \
  python3-setuptools \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN env --unset=DEBIAN_FRONTEND

RUN easy_install-3.4 pip \
  && NO_PROXY=$PIP_TRUSTED_HOST pip3 --trusted-host $PIP_TRUSTED_HOST install -i $PIP_INDEX_URL --upgrade \
  virtualenv \
  && pip3 --version \
  && virtualenv --version

CMD /bin/sh

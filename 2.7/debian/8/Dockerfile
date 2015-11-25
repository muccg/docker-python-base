FROM muccg/debian8-base:latest
MAINTAINER https://github.com/muccg

ARG PIP_INDEX_URL=https://pypi.python.org/simple/
ARG PIP_TRUSTED_HOST=127.0.0.1

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  libffi-dev \
  libssl-dev \
  python2.7 \
  python2.7-dev \
  python-setuptools \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN easy_install pip \
  && NO_PROXY=$PIP_TRUSTED_HOST pip --trusted-host $PIP_TRUSTED_HOST install -i $PIP_INDEX_URL --upgrade \
  virtualenv \
  && pip --version \ 
  && virtualenv --version

RUN env --unset=DEBIAN_FRONTEND

CMD /bin/sh

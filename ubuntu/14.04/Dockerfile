FROM muccg/base:ubuntu14.04
MAINTAINER ccg <ccgdevops@googlegroups.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
  python2.7 \
  python2.7-dev \
  python-pip \
  python-virtualenv \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install -U pip

RUN env --unset=DEBIAN_FRONTEND

CMD /bin/sh

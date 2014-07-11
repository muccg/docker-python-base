FROM muccg/puppet-base:ubuntu14.04
MAINTAINER ccg <ccgdevops@googlegroups.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update -q
RUN apt-get install -y python2.7 python2.7-dev python-pip 
RUN pip install -U pip
RUN pip install -U virtualenv

RUN env --unset=DEBIAN_FRONTEND

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

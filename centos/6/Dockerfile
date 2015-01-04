FROM muccg/base:centos6
MAINTAINER ccg <ccgdevops@googlegroups.com>

RUN yum install -y \
  python27 \
  python27-devel \
  python27-pip
RUN pip2.7 install -U pip
RUN pip2.7 --version

RUN yum clean all

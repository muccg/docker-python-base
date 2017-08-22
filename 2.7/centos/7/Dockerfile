FROM centos:centos7
LABEL maintainer "https://github.com/muccg/"

ENV VIRTUAL_ENV /env
ENV PYTHON_PIP_VERSION 9.0.1
ENV PIP_NO_CACHE_DIR="off"

RUN yum -y update && yum -y install \
    epel-release \
    http://dl.iuscommunity.org/pub/ius/stable/CentOS/7/x86_64/ius-release-1.0-14.ius.centos7.noarch.rpm \
    http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-3.noarch.rpm \
    && yum clean all

RUN yum -y install \
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

# install "virtualenv", since the vast majority of users of this image will want it
# create a virtual env in $VIRTUAL_ENV and ensure it respects pip version
RUN pip install --upgrade virtualenv \
    && virtualenv $VIRTUAL_ENV \
    && $VIRTUAL_ENV/bin/pip install --upgrade pip==$PYTHON_PIP_VERSION
              
ENV PATH $VIRTUAL_ENV/bin:$PATH

RUN groupadd --gid 1000 ccg-user \
    && useradd --home-dir /data --no-create-home --system --uid 1000 --gid 1000 ccg-user \
    && mkdir /data \
    && chown ccg-user:ccg-user /data

CMD ["python2]

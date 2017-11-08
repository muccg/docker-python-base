FROM amazonlinux:2017.09
LABEL maintainer "https://github.com/muccg/"

ENV VIRTUAL_ENV /env
ENV PYTHON_PIP_VERSION 9.0.1
ENV PIP_NO_CACHE_DIR="off"

RUN yum -y update && yum clean all

RUN yum -y install \
  python36 \
  python36-devel \
  python36-pip \
  shadow-utils \
  && yum clean all

# install "virtualenv", since the vast majority of users of this image will want it
# create a virtual env in $VIRTUAL_ENV and ensure it respects pip version
#
# using the legacy virtualenv package as python3 -m venv is broken in Amazon Linux / Centos
# https://bugzilla.redhat.com/show_bug.cgi?id=1464570
RUN pip-3.6 install --upgrade virtualenv \
    && virtualenv $VIRTUAL_ENV \
    && $VIRTUAL_ENV/bin/pip install --upgrade pip==$PYTHON_PIP_VERSION
              
ENV PATH $VIRTUAL_ENV/bin:$PATH

RUN groupadd --gid 1000 ccg-user \
    && useradd --home-dir /data --no-create-home --system --uid 1000 --gid 1000 ccg-user \
    && mkdir /data \
    && chown ccg-user:ccg-user /data

CMD ["python3"]

# python:3.5 is jessie, there is no jessie tag
FROM python:3.5-slim
MAINTAINER https://github.com/muccg

ENV VIRTUAL_ENV /env
ENV PYTHON_PIP_VERSION 8.1.2

RUN sed -i s/httpredir.debian.org/ftp.au.debian.org/ /etc/apt/sources.list

# create a virtual env in $VIRTUAL_ENV and ensure it respects pip version
RUN pyvenv $VIRTUAL_ENV \
    && $VIRTUAL_ENV/bin/pip install --upgrade --no-cache-dir pip==$PYTHON_PIP_VERSION

ENV PATH $VIRTUAL_ENV/bin:$PATH

RUN mkdir /app

RUN addgroup --gid 1000 ccg-user \
  && adduser --disabled-password --home /data --no-create-home --system -q --uid 1000 --ingroup ccg-user ccg-user \
  && mkdir /data \
  && chown ccg-user:ccg-user /data

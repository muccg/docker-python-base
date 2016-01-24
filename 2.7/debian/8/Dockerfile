FROM python:2.7-slim
MAINTAINER https://github.com/muccg

ARG PIP_OPTS="--upgrade --no-cache-dir"

RUN pip install $PIP_OPTS virtualenv

RUN mkdir /app

RUN addgroup --gid 1000 ccg-user \
  && adduser --disabled-password --home /data --no-create-home --system -q --uid 1000 --ingroup ccg-user ccg-user \
  && mkdir /data \
  && chown ccg-user:ccg-user /data

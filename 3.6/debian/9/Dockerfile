FROM python:3.6-slim
LABEL maintainer "https://github.com/muccg/"

ENV VIRTUAL_ENV /env
ENV PYTHON_PIP_VERSION 10.0.1
ENV PIP_NO_CACHE_DIR="off"
ENV PATH $VIRTUAL_ENV/bin:$PATH

# create a virtual env in $VIRTUAL_ENV and ensure it respects pip version
RUN python3 -m venv $VIRTUAL_ENV \
    && $VIRTUAL_ENV/bin/pip install --upgrade pip==$PYTHON_PIP_VERSION \
    && pip install --upgrade "setuptools>=40.0.0,<=41.0.0"

RUN mkdir /app

RUN addgroup --gid 1000 ccg-user \
  && adduser --disabled-password --home /data --no-create-home --system -q --uid 1000 --ingroup ccg-user ccg-user \
  && mkdir /data \
  && chown ccg-user:ccg-user /data

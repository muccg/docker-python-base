FROM python:2.7-slim
LABEL maintainer "https://github.com/muccg/"

ENV VIRTUAL_ENV /env
ENV PYTHON_PIP_VERSION 9.0.1
ENV PIP_NO_CACHE_DIR="off"

# create a virtual env in $VIRTUAL_ENV and ensure it respects pip version
RUN pip install --upgrade virtualenv \
    && virtualenv $VIRTUAL_ENV \
    && $VIRTUAL_ENV/bin/pip install --upgrade pip==$PYTHON_PIP_VERSION

ENV PATH $VIRTUAL_ENV/bin:$PATH

RUN mkdir /app

RUN addgroup --gid 1000 ccg-user \
  && adduser --disabled-password --home /data --no-create-home --system -q --uid 1000 --ingroup ccg-user ccg-user \
  && mkdir /data \
  && chown ccg-user:ccg-user /data

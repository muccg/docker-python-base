# python:3.4 is jessie, there is no jessie tag
FROM python:3.4-slim
MAINTAINER https://github.com/muccg

ENV VIRTUAL_ENV /env

# create a virtual env in $VIRTUAL_ENV and ensure it respects pip version
RUN pip install $PIP_OPTS virtualenv \
    && virtualenv $VIRTUAL_ENV \
    && $VIRTUAL_ENV/bin/pip install --upgrade --no-cache-dir pip==$PYTHON_PIP_VERSION

ENV PATH $VIRTUAL_ENV/bin:$PATH

RUN mkdir /app

RUN addgroup --gid 1000 ccg-user \
  && adduser --disabled-password --home /data --no-create-home --system -q --uid 1000 --ingroup ccg-user ccg-user \
  && mkdir /data \
  && chown ccg-user:ccg-user /data

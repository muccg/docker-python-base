# python:3.5 is jessie, there is no jessie tag
FROM python:3.5-slim
MAINTAINER https://github.com/muccg

RUN mkdir /app

RUN addgroup --gid 1000 ccg-user \
  && adduser --disabled-password --home /data --no-create-home --system -q --uid 1000 --ingroup ccg-user ccg-user \
  && mkdir /data \
  && chown ccg-user:ccg-user /data

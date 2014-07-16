# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.11
MAINTAINER ccg <ccgdevops@googlegroups.com>

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update -q
RUN apt-get install -y language-pack-en
RUN locale-gen en_US
RUN apt-get install -y --no-install-recommends \
  apt-transport-https ca-certificates \
  build-essential \
  git
RUN apt-get install -y --no-install-recommends \
  python2.7 python2.7-dev python-pip
RUN pip install -U pip
RUN pip install -U virtualenv
RUN env --unset=DEBIAN_FRONTEND

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

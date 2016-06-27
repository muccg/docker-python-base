# Derived from https://github.com/docker-library/python
FROM buildpack-deps:wily
MAINTAINER https://github.com/muccg

ENV VIRTUAL_ENV /env

# remove several traces of debian python
RUN apt-get purge -y python.*

# gpg: key 18ADD4FF: public key "Benjamin Peterson <benjamin@python.org>" imported
# gpgkeys: key C01E1CAD5EA2C4F0B8E3571504C367C218ADD4FF can't be retrieved
ENV GPG_KEY C01E1CAD5EA2C4F0B8E3571504C367C218ADD4FF

ENV PYTHON_VERSION 2.7.11

# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"
ENV PYTHON_PIP_VERSION 8.1.2

RUN set -ex \
	#&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY" \
	&& curl -fSL "https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.xz" -o python.tar.xz \
	&& curl -fSL "https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.xz.asc" -o python.tar.xz.asc \
	#&& gpg --verify python.tar.xz.asc \
	&& mkdir -p /usr/src/python \
	&& tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz \
	&& rm python.tar.xz* \
	&& cd /usr/src/python \
	&& ./configure --enable-shared --enable-unicode=ucs4 \
	&& make -j$(nproc) \
	&& make install \
	&& ldconfig \
	&& curl -fSL 'https://bootstrap.pypa.io/get-pip.py' | python2 \
	&& pip install --no-cache-dir --upgrade pip==$PYTHON_PIP_VERSION \
	&& find /usr/local \
		\( -type d -a -name test -o -name tests \) \
		-o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
		-exec rm -rf '{}' + \
	&& rm -rf /usr/src/python

# install "virtualenv", since the vast majority of users of this image will want it
# create a virtual env in $VIRTUAL_ENV and ensure it respects pip version
RUN pip install --upgrade --no-cache-dir virtualenv \
    && virtualenv $VIRTUAL_ENV \
    && $VIRTUAL_ENV/bin/pip install --upgrade --no-cache-dir pip==$PYTHON_PIP_VERSION

ENV PATH $VIRTUAL_ENV/bin:$PATH

# Allow us to find default route and hence docker host
RUN apt-get update && apt-get install -y --no-install-recommends \
  iproute2 \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /app

RUN addgroup --gid 1000 ccg-user \
  && adduser --disabled-password --home /data --no-create-home --system -q --uid 1000 --ingroup ccg-user ccg-user \
  && mkdir /data \
  && chown ccg-user:ccg-user /data

CMD ["python2"]

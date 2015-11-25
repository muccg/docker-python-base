#!/bin/sh
#
# Script to build images
#

# break on error
set -e

REPO="muccg"
DATE=`date +%Y.%m.%d`

DOCKER_HOST=$(ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+')
HTTP_PROXY="http://${DOCKER_HOST}:3128"
PIP_INDEX_URL="http://${DOCKER_HOST}:3141/root/pypi/+simple/"
PIP_TRUSTED_HOST=${DOCKER_HOST}

: ${DOCKER_BUILD_OPTIONS:="--pull=true --build-arg PIP_TRUSTED_HOST=${PIP_TRUSTED_HOST} --build-arg PIP_INDEX_URL=${PIP_INDEX_URL} --build-arg HTTP_PROXY=${HTTP_PROXY} --build-arg http_proxy=${HTTP_PROXY}"}

# build dirs, top level is python version
for pythondir in */
do
    pythonver=`basename ${pythondir}`

    # subdirs are distro
    for distrodir in ${pythondir}*/
    do
        distro=`basename ${distrodir}`

        # subdirs are distro version
        for distroverdir in ${distrodir}*/
        do
            distrover=`basename ${distroverdir}`

            image="${REPO}/python-base:${distro}${distrover}-${pythonver}"
            echo "################################################################### ${image}"
        
            ## warm up cache for CI
            docker pull ${image} || true

            ## build
            set -x
            docker build ${DOCKER_BUILD_OPTIONS} -t ${image}-${DATE} ${distroverdir}
            docker build ${DOCKER_BUILD_OPTIONS} -t ${image} ${distroverdir}

            ## for logging in CI
            docker inspect ${image}-${DATE}

            # push
            docker push ${image}-${DATE}
            docker push ${image}
            set +x
        done
    done
done

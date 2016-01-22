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

: ${DOCKER_BUILD_OPTIONS:="--pull=true --build-arg HTTP_PROXY=${HTTP_PROXY} --build-arg http_proxy=${HTTP_PROXY}"}


ci_docker_login() {
    if [ -n "$bamboo_DOCKER_USERNAME" ] && [ -n "$bamboo_DOCKER_EMAIL" ] && [ -n "$bamboo_DOCKER_PASSWORD" ]; then
        docker login  -e "${bamboo_DOCKER_EMAIL}" -u ${bamboo_DOCKER_USERNAME} --password="${bamboo_DOCKER_PASSWORD}"
    else
        echo "Docker vars not set, not logging in to docker registry"
    fi
}

ci_docker_login

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

            docker push ${image}-${DATE}
            docker push ${image}
            set +x
        done
    done
done

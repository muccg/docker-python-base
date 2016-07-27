#!/bin/sh
#
# Script to build images
#

: ${PROJECT_NAME:='python-base'}
. ./lib.sh

set -e

docker_options

info "${DOCKER_BUILD_OPTS}"

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

            image="${DOCKER_IMAGE}:${distro}${distrover}-${pythonver}"
            echo "################################################################### ${image}"

            ## warm up cache for CI
            docker pull ${image} || true

            ## build
            set -x
            docker build ${DOCKER_BUILD_OPTS} -t ${image}-${DATE} ${distroverdir}
            docker build ${DOCKER_BUILD_OPTS} -t ${image} ${distroverdir}

            ## for logging in CI
            docker inspect ${image}-${DATE}

            if [ ${DOCKER_USE_HUB} = "1" ]; then
                _ci_docker_login
                docker push ${image}-${DATE}
                docker push ${image}
            fi
            set +x
        done
    done
done

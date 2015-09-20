#!/bin/sh
#
# Script to build images
#

# break on error
set -e

REPO="muccg"
DATE=`date +%Y.%m.%d`

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

            image="${REPO}/python-base:${distro}${version}-${pythonver}"
            #echo "################################################################### ${image}"
        
            ## warm up cache for CI
            docker pull ${image} || true

            ## build
            docker build --pull=true -t ${image}-${DATE} ${distroverdir}
            docker build -t ${image} ${distroverdir}

            ## for logging in CI
            docker inspect ${image}-${DATE}

            # push
            docker push ${image}-${DATE}
            docker push ${image}

        done
    done
done

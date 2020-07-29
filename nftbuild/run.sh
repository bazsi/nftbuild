#!/bin/bash

NFTBUILD_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ROOT_DIR="$(cd $NFTBUILD_DIR/.. && pwd)"
BUILD_DIR=$NFTBUILD_DIR/build
INSTALL_DIR=$NFTBUILD_DIR/install

DOCKER_ARGS="-e USER_NAME_ON_HOST=$(whoami)
        --network=host --privileged
        -v ${NFTBUILD_DIR}/commands:/nftbuild
        -v ${ROOT_DIR}:/source
        -v ${BUILD_DIR}:/build
        -v ${INSTALL_DIR}:/install
        --env-file ${NFTBUILD_DIR}/environ
        -e PATH=/nftbuild:/usr/lib/ccache:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

cd $ROOT_DIR
mkdir -p ${BUILD_DIR} || true
mkdir -p ${INSTALL_DIR} || true

docker run ${DOCKER_ARGS} --rm -ti nftables-shell bash

#!/bin/bash

NFTBUILD_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd $NFTBUILD_DIR
docker build -t nftables-shell -f image/Dockerfile .

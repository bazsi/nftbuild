FROM ubuntu:20.04
LABEL maintainer="Balazs Scheidler <bazsi77@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true
ENV LANG C.UTF-8

RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends --yes gpg wget less joe git

# basic build tools
RUN apt-get install -y --no-install-recommends --yes build-essential autoconf libtool pkg-config automake bison flex

# -dev packages
RUN apt-get install -y --no-install-recommends --yes libgmp-dev libreadline-dev python2 libpython2-dev libjansson-dev libxtables-dev

# documentation
RUN apt-get install -y --no-install-recommends --yes asciidoc xsltproc

# tests
RUN apt-get install -y --no-install-recommends --yes kmod python
RUN apt-get install -y --no-install-recommends --yes gosu

RUN mkdir /nftbuild || true
COPY commands/* /nftbuild/
COPY image/entrypoint.sh /

VOLUME /source
VOLUME /build
VOLUME /install

ENTRYPOINT ["/entrypoint.sh"]

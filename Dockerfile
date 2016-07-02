FROM gbalaraman/alpine-base:3.3
MAINTAINER Goutham Balaraman <gouthaman.balaraman@gmail.com>
LABEL Description="A build environment with boost c++ libraries"

ARG boost_version=1.61.0
ARG boost_dir=boost_1_61_0
ENV boost_version ${boost_version}

RUN apk update && apk add --no-cache bzip2-dev \ 
    && wget http://downloads.sourceforge.net/project/boost/boost/${boost_version}/${boost_dir}.tar.gz \
    && tar xfz ${boost_dir}.tar.gz \
    && rm ${boost_dir}.tar.gz \
    && cd ${boost_dir} \
    && ./bootstrap.sh \
    && ./b2 --without-python --prefix=/usr -j 4 link=shared runtime-link=shared install \
    && cd .. && rm -rf ${boost_dir} \
    && /bin/bash -c export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/

CMD bash

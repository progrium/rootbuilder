FROM           ubuntu:trusty
MAINTAINER     Jeff Lindsay <progrium@gmail.com>

ENV            BR_VERSION 2014.02
RUN            DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y \
                    wget \
                    build-essential \
                    libncurses-dev \
                    rsync \
                    unzip \
                    bc \
                    gnupg \
                    python \
                    libc6-i386 \
                    language-pack-en-base
WORKDIR        /tmp
RUN            wget -nv http://buildroot.uclibc.org/downloads/buildroot-$BR_VERSION.tar.gz
RUN            tar -zxf buildroot-$BR_VERSION.tar.gz && mv buildroot-$BR_VERSION buildroot
ADD            ./package/nginx /tmp/buildroot/package/nginx
RUN            sed '/menu "Networking applications"/a\source \"package\/nginx\/Config.in"' buildroot/package/Config.in > tmpfile
RUN            mv tmpfile buildroot/package/Config.in
WORKDIR        /tmp/buildroot

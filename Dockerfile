FROM           ubuntu:trusty
MAINTAINER     Jeff Lindsay <progrium@gmail.com>

# Install packages
ENV            DEBIAN_FRONTEND noninteractive
RUN            apt-get -q update && apt-get -qyV install \
                    wget \
                    build-essential \
                    libncurses-dev \
                    rsync \
                    unzip \
                    bc \
                    gnupg \
                    python \
                    libc6-i386
RUN            env --unset=DEBIAN_FRONTEND

# Create directories
RUN            mkdir -p /tmp/hooks
RUN            mkdir -p /tmp/builder
WORKDIR        /tmp/builder

# Retrieve files and check authenticity
ENV            BR_VERSION 2014.02
RUN            wget -nv http://buildroot.uclibc.org/downloads/buildroot-$BR_VERSION.tar.gz &&\
               wget -nv http://buildroot.uclibc.org/downloads/buildroot-$BR_VERSION.tar.gz.sign &&\
               wget -nv http://uclibc.org/~jacmet/pubkey.gpg &&\
               gpg --import pubkey.gpg &&\
               gpg --verify buildroot-$BR_VERSION.tar.gz.sign

# Extract
RUN            tar -zxf buildroot-$BR_VERSION.tar.gz &&\
               mv buildroot-$BR_VERSION buildroot

# Base config
WORKDIR        /tmp/builder/buildroot
RUN            make defconfig
RUN            sed -i 's/BR2_i386=y/BR2_x86_64=y/' .config
ADD            config /tmp/builder/buildroot/.config.extra
RUN            cat .config.extra >> .config

# Hooks and packages
ONBUILD ADD         ./hooks /tmp/hooks/
ONBUILD ADD         ./package /tmp/builder/buildroot/package/

# Build
ONBUILD WORKDIR     /tmp/builder/buildroot
ONBUILD RUN         [ -x /tmp/hooks/pre-make ] && /tmp/hooks/pre-make || true
ONBUILD RUN         cat /tmp/builder/buildroot/.config  
ONBUILD RUN         make oldconfig
ONBUILD RUN         make --quiet
ONBUILD RUN         mv /tmp/builder/buildroot/output/images/rootfs.tar /tmp/rootfs.tar
ONBUILD RUN         [ -x /tmp/hooks/post-make ] && /tmp/hooks/post-make || true

WORKDIR        /tmp
CMD            ["cat", "/tmp/rootfs.tar"]
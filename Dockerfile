FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London
RUN apt update && \
    apt upgrade -y
RUN apt update && \
    apt install -y \
    sudo \
    git \
    curl \
    nano \
    wget \
    build-essential \
    brightnessctl \
    autotools-dev \
    automake \
    libtool \
    libtool-bin \
    libevdev-dev \
    libdrm-dev \
    python3 \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    ninja-build \
    libopenal-dev \
    premake4 \
    autoconf \
    ffmpeg \
    libsnappy-dev \
    libboost-tools-dev \
    magics++ \
    libboost-thread-dev \
    libboost-all-dev \
    pkg-config \
    zlib1g-dev \
    libpng-dev \
    libsdl2-dev \
    libsdl1.2-dev \
    clang \
    cmake \
    cmake-data \
    libarchive13 \
    libcurl4 \
    libfreetype6-dev \
    libjsoncpp-dev \
    librhash0 \
    libuv1 \
    mercurial \
    mercurial-common \
    libgbm-dev \
    libsdl2-ttf-dev \
    libsdl2-image-dev \
    libsdl2-mixer-dev \
    libsdl-image1.2-dev \
    libsdl-mixer1.2-dev \
    libsdl-gfx1.2-dev

RUN apt update

RUN ln -s /usr/include/libdrm/ /usr/include/drm

# Install meson
RUN pip3 install meson
WORKDIR /root
RUN git clone https://github.com/mesonbuild/meson.git && \
    cd meson && \
    ln -s /meson/meson.py /usr/bin/meson

# Install libsdl1.2
WORKDIR /root
RUN git clone https://github.com/libsdl-org/sdl12-compat.git && \
    cd sdl12-compat && \
    mkdir build && cd build && \
    cmake .. && \
    make

# Install gl4es
WORKDIR /root
RUN git clone https://github.com/ptitSeb/gl4es.git && \
    cd gl4es && \
    mkdir build && cd build && \
    cmake .. -DNOX11=ON -DGLX_STUBS=ON -DEGL_WRAPPER=ON -DGBM=ON && \
    make

# Install more compatible SDL2
ARG TARGETPLATFORM
WORKDIR /root
RUN case ${TARGETPLATFORM} in \
         "linux/amd64")  ARCHITECTURE=/usr/lib/x86_64-linux-gnu  ;; \
         "linux/arm64")  ARCHITECTURE=/usr/lib/aarch64-linux-gnu  ;; \
         "linux/arm/v7") ARCHITECTURE=/usr/lib/arm-linux-gnueabihf  ;; \
         "linux/386")    ARCHITEXTURE=/usr/include   ;; \
    esac \
    && rm $ARCHITECTURE/libSDL2.* \
    && rm -rf $ARCHITECTURE/libSDL2-2.0.so* \
    && wget https://github.com/libsdl-org/SDL/archive/refs/tags/release-2.26.2.tar.gz \
    && tar -xzf release-2.26.2.tar.gz \
    && cd SDL-release-2.26.2 \
    && ./configure --prefix=/usr \
    && make -j8 \
    && make install \
    && /sbin/ldconfig

FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London
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
    libjsoncpp1 \
    librhash0 \
    libuv1 \
    mercurial \
    mercurial-common \
    libgbm-dev \
    libsdl2-ttf-2.0-0 \
    libsdl2-ttf-dev \
    libsdl2-image-2.0.0 \
    libsdl2-image-dev \
    libsdl2-mixer-2.0.0 \
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

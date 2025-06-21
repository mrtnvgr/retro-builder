FROM debian@sha256:5a1fa4e7ca7e4a8ea0449d0e5e6ac6593b4aebac12f658e69af354c0b3cb073a

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt upgrade -y && \
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
    libarchive13t64 \
    libcurl4t64 \
    libfreetype6-dev \
    libjsoncpp-dev \
    libuv1t64 \
    mercurial \
    mercurial-common \
    libgbm-dev \
    libsdl2-ttf-dev \
    libsdl2-image-dev \
    libsdl2-mixer-dev \
    libsdl-image1.2-dev \
    libsdl-mixer1.2-dev \
    libsdl-gfx1.2-dev \
    bison \
    meson && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/include/libdrm/ /usr/include/drm

WORKDIR /root

# Install libsdl1.2
RUN git clone --depth 1 https://github.com/libsdl-org/sdl12-compat.git && \
    cd sdl12-compat && \
    mkdir build && cd build && \
    cmake .. && \
    make -j$(nproc)

# Install gl4es
RUN git clone --depth 1 --branch "v1.1.4" https://github.com/ptitSeb/gl4es.git
RUN cd gl4es && \
    mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=RelWithDebInfo -DNOX11=ON -DGLX_STUBS=ON -DEGL_WRAPPER=ON -DGBM=ON && \
    make -j$(nproc)

# Install more compatible SDL2
ARG TARGETPLATFORM
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
    && rm release-2.26.2.tar.gz \
    && cd SDL-release-2.26.2 \
    && ./configure \
    && make -j$(nproc) \
    && make install \
    && /sbin/ldconfig

# Build gptokeyb2
RUN git clone --depth 1 --recursive https://github.com/PortsMaster/gptokeyb2 && \
	cd gptokeyb2 && \
	mkdir build && cd build && \
	cmake -S .. -GNinja -DCMAKE_BUILD_TYPE=Release && \
    cmake --build . && \
	strip -s gptokeyb2 && \
    mv gptokeyb2 ../

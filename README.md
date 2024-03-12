## retro_builder_docker
Retro Builder.

The doocker file is aimed at help support compiling games to use with Portmaster

## How to use the image

### 32-bit ARM

Download the prebuilt image and run the Docker container using:

```bash
docker pull monkeyx/retro_builder:arm32
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker run --privileged -it --platform=linux/armhf --name builder32 monkeyx/retro_builder:arm32 bash
```

### 64-bit ARM

Download the prebuilt image and run the Docker container using:

```bash
docker pull monkeyx/retro_builder:arm64
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker run --privileged -it --platform=linux/arm64 --name builder64 monkeyx/retro_builder:arm64 bash
```

### 64-bit X86_64

Download the prebuilt image and run the Docker container using:

```bash
docker pull monkeyx/retro_builder:x86_64
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker run --privileged -it --platform=linux/amd64 --name builderx86_64 monkeyx/retro_builder:x86_64 bash
```

## How to build the image

### 32-bit ARM

Execute the following on your machine:

```bash
git clone https://github.com/monkeyx-net/retro_builder_docker.git
cd retro_builder_docker
docker build . --platform linux/arm/v7 -t monkeyx/retro_builder:arm32
```

### 64-bit ARM

Execute the following on your machine:

```bash
git clone https://github.com/monkeyx-net/retro_builder_docker.git
cd retro_builder_docker
docker build . --platform linux/arm64 -t monkeyx/retro_builder:arm64
```

### 64-bit x86_64

Execute the following on your machine:

```bash
git clone https://github.com/monkeyx-net/retro_builder_docker.git
cd retro_builder_docker
docker build . --platform linux/amd64 -t monkeyx/retro_builder:x86_64
```

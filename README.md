# retro_builder_docker
Retro Builder.

The doocker file is aimed at help support compiling games to use with Portmaster

## How to use the image

### 32-bit ARM

Download the prebuilt image and run the Docker container using:

```bash
docker pull todo/tba:arm32
docker run --privileged -it --name somename32 todo/tba:arm32 bash
```

### 64-bit ARM

Download the prebuilt image and run the Docker container using:

```bash
docker pull todo/tba:arm64
docker run --privileged -it --name somename64 todo/tba:arm64 bash
```


## How to build the image

### 32-bit ARM

Execute the following on your machine:

```bash
git clone https://github.com/monkeyx-net/retro_builder_docker.git
cd retro_builder_docker
docker build . --platform linux/arm/v7 -t todo/tba:arm32
```

### 64-bit ARM

Execute the following on your machine:

```bash
git clone retro_builder_docker
cd retrooz_dev_docker
docker build . --platform linux/arm64 -t todo/tba:arm64
```

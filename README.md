# retro-builder

*Batteries included* Docker image for compiling games to use with Portmaster.

Based on [retro_builder_docker](https://github.com/monkeyx-net/retro_builder_docker) by monkeyx, thanks!

### This fork features:

- Ubuntu 20.04 -> Debian Unstable 20250610
- Github Workflows CI builds
- Other misc improvements

### Usage example:

```bash
PLATFORM=linux/arm64
docker pull --platform $PLATFORM ghcr.io/mrtnvgr/retro-builder
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker run -it --platform=$PLATFORM --name "builder" ghcr.io/mrtnvgr/retro-builder bash
```

# Cura Engine
[![WAPM](https://wapm.io/package/cloud-cnc-bot/cura-engine/badge.svg)](https://wapm.io/package/cloud-cnc-bot/cura-engine)
[![Build](https://img.shields.io/github/workflow/status/Cloud-CNC/cura-engine/Build?label=Build&style=flat-square)](https://github.com/Cloud-CNC/cura-engine/actions/workflows/build.yml)
[![Publish](https://img.shields.io/github/workflow/status/Cloud-CNC/cura-engine/Publish?label=Publish&style=flat-square)](https://github.com/Cloud-CNC/cura-engine/actions/workflows/publish.yml)

[Cura Engine](https://github.com/ultimaker/curaengine) for [Web Assembly (WASM)](https://webassembly.org).

If you're trying to embed Cura Engine into your web application, check out [Cura WASM](https://github.com/cloud-cnc/cura-wasm) instead (Which uses this package under the hood).

## Installation

```bash
wapm install cloud-cnc-bot/cura-engine
```

*Note: you'll need to install [WAPM](https://wapm.io) first.*

## Usage

```bash
# Print help message
wapm run cura-engine -- help

# Slice Benchy for an Ultimaker 2
git clone https://github.com/ultimaker/cura.git

wget https://github.com/CreativeTools/3DBenchy/raw/master/Single-part/3DBenchy.stl -O benchy.stl

wapm run cura-engine --dir=./cura/resources/definitions --dir=. -- slice -j ./cura/resources/definitions/ultimaker2.def.json -o ./benchy.gcode -l ./data/benchy.stl
```

## Development

### Building
1. Check out the code
2. Build the Docker container:

```bash
docker build . -f docker/build.dockerfile -t cloud-cnc/cura-engine
```

3. Run the Docker container:

```bash
docker run -it --name cura-engine cloud-cnc/cura-engine
```

4. Build Cura Engine:

```bash
# This should be run within the container
./build.sh
```

## FAQ

### What is this fork for?
This fork contains a version of Cura Engine compatible with and optimized for WASM.

### How close is this fork supposed to remain to the source?
Fairly close to reduce the amount of time it takes to support new versions of Cura Engine.

### Can I contribute?
Yes, absolutely. If you're looking for something specific to help with, performance improvements are always welcome.

### How does this fork work?
Every Saturday at `00:00 UTC`, [sync.yml](.github/workflows/sync.yml) will create a pull request to synchronize this fork with it's [upstream source](https://github.com/ultimaker/curaengine) and attempt to automatically merge it. On each push, [build.yml](.github/workflows/build.yml) will build and test this fork. When a new release is created, [publish.yml](.github/workflows/publish.yml) will publish it to [WAPM](https://wapm.io).

## License Obligations

### Downstream Modifications
You can view downstream modifications by running:

```bash
# Add the upstream repository
git remote add upstream https://github.com/ultimaker/curaengine.git

# Pull commits from upstream
git pull upstream master

# Show the differences between the upstream and downstream
git diff upstream/master..origin/main
```

### Source
The source of this fork is [github.com/ultimaker/curaengine](https://github.com/ultimaker/curaengine).

[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2FCloud-CNC%2Fcura-engine.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2FCloud-CNC%2Fcura-engine?ref=badge_large)

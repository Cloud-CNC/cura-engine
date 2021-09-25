#!/bin/bash
# Build Cura Engine for WASM

# Colors
GRAY="\033[1;30m"
GREEN="\033[0;32m"
RED="\033[0;31m"
RESET="\033[0m"
YELLOW="\033[0;33m"

# Clean the build directory
function clean() {
  # Delete existing build directory
  BUILD_DIR="build"
  if [ -d $BUILD_DIR ]; then
  rm -r $BUILD_DIR
  echo -e "${YELLOW}[WARNING] Deleted existing build!${RESET}"
  fi

  # Create a build directory
  mkdir $BUILD_DIR
  cd $BUILD_DIR
  echo -e "${GRAY}[INFO] Created build directory.${RESET}"
}

# Build Cura Engine
function build() {
  # Generate makefile via Wasmer
  echo Generating makefile...
  wasimake cmake $1 ..
  exit_code=$?
  if [ $exit_code -ne 0 ]; then
    echo -e "${RED}[ERROR] Failed to generate makefiles!${RESET}"
    exit 1
  fi
  echo -e "${GRAY}[INFO] Generated makefiles.${RESET}"

  # Build Cura Engine via Wasmer
  echo Building...
  wasimake make
}

# Clean the directory
clean

# Get version number
VERSION=$(sed -nE "s/version ?= ?['\"](.+)['\"]/\1/p" ../wapm.toml)

# Build standalone
build "-DENABLE_ARCUS=OFF -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=OFF -DCURA_ENGINE_VERSION=$VERSION"
if [ $? -ne 0 ]; then
  echo -e "${RED}[ERROR] Failed to build standalone Cura Engine!${RESET}"
  exit 1
fi
mv ./CuraEngine.wasm ./standalone.wasm

# Build with WASM callbacks
build "-DENABLE_ARCUS=OFF -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=OFF -DENABLE_WASM_CALLBACKS=ON -DCURA_ENGINE_VERSION=$VERSION"
if [ $? -ne 0 ]; then
  echo -e "${RED}[ERROR] Failed to build Cura Engine with WASM callbacks!${RESET}"
  exit 1
fi
mv ./CuraEngine.wasm ./callbacks.wasm

# Log
echo -e "${GRAY}[INFO] Built Cura Engine V${VERSION}.${RESET}"
echo -e "${GREEN}[SUCCESS] All done!${RESET}"
echo -e "${GRAY}Note: you can run Cura Engine with \"wasmer ./build/standalone.wasm\"${RESET}"

# Exit
exit

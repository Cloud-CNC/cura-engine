#!/bin/bash
# Build Cura Engine for WASM

# Colors
GRAY="\033[1;30m"
GREEN="\033[0;32m"
RED="\033[0;31m"
RESET="\033[0m"
YELLOW="\033[0;33m"

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

# Get version number
VERSION=$(sed -nE "s/version ?= ?['\"](.+)['\"]/\1/p" ../wapm.toml)

# Generate makefile via Wasmer
echo Generating makefile...
wasimake cmake -DENABLE_ARCUS=OFF -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=OFF -DCURA_ENGINE_VERSION=$VERSION ..
exit_code=$?
if [ $exit_code -ne 0 ]; then
  echo -e "${RED}[ERROR] Failed to generate makefiles!${RESET}"
  exit 1
fi
echo -e "${GRAY}[INFO] Generated makefiles.${RESET}"

# Build Cura Engine via Wasmer
echo Building...
wasimake make
exit_code=$?
if [ $exit_code -ne 0 ]; then
  echo -e "${RED}[ERROR] Failed to build Cura Engine!${RESET}"
  exit 1
fi
echo -e "${GRAY}[INFO] Built Cura Engine V${VERSION}.${RESET}"

# Log
echo -e "${GREEN}[SUCCESS] All done!${RESET}"
echo -e "${GRAY}Note: you can run Cura Engine with \"wasmer ./build/CuraEngine.wasm\"${RESET}"

# Exit
exit

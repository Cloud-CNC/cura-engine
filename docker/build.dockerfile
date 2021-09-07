# Cura Engine build environment

# Use Wasienv as base
FROM artlogical/wasienv

# Install WASI SDK
ARG WASIENV_VERSION=11
RUN wasienv install-sdk $WASIENV_VERSION
RUN sed -i -e "s/CURRENT_SDK = \"[[:digit:]]\+\"/CURRENT_SDK = \"$WASIENV_VERSION\"/" $(python -m site --user-site)/wasienv/sdk.py

# Use root as working directory
WORKDIR /root/cura-engine

# Copy source code
COPY . .

# Make build script executable
RUN chmod +x ./build.sh

# Disable promps while installing
ENV DEBIAN_FRONTEND=noninteractive

# Update debian
RUN apt update -y && apt upgrade -y && apt dist-upgrade -y

#Install packages
RUN apt install cmake git -y

# Cura Engine build environment

# Use Wasienv as base
FROM wasienv/wasienv

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
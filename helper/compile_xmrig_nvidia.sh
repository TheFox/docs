#!/usr/bin/env bash

# Compile xmrig-nvidia on macOS.
# https://github.com/xmrig/xmrig-nvidia

# Dependencies
brew tap caskroom/drivers
brew install libuv
brew cask install nvidia-cuda

git clone git@github.com:xmrig/xmrig-nvidia.git
cd xmrig-nvidia
mkdir build
cd build/
cmake -DWITH_HTTPD=OFF ..

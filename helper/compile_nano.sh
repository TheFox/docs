#!/usr/bin/env bash

brew install miniupnpc

git clone git@github.com:nanocurrency/raiblocks.git
cd raiblocks
git submodule update --init --recursive
mkdir build
cd build
cmake ..
make

#!/usr/bin/env bash

# Compile Genoil cpp-ethereum on macOS.
# From Genoil for Nicehash.

git clone git@github.com:Genoil/cpp-ethereum.git
cd cpp-ethereum
mkdir build
cd build
cmake -DBUNDLE=miner ..
make

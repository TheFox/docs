#!/usr/bin/env bash

# Compile Garlicoin on macOS.

# Install dependencies.
brew install berkeley-db

# Compile Garlicoin
git clone git@github.com:GarlicoinOrg/Garlicoin.git garlicoin
cd garlicoin
./autogen.sh 
./configure --with-incompatible-bdb
make

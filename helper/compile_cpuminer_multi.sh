#!/usr/bin/env bash

# Compile cpuminer-multi on macOS.
# https://github.com/tpruvot/cpuminer-multi

# Dependencies
brew install openssl jansson

# Link OpenSSL header files.
cd /usr/local/include 
ln -s ../opt/openssl/include/openssl .

git clone git@github.com:tpruvot/cpuminer-multi.git
cd cpuminer-multi

./autogen.sh
./nomacro.pl
./configure --disable-assembly CFLAGS="-Ofast -march=native" --with-crypto --with-curl
make

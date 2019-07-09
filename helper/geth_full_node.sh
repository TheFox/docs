#!/usr/bin/env bash

# --rpc --rpcport "8545" rpccorsdomain "http://janx.github.io" \

geth \
	--rpc --rpcaddr 127.0.0.1 --rpcport 8545 --rpcvhosts '*' \
	--syncmode full \
	--maxpeers 128 \
	--lightpeers 64 \
	--cache=1024 \
	console

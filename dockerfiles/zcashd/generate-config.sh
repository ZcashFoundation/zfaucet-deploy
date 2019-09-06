#!/bin/bash
set -euxo pipefail

WORKDIR=`pwd`

function generate_config {
	RPC_USER=$(head -c 32 /dev/urandom | base64)
	RPC_PASS=$(head -c 32 /dev/urandom | base64)

	cat <<- EOF > ${WORKDIR}/zcash.conf
		testnet=1
		addnode=testnet.z.cash
		rpcport=8232
		rpcuser=${RPC_USER}
		rpcpassword=${RPC_PASS}
	EOF
}

generate_config

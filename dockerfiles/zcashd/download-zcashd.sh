#!/bin/bash
set -euxo pipefail

WORKDIR=`pwd`

function download_zcashd {
	EXPECTED_HASH=${EXPECTED_HASH:-"597d169606ed2d1b621d80f39c06291ff01d57cae8f178c0d6e90df1a27405ed"}
	FILENAME=${FILENAME:-"zcash-2.0.7-2-linux64-debian-stretch.tar.gz"}
	#BASE_URL_ZCASH="https://z.cash/downloads"
	BASE_URL_MIRROR="https://storage.googleapis.com/zcashd-release-mirror/zcash-2.0.7-2"

	DOWNLOAD_DIR=`mktemp -d`

	cd ${DOWNLOAD_DIR}

	curl -OL ${BASE_URL_MIRROR}/${FILENAME}

	cat <<- EOF > ${DOWNLOAD_DIR}/SHA256SUMS
		${EXPECTED_HASH} ${FILENAME}
	EOF

	if sha256sum -c ${DOWNLOAD_DIR}/SHA256SUMS; then
		echo "DOWNLOAD OK"
		cp ${FILENAME} ${WORKDIR}/
		rm -rf ${DOWNLOAD_DIR}
		return
	fi

	echo "DOWNLOAD SAYS NOPE"
	rm -rf ${DOWNLOAD_DIR}
	exit 1
}

download_zcashd

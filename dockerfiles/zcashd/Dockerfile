FROM debian:buster-slim

RUN apt-get update && apt-get install -y -q curl

RUN adduser --uid 1000 --system zcash && \
    mkdir -p /home/zcash/.zcash/ && \
    mkdir -p /home/zcash/.zcash-params/ && \
    chown -R zcash /home/zcash && \
    echo "Initialized user 'zcash'"

COPY download-zcashd.sh /home/zcash/
COPY generate-config.sh /home/zcash/

USER zcash

WORKDIR /home/zcash/

ENV FILENAME "zcash-2.0.7-2-linux64-debian-stretch.tar.gz"
ENV EXPECTED_HASH "597d169606ed2d1b621d80f39c06291ff01d57cae8f178c0d6e90df1a27405ed"

# This should fail if the hash does not match the expected hash.
RUN ./download-zcashd.sh

# Create a zcash.conf for testnet with random RPC credentials
RUN ./generate-config.sh
RUN mv ./zcash.conf /home/zcash/.zcash/

# Extract the tarball.
RUN tar xvf $FILENAME

# Change this for each new version.
WORKDIR ./zcash-2.0.7-2

VOLUME [/home/zcash/.zcash]
VOLUME [/home/zcash/.zcash-params]

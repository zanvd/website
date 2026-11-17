#!/bin/sh
# Cloudflare build: the Workers Builds image does not ship Zola, so fetch the pinned release.
set -eu
ZOLA_VERSION="${ZOLA_VERSION:-0.23.6}"
DIR="$(mktemp -d)"
curl -fsSL "https://github.com/getzola/zola/releases/download/v${ZOLA_VERSION}/zola-v${ZOLA_VERSION}-x86_64-unknown-linux-gnu.tar.gz" | tar -xz -C "$DIR"
"$DIR/zola" build --force

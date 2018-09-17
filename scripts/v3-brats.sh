#!/usr/bin/env bash
set -euo pipefail

echo "Pull build image"
docker pull cfbuildpacks/cflinuxfs3-cnb-experimental:build

cd "$( dirname "${BASH_SOURCE[0]}" )/.."
source .envrc
./scripts/install_tools.sh

GINKGO_NODES=${GINKGO_NODES:-3}
GINKGO_ATTEMPTS=${GINKGO_ATTEMPTS:-2}
export CF_STACK=${CF_STACK:-cflinuxfs2}

cd src/*/v3/brats

echo "Run V3 Buildpack Runtime Acceptance Tests"
ginkgo -r --flakeAttempts=$GINKGO_ATTEMPTS -nodes $GINKGO_NODES

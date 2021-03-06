#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
#set -o xtrace

# Load libraries
. /opt/bitnami/scripts/liblog.sh

readonly cmd=$(command -v notary-server)
readonly flags=("-config=/etc/notary/server-config.postgres.json" "-logf=logfmt")
readonly installdir=$(dirname "$(dirname "$cmd")")

cd "$installdir"

info "Running Harbor Notary Server migrations"
"$installdir"/migrations/migrate.sh

info "** Starting Harbor Notary Server **"
exec "$cmd" "${flags[@]}"

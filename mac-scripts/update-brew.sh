#!/usr/bin/env bash
set -euo pipefail

BASEDIR=$(dirname "${BASH_SOURCE[0]}")
LEAFFILE="$BASEDIR/leaves"

brew leaves > "$LEAFFILE" || {
    echo "Failed to get brew leaves"
    exit 1
}

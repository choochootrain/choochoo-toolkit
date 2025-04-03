#!/usr/bin/env bash
set -euo pipefail

BASEDIR=$(dirname "${BASH_SOURCE[0]}")
LEAFFILE="$BASEDIR/leaves"

brew install $(cat $LEAFFILE || {
    echo "No leaves found to install"
    exit 1
}) || {
    echo "Failed to install brew leaves from $LEAFFILE"
    exit 1
}

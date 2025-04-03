#!/usr/bin/env bash
set -euo pipefail

which brew > /dev/null || { \
    echo "Homebrew not found, installing"; \
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";
}

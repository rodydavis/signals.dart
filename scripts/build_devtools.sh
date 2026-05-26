#!/usr/bin/env bash

# Get the directory of this script and workspace root
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WORKSPACE_DIR="$( dirname "$SCRIPT_DIR" )"

echo "Building and copying Signals DevTools extension..."
cd "$WORKSPACE_DIR/packages/signals_devtools_extension" || exit 1

dart run devtools_extensions build_and_copy --source=. --dest=../signals/extension/devtools

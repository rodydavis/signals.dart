#!/usr/bin/env bash
escapedPath="$(echo `pwd` | sed 's/\//\\\//g')"
sed "s/^SF:lib/SF:$escapedPath\/lib/g" coverage/lcov.info >> "$MELOS_ROOT_PATH/lcov.info"
rm -rf "coverage"

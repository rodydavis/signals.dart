#!/usr/bin/env bash

find . -name "pubspec.yaml" -execdir bash -c 'echo "Executing command in $(pwd)"; flutter pub get --no-example' \;
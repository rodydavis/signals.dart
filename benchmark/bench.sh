#!/bin/bash

# Initialize frameworks array
frameworks=()

# Get list of framework directories
for dir in frameworks/*/; do
  # Extract just the directory name
  framework=$(basename "$dir")
  frameworks+=("$framework")
done

if [ ${#frameworks[@]} -eq 0 ]; then
  echo "Error: No framework directories found in frameworks directory."
  exit 1
fi

skipFramework=("reactter");

for framework in "${frameworks[@]}"
do
    if [[ " ${skipFramework[*]} " =~ " $framework " ]]; then
      echo "Skipping $framework as it's in the skip list"
      continue
    fi

  echo "==================== $framework ===================="
  echo "$(date)"

  # Current directory
  cwd=$(pwd)

  # Enter framework directory
  cd "frameworks/$framework"

  # Install deps
  dart pub get

  # compile to native
  echo "Compiling $framework to native..."
  dart compile exe "main.dart" -o "$framework" || exit 1

  echo "Running benchmark for $framework..."
  { ./$framework | tee  "$cwd/bench/$framework.md"; } 2>&1;
  rm "$framework"
  if [ $? -ne 0 ]; then
    echo "Error running benchmark for $framework"
    exit 1
  fi

  # Back to root directory
  cd "$cwd"
done
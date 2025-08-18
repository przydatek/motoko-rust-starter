#!/bin/bash

# Read Input: Version 0 or 1 or diff
VERSION=$1

if [ "$VERSION" -eq 0 ]; then
  echo "Version 0"
elif [ "$VERSION" -eq 1 ]; then
  echo "Version 1"
else
  echo "Performing diff between versions 0 and 1"
  for wasm_file in target/*.wasm; do
    if [ -f "$wasm_file" ]; then
      # Expects two files: $wasm_file.0.txt and $wasm_file.1.txt
      # Perform git diff --no-index $wasm_file.0.txt $wasm_file.1.txt
      git diff --no-index "$wasm_file.0.txt" "$wasm_file.1.txt" > "$wasm_file.diff"
    fi
  done
  git diff --no-index target/motoko.wit.0.txt target/motoko.wit.1.txt > target/motoko.wit.diff
  exit 0
fi

for wasm_file in target/*.wasm; do
  if [ -f "$wasm_file" ]; then
    echo "=== wasm-tools print $wasm_file ==="
    wasm-tools print "$wasm_file" > "$wasm_file.$VERSION.txt"
    echo ""
  fi
done

cat target/motoko.wit > "target/motoko.wit.$VERSION.txt"




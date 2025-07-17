#!/bin/bash
(
    cd "$(dirname "$0")/.." &&


    scripts/build.sh &&
    
    echo ... running target/motoko-composed.wasm
    wasmtime run target/motoko-composed.wasm
)

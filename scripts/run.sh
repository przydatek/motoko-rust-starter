#!/bin/bash
(
    cd "$(dirname "$0")/.." &&

    echo ... building all components...
    scripts/build_rust.sh &&
    scripts/build_motoko.sh &&
    
    echo ... running target/motoko-composed.wasm
    wasmtime run target/motoko-composed.wasm
)

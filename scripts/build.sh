#!/bin/bash
export TARGET=wasm32-unknown-unknown
export BUILD_MODE=release
export MOPS_DIR=mops
(
    cd "$(dirname "$0")/.." &&

    # echo --- Build Rust component
    # cargo build --$BUILD_MODE --target $TARGET &&
    # wasm-tools component new target/$TARGET/$BUILD_MODE/ic_sig_verifier.wasm -o target/ic_sig_verifier-component.wasm &&


    # Download `wasi_snapshot_preview1` adapter (used for building the Motoko component)
    # ( curl -L https://github.com/bytecodealliance/wasmtime/releases/download/v22.0.1/wasi_snapshot_preview1.command.wasm -o target/wasi-adapter.wasm ) &&

    echo --- Build Motoko component
    # TODO: replace with `$(dfx cache show)/moc`
    echo ... running moc...
    # nix-shell ../motoko/nix/shell.nix --run "../motoko/bin/moc -wasi-system-api -wasm-components src/motoko/Main.mo -o target/motoko.wasm" &&
    ../motoko/bin/moc -wasi-system-api -wasm-components --package core ../motoko-core/src/ src/motoko/Main.mo -o target/motoko.wasm &&
    echo ... running embed...
    wasm-tools component embed src/wit/motoko.wit target/motoko.wasm -o target/motoko-embed.wasm &&
    echo ... creating component...
    wasm-tools component new target/motoko-embed.wasm -v -o target/motoko-component.wasm --adapt wasi_snapshot_preview1=target/wasi-adapter.wasm &&
    echo --- Compose components
    wac compose src/wac/composition.wac -d motoko:component=target/motoko-component.wasm -d rust:component=$MOPS_DIR/ic_sig_verifier/ic_sig_verifier.wasm -o target/motoko-composed.wasm
    echo --- Composing done!
)

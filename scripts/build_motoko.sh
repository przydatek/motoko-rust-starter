#!/bin/bash
source "$(dirname "$0")/set_env.sh"
export MOC_UNLOCK_PRIM=true
export MOTOKO_CORE_DIR="../motoko-core/src"

echo "INFO: $0 should be run in Motoko's development nix-shell,"
echo "      with moc-compiler built using PR https://github.com/dfinity/motoko/pull/5334"

ROOT_DIR=$(dirname "$(realpath $0)")/../

cd $ROOT_DIR || exit

if [ -f target/wasi-adapter.wasm  ]; then
  echo "--- WASI adapter wasi_snapshot_preview1 is present at target/wasi-adapter.wasm, skipping download"
else
  echo "--- Downloading WASI adapter wasi_snapshot_preview1 to target/wasi-adapter.wasm ..."
  ( curl -L https://github.com/bytecodealliance/wasmtime/releases/download/v22.0.1/wasi_snapshot_preview1.command.wasm -o target/wasi-adapter.wasm )
fi &&
echo --- Building Motoko component... &&
echo ... running moc... &&
../motoko/bin/moc src/motoko/Main.mo -wasi-system-api -wasm-components --package core $MOTOKO_CORE_DIR -o target/motoko.wasm &&
echo ... running embed... &&
wasm-tools component embed target/motoko.wit target/motoko.wasm -o target/motoko-embed.wasm &&
echo ... creating component... &&
wasm-tools component new target/motoko-embed.wasm -v -o target/motoko-component.wasm --adapt wasi_snapshot_preview1=target/wasi-adapter.wasm &&
echo --- Composing components... &&
wac encode target/motoko.wac -d motoko:component=target/motoko-component.wasm --deps-dir mops/ -o target/motoko-composed.wasm &&
echo --- Composing done!


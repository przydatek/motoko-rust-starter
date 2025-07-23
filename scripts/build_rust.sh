#!/bin/bash
source "$(dirname "$0")/set_env.sh"

ROOT_DIR=$(dirname "$(realpath $0)")/..
export RUST_DIR=$ROOT_DIR/src/rust

build_rust_component() {
  component_name=$1

  echo --- Building Rust component $component_name
  cd $RUST_DIR/$component_name || exit
  cargo build --$BUILD_MODE --target $TARGET &&
  wasm-tools component new target/$TARGET/$BUILD_MODE/${component_name}.wasm -o target/${component_name}.wasm &&
  echo ... Copying to mops-dir $ROOT_DIR/$MOPS_DIR/$component_name
  mkdir -pv $ROOT_DIR/$MOPS_DIR/$component_name
  cp ${component_name}.wit target/${component_name}.wasm $ROOT_DIR/$MOPS_DIR/$component_name
  cp ${component_name}.mo $ROOT_DIR/$MOPS_DIR/$component_name/lib.mo
  echo ... DONE building $component_name
}

(
  echo ___ Building Rust components...
  build_rust_component ic_sig_verifier
  build_rust_component meet_and_greet
  echo ___ DONE building Rust components.
)

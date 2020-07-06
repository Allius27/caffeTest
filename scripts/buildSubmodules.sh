#!/bin/bash

# exit on failure
set -e 

. scripts/functions.sh

PROJECT_DIR=$PWD
SUBMODULES=$PROJECT_DIR/submodules
SCRIPTS=$PROJECT_DIR/scripts

PROJECT_NAME=$(basename $PROJECT_DIR)
BUILD_DIR=$(readlink -f "$PROJECT_DIR/../$PROJECT_NAME"_build)
INSTALL_DIR="$BUILD_DIR"/install

NPROC=-j$(nproc --ignore 2)

function componentVariables () {
	COMPONENT_SOURCE_DIR="$SUBMODULES/$COMPONENT_NAME"/source
	COMPONENT_BUILD_DIR="$BUILD_DIR/$COMPONENT_NAME"_build

	mkdir -p $COMPONENT_BUILD_DIR
}

function update_submodules () {
	git submodule update --init --progress
}

for item in $(ls "$SUBMODULES"/*/build_*.sh); do 
	. $item
done


variablesOS "$1"
update_submodules
build_caffe
build_opencv
echoRed "SUCCESS"




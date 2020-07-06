#!/bin/bash


function build_caffe_build_type() {
	BUILD_TYPE=$1

	pushd "$COMPONENT_BUILD_DIR"
		cmake "$CMAKE_GENERATOR" \
			-DCMAKE_CONFIGURATION_TYPES=$BUILD_TYPE \
			-DCMAKE_INSTALL_PREFIX=$INSTALL_DIR \
			-DBUILD_python=OFF \
			$COMPONENT_SOURCE_DIR

		$MAKE "$NPROC"
		$MAKE install
	popd
}

function build_caffe() {
	
	COMPONENT_NAME="caffe"
	componentVariables

	build_caffe_build_type Release
}
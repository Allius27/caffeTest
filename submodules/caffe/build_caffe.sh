#!/bin/bash


function build_caffe_build_type() {
	BUILD_TYPE=$1

	pushd "$COMPONENT_BUILD_DIR"
		cmake "$CMAKE_GENERATOR" \
			-DCMAKE_CONFIGURATION_TYPES=$BUILD_TYPE \
			-DCMAKE_INSTALL_PREFIX=$INSTALL_DIR \
			-DBUILD_python=OFF \
			-DOpenCV_DIR=$INSTALL_DIR/lib/cmake/opencv4 \
			-DMKLDNN_INSTALL_DIR=$INSTALL_DIR \
			$COMPONENT_SOURCE_DIR

		$MAKE "$NPROC"
		$MAKE install
	popd
}

function addSourceTobashrc() {
	echo "source $COMPONENT_SOURCE_DIR/external/mlsl/l_mlsl_2018.1.005//intel64/bin/mlslvars.sh" >> ~/.bashrc
	echo "PATH=\$PATH:$INSTALL_DIR/bin" >> ~/.bashrc
}

function build_caffe() {
	
	COMPONENT_NAME="caffe"
	componentVariables

	build_caffe_build_type Release
	addSourceTobashrc
}
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
			-DMKLDNN_LIB_DIR=$INSTALL_DIR/lib \
			$COMPONENT_SOURCE_DIR

		# fix bug with building one of submodules caffe
		find . -name \( -name "*.cmake" -o -name "*.make" \) \
			   -exec sed -e 's!/lib64/libmkldnn.so!/lib/libmkldnn.so/!' \
			   -i {} \;

		$MAKE "$NPROC"
		$MAKE install
	popd
}

function copyIntelLibs() {
	cp -rf ./caffe/external/mlsl/l_mlsl_2018.1.005/intel64/lib/* $INSTALL_DIR/lib
}

function build_caffe() {
	
	COMPONENT_NAME="caffe"
	componentVariables

	# build_caffe_build_type Release
	copyIntelLibs
}
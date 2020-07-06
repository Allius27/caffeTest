

function build_opencv_build_type() {
	BUILD_TYPE=$1

	pushd "$COMPONENT_BUILD_DIR"
		cmake "$CMAKE_GENERATOR" \
			-DCMAKE_CONFIGURATION_TYPES=$BUILD_TYPE \
			-DCMAKE_INSTALL_PREFIX=$INSTALL_DIR \
			-DWITH_OPENNI2=ON \
			-DWITH_IPP=OFF \
			-DWITH_ADE=OFF \
			-DBUILD_opencv_world=ON \
			"$WINDOWS_ADDITIONAL" \
			$COMPONENT_SOURCE_DIR

		$MAKE "$NPROC"
		$MAKE install
	popd
}

function build_opencv() {
	
	COMPONENT_NAME="opencv"
	componentVariables

	build_opencv_build_type Release
}
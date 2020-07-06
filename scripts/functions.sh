
# $1 - string
function echoRed () {
	echo -e "\e[31m$1 \e[0m"
}

# $1 - string
function echoBlue () {
	echo -e "\e[34m$1 \e[0m"
}

# $1 - string
function echoYellow () {
	echo -e "\e[33m$1 \e[0m"	
}

# $1 - linux or windows
function variablesOS () {
	case "$1" in
	"linux" )
		CMAKE_GENERATOR="";
		MAKE="make"
	 ;;

	"windows" )
		CMAKE_GENERATOR="-GMinGW Makefiles";
		MAKE="mingw32-make"
		WINDOWS_ADDITIONAL="-DOPENCV_ENABLE_ALLOCATOR_STATS=OFF"
	 ;;

	*)
		echo "Please specify linux or windows"
		exit 2
	;;

	esac
}
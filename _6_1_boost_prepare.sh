#!/bin/bash -xe

# $1 contains boost version prefix (e.g. "1_74_0")

boostVersion=$1
boostVersionDots=`echo ${boostVersion} | tr _ .`

# Attention! Boost 1.71 and 1.72 have a bug: boost:process::child used by SystemUtils::Run()
# doesn't start process if a system executable is located in the first directory enlisted by env var 'PATH='
# See original issue: https://github.com/boostorg/process/issues/121

# We use a patch
patch_boost_process_issue_121() {
	sed -i "s/boost\:\:split(path, \*e/boost::split(path, *e + 5/g" ./boost_${boostVersion}/boost/process/detail/posix/executor.hpp
}

patch_boost_signals2_issue() {
	if [ "${boostVersion}" = "1_74_0" ]; then
		patch -s -p0 < ./../patches/boost_signals2_detail_null_output_iterator.patch
	fi
}


if [ -f  ~/user-config.jam ]; then
	rm ~/user-config.jam
fi

if [ ! -f boost_${boostVersion}.tar.gz ]; then
    wget https://dl.bintray.com/boostorg/release/${boostVersionDots}/source/boost_${boostVersion}.tar.gz
fi

extract_sources() {
	
	# if there is a previous build
	rm -rf ./${boostVersion}
	rm -rf ./boost_${boostVersion}
	rm -rf ./zlib

	tar xf boost_${boostVersion}.tar.gz
	patch_boost_signals2_issue
	patch_boost_process_issue_121
}

extract_sources
pushd ./boost_${boostVersion}
git clone https://github.com/madler/zlib.git
popd
#!/bin/bash -x

# $1 contains openssl version postfix (e.g. "1.1.1h")

if [ ! -d install-$1 ]; then
	echo "Failed to build OpenSSL $1"
	exit 5
fi

rm -rf openssl-$1

set +x

echo "Congratulations! The openssl $1 library is successfully built"
echo "You can define Directory.Build.targets in your project root directory with the following text:"
echo ""
echo "<Project>"
echo "	<PropertyGroup>"
echo "		<IncludePath>$(IncludePath);c:\_3rd_party\openssl\install-$1\include</IncludePath>"
echo "		<LibraryPath>$(LibraryPath);c:\_3rd_party\openssl\install-$1\lib</LibraryPath>"
echo "	</PropertyGroup>"
echo "</Project>"

set -x

echo "Finished"

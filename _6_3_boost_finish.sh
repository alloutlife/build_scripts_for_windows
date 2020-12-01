#!/bin/bash -xe

# $1 contains boost version prefix (e.g. "1_74_0")

if [ ! -d  ./boost_$1/ ]; then
	echo "There is no boost_$1 directory"
	exit 2
fi

# Moving the result to the directory named $1
mkdir $1

mv ./boost_$1/boost ./$1/
mv ./boost_$1/stage* ./$1/

rm -rf ./boost_$1

set +x

echo "Congratulations! The boost_$1 library is successfully built"
echo "You can define Directory.Build.targets in your project root directory with the following text:"
echo ""
echo '<Project>'
echo '	<PropertyGroup>'
echo '		<IncludePath>$(IncludePath);c:\_3rd_party\boost\1_74_0</IncludePath>'
echo '		<LibraryPath>$(LibraryPath);c:\_3rd_party\boost\1_74_0\stage_vs141\lib</LibraryPath>'
echo '	</PropertyGroup>'
echo ''
echo '	<!-- this suppresses bind.hpp pragma message -->'
echo '	<ItemDefinitionGroup>'
echo '		<ClCompile>'
echo '			<PreprocessorDefinitions>BOOST_BIND_GLOBAL_PLACEHOLDERS;%(PreprocessorDefinitions)</PreprocessorDefinitions>'
echo '		</ClCompile>'
echo '	</ItemDefinitionGroup>'
echo ''
echo '</Project>'

set -x

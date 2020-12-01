@echo off

rem #6 - boost.org

set boostVersion="1_74_0"

if not exist "c:\_3rd_party" (
	mkdir c:\_3rd_party
)

if not exist "c:\_3rd_party\boost" (
	mkdir c:\_3rd_party\boost
)

rem copy build scripts to dest directory
copy 6*.cmd c:\_3rd_party\boost\ /Y
copy _6*.cmd c:\_3rd_party\boost\ /Y
copy _6*.sh c:\_3rd_party\boost\ /Y
xcopy patches c:\_3rd_party\patches\ /Y

pushd .

c:
cd c:\_3rd_party\boost

rem Prepare environment
bash -c "./_6_1_boost_prepare.sh %boostVersion%"

rem Build
call _6_2_boost_build.cmd %boostVersion%

rem Post build action
bash -c "./_6_3_boost_finish.sh %boostVersion%"

popd

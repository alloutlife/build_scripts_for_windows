@echo off

rem #2 - OpenSSL
rem Prerequisits: 
rem		- nasm-2.15.05-installer-x86.exe (manually add NASM directory to %PATH% env variable)
rem		- ActiveState Perl of the latest version
rem 	- execute $ ppm install dmake

set opensslVer="1.1.1h"

if not exist "c:\_3rd_party" (
	mkdir c:\_3rd_party
)

if not exist "c:\_3rd_party\openssl" (
	mkdir c:\_3rd_party\openssl
)

rem copy build scripts to dest directory
copy 2*.cmd c:\_3rd_party\openssl\ /Y
copy _2*.cmd c:\_3rd_party\openssl\ /Y
copy _2*.sh c:\_3rd_party\openssl\ /Y

pushd .

c:
cd c:\_3rd_party\openssl

bash -c "./_2_1_openssl_prepare.sh %opensslVer%"

call _2_2_openssl_build.cmd %opensslVer%

bash -c "./_2_3_openssl_finish.sh %opensslVer%"

popd
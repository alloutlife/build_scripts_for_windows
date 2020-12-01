@echo off

rem First argument must contain openssl version postfix (e.g. "1.1.1h")

rem Prerequisites: Perl 
where perl 1>nul 2>nul
if not %errorlevel% EQU 0 (
	echo "Perl is not installed"
	EXIT /B 3
)

pushd .
cd openssl-%~1/

set "VS2017_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2017"
if not exist "%VS2017_PATH%" (
	echo "Visual Studio 2017 not found!"
	EXIT /B 4
) else (
	call "%VS2017_PATH%\enterprise\Common7\Tools\vsdevcmd.bat" -no_logo
)

perl Configure VC-WIN32 no-shared --prefix="%CD%\..\install-%~1"
nmake
nmake test
nmake install

popd
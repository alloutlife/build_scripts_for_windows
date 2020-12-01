@echo off

rem First argument must contain boost version postfix (e.g. "1_74_0")

if not exist "boost_%~1" (
	echo 
	EXIT /B 1
)

cd boost_%~1

if not exist "b2.exe" call bootstrap

IF "%VS120COMNTOOLS%" NEQ "" (

	b2 -j16 --with-log --with-iostreams --with-locale --with-chrono --with-date_time --with-regex --with-system --with-thread --with-serialization --with-program_options --with-filesystem --build-type=minimal toolset=msvc-12.0 --stagedir=stage_vs120 -sZLIB_SOURCE="%CD%\zlib"
	b2 -j16 --with-log --with-iostreams --with-locale --with-chrono --with-date_time --with-regex --with-system --with-thread --with-serialization --with-program_options --with-filesystem --build-type=minimal toolset=msvc-12.0 --stagedir=stage_vs120 runtime-link=static -sZLIB_SOURCE="%CD%\zlib"
	
	REM Внимание! По умолчанию, VS2013 собирает исходный код с включением поддержки SSE2. Чтобы выключить SSE2, необходимо добавить опцию компилятора: arch:IA32
	REM Кроме того, имеет смысл обезопаситься от генерации параллельного кода: /Qpar-
	REM cflags="/arch:IA32 /Qpar-" cxxflags="/arch:IA32 /Qpar-"
	REM Не забыть о том, что сборками boost пользуется как серверное, так и терминальное ПО.
	REM Следует предусмотреть различные варианты сборок: с оптимизацией и без, которые бы размещались в различных директориях stage (например, --stagedir=./stage_no_sse)
)

set "VS2017_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2017"
if exist "%VS2017_PATH%" (
	call "%VS2017_PATH%\enterprise\Common7\Tools\vsdevcmd.bat" -no_logo
	
	b2 -j16 --with-log --with-iostreams --with-locale --with-chrono --with-date_time --with-regex --with-system --with-thread --with-serialization --with-program_options --with-filesystem --build-type=minimal toolset=msvc-14.1 --stagedir=stage_vs141 -sZLIB_SOURCE="%CD%\zlib"
	b2 -j16 --with-log --with-iostreams --with-locale --with-chrono --with-date_time --with-regex --with-system --with-thread --with-serialization --with-program_options --with-filesystem --build-type=minimal toolset=msvc-14.1 --stagedir=stage_vs141 runtime-link=static -sZLIB_SOURCE="%CD%\zlib"
)

cd ..
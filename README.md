# Compiling 3rd party libraries for further use in MS Visual Studio 2017 #

Although `vcpkg` solves the problem..

Some of the scripts are written in bash, so you need a linux-based bash processor (I prefer Debian) available for MS Windows 10 (https://itsfoss.com/install-bash-on-windows/)
There are also some patches for boost 1.74 included in the repo.

All you need is to perform root scripts in cmd (name starts with a number) and wait till it's finished.
As a result you have c:\_3rd_party directory with the libraries ready to be referenced in your own projects.
There is also a recommendation of how to introduce additional include and lib directories to your projects.

## Additional prerequisites ##

1. Active State Perl (latest version)
1. `> ppm install dmake`
1. nasm-2.15.05-installer-x86.exe (manually add NASM binaries directory to %PATH%)
1. Linux shell (see https://itsfoss.com/install-bash-on-windows/), after being installed you need to 


# Libraries # 

1. OpenSSL 1.1.1h for vs141
1. Boost 1.74.0 for vs141
1. Boost 1.74.0 for vs120

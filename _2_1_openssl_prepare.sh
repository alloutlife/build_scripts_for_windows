#! /bin/bash -xe

# $1 contains openssl version postfix (e.g. "1.1.1h")

if [ ! -f openssl-$1.tar.gz ]; then
	wget https://www.openssl.org/source/openssl-$1.tar.gz
fi

rm -rf openssl-$1
rm -rf install-$1
tar xf openssl-$1.tar.gz


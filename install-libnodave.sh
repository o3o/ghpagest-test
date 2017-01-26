#!/bin/sh
git clone git://github.com/netdata/libnodave.git 
cd libnodave
make
make install
cd ..

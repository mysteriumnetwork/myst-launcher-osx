#!/bin/sh

clang -c -x objective-c interface.m -o interface.o
CC=clang go build -o gobridge.dylib -buildmode=c-shared *.go

# set proper LC_ID_DYLIB. @rpath - means a library could be found in runtime path.
# otherwise app (dynamic linker) wont be be able to find it during start.
# by default there's no @rpath prefix

install_name_tool -id "@rpath/gobridge.dylib" gobridge.dylib

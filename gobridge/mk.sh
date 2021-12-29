#!/bin/sh

#arm64
clang -arch arm64 -c -x objective-c interface.m -o interface.o
CGO_ENABLED=1 GOOS=darwin GOARCH=arm64 CC=clang go build -ldflags "-s -w" -o gobridge_arm64.dylib -buildmode=c-shared *.go

#amd64
clang -arch x86_64 -c -x objective-c interface.m -o interface.o
CGO_ENABLED=1 GOOS=darwin GOARCH=amd64 CC=clang go build -ldflags "-s -w" -o gobridge_amd64.dylib -buildmode=c-shared *.go

# merge 2 into 1
lipo -create -output gobridge.dylib gobridge_amd64.dylib gobridge_arm64.dylib

# set proper LC_ID_DYLIB. @rpath - means a library could be found in runtime path.
# otherwise app (dynamic linker) wont be be able to find it during start.
# by default there's no @rpath prefix

install_name_tool -id "@rpath/gobridge.dylib" gobridge.dylib
